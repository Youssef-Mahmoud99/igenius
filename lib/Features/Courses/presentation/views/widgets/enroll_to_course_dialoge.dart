import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:igenius/Features/payment/presentation/cubits/buy_course_cubit.dart';
import 'package:igenius/Features/payment/presentation/cubits/pay_installment_cubit.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import 'package:igenius/core/utils/helpers/app_navigtion.dart';
import 'package:igenius/core/widgets/custom_text.dart';
import 'package:igenius/core/widgets/primary_button.dart';
import 'package:igenius/injection/service_locator.dart';
import '../../../../../core/base/cubit/base_state.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/toast_helper.dart';
import '../../../../../core/widgets/gradient_button.dart';
import '../../../../payment/data/models/buy_course_params.dart';
import '../../../../payment/data/models/installment_model.dart';
import '../../../../payment/data/models/installment_params.dart';
import '../../../../payment/data/models/pay_installment_params.dart';
import '../../../../payment/data/models/payment_response.dart';
import '../../../../payment/presentation/cubits/request_installment_plan_cubit.dart';
import '../../../../payment/presentation/cubits/request_two_month_installement.dart';
import '../../../data/models/course_details.dart';
import '../pages/payment_screen.dart';

/// نوع الأقساط
enum InstallmentType { twoMonths, multiMonths }

Future<String?> showEnrollToCourseBottomSheet(
  BuildContext context,
  CourseDetails courseDetails,
) {
  return showModalBottomSheet<String?>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder:
        (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => sl<RequestInstallmentPlanCubit>()),
            BlocProvider(create: (context) => sl<RequestTwoMonthInstallement>()),
            BlocProvider(create: (context) => sl<BuyCourseCubit>()),
            BlocProvider(create: (context) => sl<PayInstallmentCubit>()),
          ],
          child: EnrollToCourseBottomSheet(courseDetails: courseDetails),
        ),
  );
}

class EnrollToCourseBottomSheet extends StatefulWidget {
  const EnrollToCourseBottomSheet({required this.courseDetails, Key? key})
    : super(key: key);
  final CourseDetails courseDetails;

  @override
  State<EnrollToCourseBottomSheet> createState() =>
      _EnrollToCourseBottomSheetState();
}

class _EnrollToCourseBottomSheetState extends State<EnrollToCourseBottomSheet> {
  /// 0 = Pay in Full   |   1 = Installments
  int _selectedTabIndex = 0;

  /// نوع القسط المختار
  InstallmentType _installmentType = InstallmentType.twoMonths;

