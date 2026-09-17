import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/base/cubit/base_state.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/app_navigtion.dart';
import '../../../../../core/widgets/base_gradient.dart';
import '../../../../../core/widgets/custom_appBar.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../data/models/support/support_model.dart';
import '../../cubits/support/my_support_tickets_cubit.dart';

class MySupportTicketsScreen extends StatefulWidget {
  const MySupportTicketsScreen({Key? key}) : super(key: key);

  @override
  State<MySupportTicketsScreen> createState() =>
      _MySupportTicketsScreenState();
}

class _MySupportTicketsScreenState extends State<MySupportTicketsScreen> {
  @override
  void initState() {
    context.read<MySupportTicketsCubit>().getSupportTickets();
    super.initState();
  }

  Future<void> _onRefresh() async {
    await context.read<MySupportTicketsCubit>().getSupportTickets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: false,
        titleChild: Text(
          'Support Tickets',
          style: AppsStyles.s14Bold.copyWith(color: Colors.black),
        ),
        showBack: true,
      ),
      floatingActionButton: _NewTicketButton(
        onTap: () {
          AppNavaigation.replacePage(AppRoutes.sendSuppotTicketScreen);
        },
      ),
      body: SafeArea(
        child: BaseGradient(
          child: BlocBuilder<MySupportTicketsCubit, BaseCubitState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ErrorState) {
                return Center(child: AppText(text: state.message));
              }

              if (state is SuccessState) {
                final response =
                    state.data as BaseResponse<List<SupportTicketModel>>;
                final tickets = response.data ?? [];

                if (tickets.isEmpty) {
                  return Center(
                    child: AppText(
                      text: 'No support tickets yet',
                      style: AppsStyles.s14Bold.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(
                      20.w,
                      16.h,
                      20.w,
                      100.h,
                    ),
                    itemCount: tickets.length,
                    separatorBuilder: (_, __) => 12.verticalSpace,
                    itemBuilder: (context, index) {
                      return _TicketCard(ticket: tickets[index]);
                    },
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

class _TicketCard extends StatelessWidget {
  final SupportTicketModel ticket;
  const _TicketCard({required this.ticket});

  @override
  Widget build(BuildContext context) {
    final bool isRead = ticket.isRead == true ;

    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border(
          left: BorderSide(
            color: isRead ? AppColors.green : AppColors.primary,
            width: 4,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: (isRead ? AppColors.green : AppColors.primary)
                  .withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.support_agent_rounded,
              color: isRead ? AppColors.green : AppColors.primary,
              size: 22.r,
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: ticket.message ?? '',
                  style: AppsStyles.s14Bold.copyWith(color: Colors.black),
                  maxLines: 2,
                ),
                6.verticalSpace,
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 14.r,
                      color: AppColors.grey,
                    ),
                    4.horizontalSpace,
                    AppText(
                      text: ticket.createdAt ?? '',
                      style: AppsStyles.s12Regular.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          8.horizontalSpace,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: (isRead ? AppColors.green : AppColors.primary)
                  .withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              isRead ? 'Reviewed' : 'Pending',
              style: AppsStyles.s12Regular.copyWith(
                color: isRead ? AppColors.green : AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NewTicketButton extends StatelessWidget {
  final VoidCallback onTap;
  const _NewTicketButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56.r,
        width: 56.r,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.buttonGradient1,
              AppColors.buttonGradient2,
            ],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.35),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 28.r,
        ),
      ),
    );
  }
}