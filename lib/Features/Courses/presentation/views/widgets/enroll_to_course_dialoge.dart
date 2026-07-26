import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/Features/payment/presentation/cubits/buy_course_cubit.dart';
import 'package:igenius/Features/payment/presentation/cubits/pay_installment_cubit.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import 'package:igenius/core/utils/helpers/app_navigtion.dart';
import 'package:igenius/core/widgets/custom_text.dart';
import 'package:igenius/core/widgets/primary_button.dart';
import 'package:igenius/injection/service_locator.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/gradient_button.dart';
import '../../../../payment/data/models/buy_course_params.dart';
import '../../../../payment/data/models/pay_installment_params.dart';
import '../../../../payment/presentation/cubits/request_installment_cubit.dart';
import '../../../data/models/course_details.dart';

void showEnrollToCourseBottomSheet(
  BuildContext context,
  CourseDetails courseDetails,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder:
        (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => sl<RequestInstallmentCubit>()),
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
  int _selectedInstallmentIndex = 0;

  /// الـ Flag اللي بيوريك انهي تاب مختار دلوقتي
  /// 0 = Pay in Full   |   1 = Installments
  int _selectedTabIndex = 0;

  final List<String> courseEnrollBenefits = const [
    'Lifetime access to all course materials',
    'Certificate of completion',
    'Access to live sessions & recordings',
    'Direct support from instructor',
  ];

  late final List<Map<String, dynamic>> _installmentPlans = const [
    {'months': 2, 'monthlyAmount': '\$150', 'total': '\$300'},
    {'months': 3, 'monthlyAmount': '\$100', 'total': '\$300'},
  ];

  void _onTabTapped(int index) {
    if (_selectedTabIndex == index) return; // من غير setState لو نفس التاب
    setState(() {
      _selectedTabIndex = index;
    });
  }

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
              // تبديل فوري بدون animation - كل تاب محتفظ بحالته
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
            AppNavaigation.pop();
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
                    colors: [
                      Color(
                        0xff1B2A4A,
                      ), // navy - طابقها مع GradientButton لو مختلفة
                      Color(0xff8A1538), // maroon
                    ],
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
    return Column(
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
            : SizedBox.shrink(),
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
              context.read<BuyCourseCubit>().buyCourse(
                BuyCourseParams(method: "card_dummy", id: widget.courseDetails.id!),
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
            AppNavaigation.pop();
          },
          text: 'Cancel',
        ),
      ],
    );
  }

  // ===================== Tab 2: Installments (شهرين / تلاته بس) =====================

  Widget installmentsTab() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(_installmentPlans.length, (index) {
          final plan = _installmentPlans[index];
          final isSelected = _selectedInstallmentIndex == index;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                setState(() => _selectedInstallmentIndex = index);
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        isSelected ? AppColors.primary : AppColors.borderGrey,
                    width: isSelected ? 1.5 : 1,
                  ),
                  color:
                      isSelected
                          ? AppColors.primary.withOpacity(0.05)
                          : AppColors.white,
                ),
                child: Row(
                  children: [
                    Icon(
                      isSelected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color:
                          isSelected ? AppColors.primary : AppColors.greyDarker,
                      size: 18.r,
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${plan['months']} Months Plan',
                            style: AppsStyles.s12Bold,
                          ),
                          2.verticalSpace,
                          Text(
                            '${plan['monthlyAmount']} / month',
                            style: AppsStyles.s12Regular.copyWith(
                              color: AppColors.greyDarker,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Total ${plan['total']}',
                      style: AppsStyles.s12Bold.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        10.verticalSpace,
        includedCard(),
        10.verticalSpace,
        GradientButton(height: 40.h, text: 'Complete Enrollment', onTap: () {
              context.read<PayInstallmentCubit>().payInstallment(
                PayInstallmentParams(method: "card_dummy" , id: widget.courseDetails.id!),
              );

        }),
        10.verticalSpace,
        Appbutton(
          height: 40.h,
          borderRadius: 12,
          borderColor: AppColors.grey,
          needBorder: true,
          color: AppColors.white,
          textColor: AppColors.black,
          onPressed: () {
            AppNavaigation.pop();
          },
          text: 'Cancel',
        ),
      ],
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
