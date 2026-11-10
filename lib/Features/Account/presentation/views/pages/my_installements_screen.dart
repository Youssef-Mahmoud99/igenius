import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:igenius/Features/payment/presentation/cubits/pay_installment_cubit.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import 'package:igenius/injection/service_locator.dart';
import '../../../../../core/base/cubit/base_state.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/toast_helper.dart';
import '../../../../Courses/presentation/cubits/courses/courses_cubit.dart';
import '../../../../Courses/presentation/views/pages/payment_screen.dart';
import '../../../../payment/data/models/installment_model.dart';
import '../../../../payment/data/models/pay_installment_params.dart';
import '../../../../payment/data/models/payment_response.dart';
import '../../../../payment/presentation/cubits/get_installments_cubit.dart';

const String _currency = 'EGP'; // غيّرها لـ '\$' لو عايز زي الشيت

class InstallmentsPage extends StatelessWidget {
  const InstallmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<GetInstallmentsCubit>()..refresh()),
        BlocProvider(create: (_) => sl<PayInstallmentCubit>()),
BlocProvider.value(value: sl<CoursesCubit>()),      ],
      child: const _InstallmentsView(),
    );
  }
}

class _InstallmentsView extends StatefulWidget {
  const _InstallmentsView();

  @override
  State<_InstallmentsView> createState() => _InstallmentsViewState();
}