  /// عدد الشهور المختار في نوع "شهور كتير"
  int _selectedMonths = 3;
  static const List<int> _multiMonthOptions = [3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  /// عشان نمنع الضغط المتكرر أثناء تنفيذ العملية
  bool _isProcessing = false;

  final List<String> courseEnrollBenefits = const [
    'Lifetime access to all course materials',
    'Certificate of completion',
    'Access to live sessions & recordings',
    'Direct support from instructor',
  ];

  // ===================== Helpers =====================

  double get _coursePrice {
    final d = widget.courseDetails;
    final raw = d.hasDiscount == true ? d.priceAfterDiscount : d.price;
    return double.tryParse(raw.toString()) ?? 0;
  }

  String _fmt(double v) =>
      v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toStringAsFixed(2);

  void _setProcessing(bool value) {
    if (!mounted || _isProcessing == value) return;
    setState(() => _isProcessing = value);
  }

  void _onTabTapped(int index) {
    if (_selectedTabIndex == index) return;
    setState(() => _selectedTabIndex = index);
  }

  /// يستخرج لينك الدفع من أي شكل للـ response
  String? _extractCheckoutUrl(dynamic raw) {
    final data = raw is BaseResponse ? raw.data : raw;
    if (data is PaymentResponseModel) return data.checkoutUrl;
    if (data is Map) {
      return (data['checkout_url'] ?? data['checkoutUrl'])?.toString();
    }
    return null;
  }

  /// يفتح صفحة الدفع، وبعد ما يرجع يقفل الشيت ويرجّع النتيجة
/// يفتح صفحة الدفع، وبعد ما يرجع يقفل الشيت.
/// true  = الدفع نجح من اللينك
/// false = فشل صريح
/// null  = مش متأكدين (back / redirect لـ login) -> الـ caller يسأل السيرفر
Future<void> _openPaymentAndClose(String url) async {
  if (!mounted) return;
  _setProcessing(false);
  Navigator.of(context).pop(url); // نرجّع اللينك بس
}
  void _submitInstallments() {
    if (_isProcessing) return;
    _setProcessing(true);

    if (_installmentType == InstallmentType.twoMonths) {
      // 1) اطلب خطة الشهرين (بتتوافق تلقائي) -> 2) ادفع أول قسط
      context.read<RequestTwoMonthInstallement>().requestInstallment(
        widget.courseDetails.id.toString(),
      );
    } else {
      context.read<RequestInstallmentPlanCubit>().requestInstallment(
        InstallmentParams(
          courseId: widget.courseDetails.id,
          requiredMonths: _selectedMonths,
        ),
      );
    }
  }

  // ===================== Build =====================

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 10,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            titleandClose(),
            10.verticalSpace,
            courseInfoCard(widget.courseDetails),
            10.verticalSpace,
            if (widget.courseDetails.hasInstallmentPlan!) ...[
              pillTabsHeader(),
              10.verticalSpace,
              IndexedStack(
                index: _selectedTabIndex,
                alignment: Alignment.topCenter,
                children: [
                  fullPaymentTab(widget.courseDetails),
                  installmentsTab(),
                ],
              ),
            ] else
              fullPaymentTab(widget.courseDetails),
          ],
        ),
      ),
    );
  }

  // ===================== Shared widgets =====================

  Widget titleandClose() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Enroll in Course", style: AppsStyles.s16Bold),
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close, size: 20.r),
        ),
      ],
    );
  }

  Widget courseInfoCard(CourseDetails details) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        color: const Color(0xffFDF2F8),
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(text: details.title!, style: AppsStyles.s12Bold),
            5.verticalSpace,
            10.horizontalSpace,
            Row(
              children: [
                courseDetailsDisplay(
                  Icons.menu_book,
                  "${widget.courseDetails.totalLessons} Lessons",
                ),
                courseDetailsDisplay(
                  Icons.access_time_rounded,
                  "${widget.courseDetails.durationWeeks} Weeks",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget courseDetailsDisplay(IconData icon, String data) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.greyDarker, size: 15.r),
          5.horizontalSpace,
          Text(
            data,
            style: AppsStyles.s12Regular.copyWith(color: AppColors.greyDarker),
          ),
        ],
      ),
    );
  }

  // ===================== Pill-style tabs =====================

  Widget pillTabsHeader() {
    return Container(
      height: 44.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.borderGrey, width: 1),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(child: _pillTab(index: 0, label: 'Pay in Full')),
          Expanded(child: _pillTab(index: 1, label: 'Installments')),
        ],
      ),
    );
  }

  Widget _pillTab({required int index, required String label}) {
    final bool isSelected = _selectedTabIndex == index;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _onTabTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient:
              isSelected
                  ? const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xff1B2A4A), Color(0xff8A1538)],
                  )
                  : null,
          color: isSelected ? null : Colors.transparent,
        ),
        child: Text(
          label,
          style: AppsStyles.s14Bold.copyWith(
            color: isSelected ? AppColors.white : AppColors.black,
          ),
        ),
      ),
    );
  }

  // ===================== Tab 1: Pay in Full =====================

  Widget fullPaymentTab(CourseDetails details) {
    return BlocListener<BuyCourseCubit, BaseCubitState>(
      listener: (context, state) async {
        if (state is ErrorState) {
          print("Error: ${state.message}");
        }
        if (state is SuccessState) {
          final response = state.data as BaseResponse<PaymentResponseModel>;
          final paymentResponse = response.data;
          if (paymentResponse?.checkoutUrl == null) return;

          await _openPaymentAndClose(paymentResponse!.checkoutUrl!);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          moneyDisplay(
            AppColors.greyDarker,
            AppColors.greyDarker,
            'Course Price',
            "\$${details.price}",
          ),
          5.verticalSpace,
          details.hasDiscount == true
              ? moneyDisplay(
                AppColors.green,
                AppColors.green,
                'Limited Time Discount',
                "-\$${double.parse(details.priceAfterDiscount.toString()) - double.parse(details.price.toString())}",
              )
              : const SizedBox.shrink(),
          5.verticalSpace,
          const Divider(color: Colors.grey, height: 1, thickness: 1),
          10.verticalSpace,
          moneyDisplay(
            AppColors.black,
            AppColors.primary,
            'Total',
            "\$${details.hasDiscount == true ? details.priceAfterDiscount : details.price}",
            textStyle: AppsStyles.s14Bold,
          ),
          10.verticalSpace,
          includedCard(),
          10.verticalSpace,
          GradientButton(
            height: 40.h,
            text: 'Complete Enrollment',
            onTap: () {
               if (_isProcessing) return;
  _setProcessing(true);
              context.read<BuyCourseCubit>().buyCourse(
                BuyCourseParams(
                  method: "paymob_card",
                  id: widget.courseDetails.id!,
                ),
              );
            },
          ),
          10.verticalSpace,
          Appbutton(
            height: 40.h,
            borderRadius: 12,
            borderColor: AppColors.grey,
            needBorder: true,
            color: AppColors.white,
            textColor: AppColors.black,
            onPressed: () {
Navigator.of(context).pop();            },
            text: 'Cancel',
          ),
        ],
      ),
    );
  }

  // ===================== Tab 2: Installments =====================

  Widget installmentsTab() {
    final total = _coursePrice;
    final twoMonthsMonthly = total / 2;
    final multiMonthly = _selectedMonths == 0 ? 0 : total / _selectedMonths;

    final isTwoMonths = _installmentType == InstallmentType.twoMonths;

    return MultiBlocListener(
      listeners: [
        // 1) رد خطة الشهرين -> خد id أول قسط وادفعه
        BlocListener<RequestTwoMonthInstallement, BaseCubitState>(
          listener: (context, state) {
            if (state is ErrorState) {
              _setProcessing(false);
              ToastHelper.showWarning(state.message.toString());
            }
            if (state is SuccessState) {
              final response =
                  state.data as BaseResponse<InstallmentRequestModel>;
              final installments = response.data?.installments;
              final int? firstInstallmentId =
                  (installments != null && installments.isNotEmpty)
                      ? installments.first.id
                      : null;
               
              if (firstInstallmentId == null) {
                _setProcessing(false);
                ToastHelper.showWarning("No installment found to pay");
                return;
              }

              context.read<PayInstallmentCubit>().payInstallment(
                PayInstallmentParams(
                  method: "paymob_card",
                  id: firstInstallmentId,
                ),
              );
            }
          },
        ),

        // 2) رد دفع القسط -> افتح صفحة الدفع
        BlocListener<PayInstallmentCubit, BaseCubitState>(
          listener: (context, state) async {
            if (state is ErrorState) {
              _setProcessing(false);
              ToastHelper.showWarning(state.message.toString());
            }
            if (state is SuccessState) {
              final url = _extractCheckoutUrl(state.data);
              if (url == null) {
                _setProcessing(false);
                ToastHelper.showWarning("Payment link not available");
                return;
              }
              await _openPaymentAndClose(url);
            }
          },
        ),

        // 3) رد طلب خطة شهور كتير -> رسالة وقفل
        BlocListener<RequestInstallmentPlanCubit, BaseCubitState>(
          listener: (context, state) {
            if (state is ErrorState) {
              _setProcessing(false);
              ToastHelper.showWarning(state.message.toString());
            }
            if (state is SuccessState) {
              final message = (state.data as BaseResponse).message ?? '';
              _setProcessing(false);
              ToastHelper.showSuccess(message);
              if (mounted) Navigator.of(context).pop(false);
            }
          },
        ),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ---------- نوع 1: شهرين ----------
          _installmentTypeCard(
            selected: isTwoMonths,
            title: '2 Months Plan',
            subtitle: '\$${_fmt(twoMonthsMonthly)} / month',
            trailing: 'Total \$${_fmt(total)}',
            onTap:
                () => setState(
                  () => _installmentType = InstallmentType.twoMonths,
                ),
          ),

          // ---------- نوع 2: شهور كتير ----------
          _installmentTypeCard(
            selected: !isTwoMonths,
            title: 'Multiple Months',
            subtitle:
                !isTwoMonths
                    ? '\$${_fmt(multiMonthly.toDouble())} / month'
                    : 'Choose the number of months',
            trailing: !isTwoMonths ? 'Total \$${_fmt(total)}' : null,
            onTap:
                () => setState(
                  () => _installmentType = InstallmentType.multiMonths,
                ),
            extra: !isTwoMonths ? _monthsDropdown() : null,
          ),

          10.verticalSpace,
          includedCard(),
          10.verticalSpace,
          GradientButton(
            height: 40.h,
            text:
                _isProcessing
                    ? 'Processing...'
                    : (isTwoMonths
                        ? 'Complete Enrollment'
                        : 'Request Installment Plan'),
            onTap: _submitInstallments,
          ),
          10.verticalSpace,
          Appbutton(
            height: 40.h,
            borderRadius: 12,
            borderColor: AppColors.grey,
            needBorder: true,
            color: AppColors.white,
            textColor: AppColors.black,
            onPressed: () {
              Navigator.of(context).pop();
            },
            text: 'Cancel',
          ),
        ],
      ),
    );
  }

  /// كارت اختيار نوع القسط
  Widget _installmentTypeCard({
    required bool selected,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    String? trailing,
    Widget? extra,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.borderGrey,
              width: selected ? 1.5 : 1,
            ),
            color:
                selected
                    ? AppColors.primary.withOpacity(0.05)
                    : AppColors.white,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    selected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: selected ? AppColors.primary : AppColors.greyDarker,
                    size: 18.r,
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: AppsStyles.s12Bold),
                        2.verticalSpace,
                        Text(
                          subtitle,
                          style: AppsStyles.s12Regular.copyWith(
                            color: AppColors.greyDarker,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (trailing != null)
                    Text(
                      trailing,
                      style: AppsStyles.s12Bold.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                ],
              ),
              if (extra != null) ...[10.verticalSpace, extra],
            ],
          ),
        ),
      ),
    );
  }

  /// قايمة اختيار عدد الشهور
  Widget _monthsDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          isExpanded: true,
          value: _selectedMonths,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          items:
              _multiMonthOptions
                  .map(
                    (m) => DropdownMenuItem<int>(
                      value: m,
                      child: Text('$m Months', style: AppsStyles.s12Regular),
                    ),
                  )
                  .toList(),
          onChanged: (value) {
            if (value == null) return;
            setState(() => _selectedMonths = value);
          },
        ),
      ),
    );
  }

  // ===================== Shared: included benefits card =====================

  Widget includedCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        color: AppColors.borderGrey.withOpacity(0.5),
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(text: 'What\'s Included:', style: AppsStyles.s12Bold),
            10.verticalSpace,
            ...courseEnrollBenefits.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: [
                    const Icon(Icons.check, color: Colors.green, size: 20),
                    5.horizontalSpace,
                    Expanded(child: Text(item, style: AppsStyles.s12Regular)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget moneyDisplay(
    Color titleColor,
    Color dataColor,
    String title,
    String data, {
    TextStyle? textStyle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style:
              textStyle?.copyWith(color: titleColor) ??
              AppsStyles.s12Regular.copyWith(color: titleColor),
        ),
        5.horizontalSpace,
        Text(
          data,
          style:
              textStyle?.copyWith(color: dataColor) ??
              AppsStyles.s12Regular.copyWith(color: dataColor),
        ),
      ],
    );
  }
}