class _InstallmentsViewState extends State<_InstallmentsView> {
  final _scroll = ScrollController();
  int? _payingId;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(() {
      if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 200) {
        context.read<GetInstallmentsCubit>().loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _pay(int id) {
    if (_payingId != null) return;
    setState(() => _payingId = id);
    context.read<PayInstallmentCubit>().payInstallment(
      PayInstallmentParams(method: "paymob_card", id: id),
    );
  }

  String? _extractCheckoutUrl(dynamic raw) {
    final data = raw is BaseResponse ? raw.data : raw;
    if (data is PaymentResponseModel) return data.checkoutUrl;
    if (data is Map) {
      return (data['checkout_url'] ?? data['checkoutUrl'])?.toString();
    }
    return null;
  }

  CoursesCubit? _tryGetCoursesCubit(BuildContext context) {
    try {
      return context.read<CoursesCubit>();
    } catch (_) {
      return null;
    }
  }

  void _refreshCourses(BuildContext context) {
    try {
      context.read<CoursesCubit>().refreshCourses();
    } catch (_) {
      // لو الصفحة مفتوحة من مكان ملوش CoursesCubit في الـ context
      final cubit = sl<CoursesCubit>();
      cubit.refreshCourses();
    }
  }

  Future<void> _openPayment(String url) async {
    final coursesCubit = _tryGetCoursesCubit(context);

    Navigator.of(context).pop();
    final result = await GoRouter.of(context).push<PaymentResult>(
      AppRoutes.paymentWebViewScreen,
      extra: {'paymentUrl': url},
    );

    if (result?.status == PaymentStatus.failed) {
      if (result?.reason != null) {
        ToastHelper.showWarning(result!.reason!);
      }
      return;
    }

    // success أو unknown: fetch جديد للكورسات
    // (الـ webhook ممكن يتأخر ثواني، فنستنى شوية)
    await Future.delayed(const Duration(seconds: 2));
    coursesCubit?.refreshCourses();
    if (coursesCubit == null) _refreshCourses(context);
    if (mounted) context.read<GetInstallmentsCubit>().refresh();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PayInstallmentCubit, BaseCubitState>(
          listener: (context, state) async {
            if (state is ErrorState) {
              setState(() => _payingId = null);
              ToastHelper.showWarning(state.message.toString());
            }
            if (state is SuccessState) {
              final url = _extractCheckoutUrl(state.data);
              setState(() => _payingId = null);
              if (url == null) {
                ToastHelper.showWarning("Payment link not available");
                return;
              }
              await _openPayment(url);
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xffF7F7FA),
        appBar: AppBar(
          title: Text('My Installments', style: AppsStyles.s16Bold),
          centerTitle: true,
          backgroundColor: AppColors.white,
          elevation: 0,
        ),
        body: BlocConsumer<GetInstallmentsCubit, BaseCubitState>(
          listener: (context, state) {
            final cubit = context.read<GetInstallmentsCubit>();
            if (state is SuccessState) {
              final res =
                  state.data as BaseResponse<List<InstallmentRequestModel>>;
              cubit.onPageLoaded(res.data ?? []);
            } else if (state is ErrorState) {
              cubit.onPageFailed();
              if (cubit.items.isNotEmpty) {
                ToastHelper.showWarning(state.message.toString());
              }
            }
          },
          builder: (context, state) {
            final cubit = context.read<GetInstallmentsCubit>();
            final items = cubit.items;

            if (items.isEmpty) {
              if (state is ErrorState) {
                return _CenterMessage(
                  icon: Icons.error_outline,
                  text: state.message.toString(),
                  actionText: 'Retry',
                  onAction: cubit.refresh,
                );
              }
              if (state is SuccessState) {
                return const _CenterMessage(
                  icon: Icons.receipt_long_outlined,
                  text: 'No installment requests yet',
                );
              }
              return const Center(child: CircularProgressIndicator());
            }

            return RefreshIndicator(
              onRefresh: cubit.refresh,
              child: ListView.separated(
                controller: _scroll,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                itemCount: items.length + (cubit.isLoadingMore ? 1 : 0),
                separatorBuilder: (_, __) => 12.verticalSpace,
                itemBuilder: (context, i) {
                  if (i >= items.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return _PlanCard(
                    plan: items[i],
                    payingId: _payingId,
                    onPay: _pay,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

// ===================== Plan card =====================

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.plan,
    required this.payingId,
    required this.onPay,
  });

  final InstallmentRequestModel plan;
  final int? payingId;
  final void Function(int id) onPay;

  @override
  Widget build(BuildContext context) {
    final installments = plan.installments ?? [];
    final paidCount = installments.where((e) => e.isPaid == true).length;
    final progress =
        installments.isEmpty ? 0.0 : paidCount / installments.length;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  plan.course?.title ?? '-',
                  style: AppsStyles.s14Bold,
                ),
              ),
              8.horizontalSpace,
              _StatusChip(status: plan.status ?? ''),
            ],
          ),
          8.verticalSpace,
          Wrap(
            spacing: 14,
            runSpacing: 4,
            children: [
              _meta(
                Icons.calendar_month_outlined,
                '${plan.requiredMonths} months plan',
              ),
              _meta(
                Icons.event_note_outlined,
                'Requested ${_fmtDate(plan.requestedAt)}',
              ),
            ],
          ),
          if (plan.status == 'rejected' &&
              (plan.rejectionReason ?? '').isNotEmpty) ...[
            10.verticalSpace,
            _InfoBox(
              color: Colors.red,
              icon: Icons.info_outline,
              text: plan.rejectionReason!,
            ),
          ],
          if (plan.status == 'pending') ...[
            10.verticalSpace,
            const _InfoBox(
              color: Colors.orange,
              icon: Icons.hourglass_bottom_rounded,
              text:
                  'Your request is under review. Installments will appear once approved.',
            ),
          ],
          if (installments.isNotEmpty) ...[
            14.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Progress', style: AppsStyles.s12Bold),
                Text(
                  '$paidCount / ${installments.length} paid',
                  style: AppsStyles.s12Regular.copyWith(
                    color: AppColors.greyDarker,
                  ),
                ),
              ],
            ),
            6.verticalSpace,
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                backgroundColor: AppColors.borderGrey,
                valueColor: const AlwaysStoppedAnimation(Colors.green),
              ),
            ),
            12.verticalSpace,
            ...List.generate(installments.length, (i) {
              final item = installments[i];
              return _InstallmentTile(
                index: i + 1,
                item: item,
                isPaying: payingId == item.id,
                disabled: payingId != null,
                onPay: () => onPay(item.id!),
              );
            }),
          ],
        ],
      ),
    );
  }

  Widget _meta(IconData icon, String text) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 14.r, color: AppColors.greyDarker),
      4.horizontalSpace,
      Text(
        text,
        style: AppsStyles.s12Regular.copyWith(color: AppColors.greyDarker),
      ),
    ],
  );
}

// ===================== Installment tile =====================

class _InstallmentTile extends StatelessWidget {
  const _InstallmentTile({
    required this.index,
    required this.item,
    required this.isPaying,
    required this.disabled,
    required this.onPay,
  });

  final int index;
  final InstallmentDetailsModel item;
  final bool isPaying;
  final bool disabled;
  final VoidCallback onPay;

  @override
  Widget build(BuildContext context) {
    final paid = item.isPaid == true;
    final overdue = !paid && item.isOverdue == true;

    final Color color =
        paid
            ? Colors.green
            : overdue
            ? Colors.red
            : Colors.orange;
    final String label =
        paid
            ? 'Paid'
            : overdue
            ? 'Overdue'
            : 'Upcoming';

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.35)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14.r,
            backgroundColor: color.withOpacity(0.15),
            child:
                paid
                    ? Icon(Icons.check, size: 16.r, color: color)
                    : Text(
                      '$index',
                      style: AppsStyles.s12Bold.copyWith(color: color),
                    ),
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$_currency ${_fmtAmount(item.amount)}',
                  style: AppsStyles.s14Bold,
                ),
                2.verticalSpace,
                Text(
                  paid
                      ? 'Paid on ${_fmtDate(item.paidAt)}'
                      : 'Due ${_fmtDate(item.dueDate)}',
                  style: AppsStyles.s12Regular.copyWith(
                    color: AppColors.greyDarker,
                  ),
                ),
                if (!paid && (item.forgivenessDays ?? 0) > 0)
                  Text(
                    '${item.forgivenessDays} days grace period',
                    style: AppsStyles.s12Regular.copyWith(
                      color: AppColors.greyDarker,
                    ),
                  ),
              ],
            ),
          ),
          if (paid || overdue)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                label,
                style: AppsStyles.s12Bold.copyWith(color: color),
              ),
            ),
          if (!paid) ...[
            8.horizontalSpace,
            SizedBox(
              height: 34.h,
              child: ElevatedButton(
                onPressed: disabled ? null : onPay,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child:
                    isPaying
                        ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                        : Text(
                          'Pay',
                          style: AppsStyles.s12Bold.copyWith(
                            color: Colors.white,
                          ),
                        ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ===================== Small widgets =====================

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      'approved' => Colors.green,
      'rejected' => Colors.red,
      _ => Colors.orange,
    };
    final text =
        status.isEmpty ? '-' : status[0].toUpperCase() + status.substring(1);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: AppsStyles.s12Bold.copyWith(color: color)),
    );
  }
}

class _InfoBox extends StatelessWidget {
  const _InfoBox({required this.color, required this.icon, required this.text});
  final Color color;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16.r, color: color),
          8.horizontalSpace,
          Expanded(
            child: Text(
              text,
              style: AppsStyles.s12Regular.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}

class _CenterMessage extends StatelessWidget {
  const _CenterMessage({
    required this.icon,
    required this.text,
    this.actionText,
    this.onAction,
  });
  final IconData icon;
  final String text;
  final String? actionText;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48.r, color: AppColors.greyDarker),
            12.verticalSpace,
            Text(text, textAlign: TextAlign.center, style: AppsStyles.s14Bold),
            if (actionText != null) ...[
              12.verticalSpace,
              TextButton(onPressed: onAction, child: Text(actionText!)),
            ],
          ],
        ),
      ),
    );
  }
}

// ===================== Formatters =====================

const _months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

String _fmtDate(String? raw) {
  final d = DateTime.tryParse(raw ?? '');
  if (d == null) return '-';
  return '${d.day} ${_months[d.month - 1]} ${d.year}';
}

String _fmtAmount(num? v) {
  final n = v ?? 0;
  final s =
      n == n.roundToDouble() ? n.toStringAsFixed(0) : n.toStringAsFixed(2);
  return s.replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => ',');
}
