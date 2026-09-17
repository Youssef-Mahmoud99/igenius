import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/theme/app_colors.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import 'package:igenius/core/widgets/custom_text.dart';
import 'package:igenius/core/widgets/custom_text_button.dart';
import 'package:igenius/core/widgets/gradient_button.dart';
import '../../../../../core/base/cubit/base_state.dart';
import '../../../../../core/utils/helpers/toast_helper.dart';
import '../../../../../injection/service_locator.dart';
import '../../../../Account/presentation/cubits/reports/download_report_cubit.dart';

class DownloadCourseReportButton extends StatelessWidget {
  final int courseId;

  const DownloadCourseReportButton({Key? key, required this.courseId})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DownloadReportCubit>(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<DownloadReportCubit, BaseCubitState>(
            listener: (context, state) {
              if (state is SuccessState<String>) {
                ToastHelper.showSuccess('Reports downloaded successfully');
              } else if (state is ErrorState<String>) {
                ToastHelper.showError(
                  state.message ?? 'Failed to download reports',
                );
              }
            },
            builder: (context, state) {
              final isLoading = state is LoadingState;
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: isLoading ? null : () => _openFilterSheet(context),
                child: Container(
                    height: 50.h,
                    width: 50.h,
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
                  ),
                  child: isLoading ? 
                  
                  Center(
                    child: Text(
                      
                      ".....",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                      ),
                  ): Icon(Icons.download, color: Colors.white, size: 20.r,),
                
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _openFilterSheet(BuildContext context) async {
    final cubit = context.read<DownloadReportCubit>();

    final result = await showModalBottomSheet<_ReportFilter>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ReportFilterSheet(),
    );

    if (result != null) {
      cubit.downloadReport(
        courseId: courseId,
        type: result.type,
        from: result.from,
        to: result.to,
      );
    }
  }
}

class _ReportFilter {
  final String type;
  final DateTime? from;
  final DateTime? to;

  _ReportFilter({required this.type, this.from, this.to});
}

class _ReportFilterSheet extends StatefulWidget {
  @override
  State<_ReportFilterSheet> createState() => _ReportFilterSheetState();
}

class _ReportFilterSheetState extends State<_ReportFilterSheet> {
  String selectedType = 'full';
  DateTime? from;
  DateTime? to;

  final List<Map<String, String>> reportTypes = const [
    {'value': 'full', 'label': 'Full Report'},
    {'value': 'financial', 'label': 'Financial Report'},
    {'value': 'academic', 'label': 'Academic Report'},
  ];

  Future<void> _pickDate({required bool isFrom}) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: (isFrom ? from : to) ?? now,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: AppColors.primary,
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isFrom) {
          from = picked;
        } else {
          to = picked;
        }
      });
    }
  }

  String _fmt(DateTime? d) =>
      d == null
          ? '--/--/----'
          : '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 16.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // مقبض السحب
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 16.h),
              decoration: BoxDecoration(
                color: AppColors.grey.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),

          AppText(text: 'Report Filter', style: AppsStyles.s16Bold),
          12.verticalSpace,

          AppText(text: 'Report Type', style: AppsStyles.s12Bold),
          8.verticalSpace,
          Wrap(
            spacing: 8.w,
            children:
                reportTypes.map((t) {
                  final isSelected = selectedType == t['value'];
                  return ChoiceChip(
                    label: Text(t['label']!),
                    selected: isSelected,
                    onSelected:
                        (_) => setState(() => selectedType = t['value']!),
                    selectedColor: AppColors.primary,
                    backgroundColor: AppColors.grey.withOpacity(0.1),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      side: BorderSide.none,
                    ),
                  );
                }).toList(),
          ),

          16.verticalSpace,
          AppText(text: 'Time Range', style: AppsStyles.s12Bold),
          8.verticalSpace,

          Row(
            children: [
              Expanded(
                child: _DateBox(
                  label: 'From',
                  value: _fmt(from),
                  onTap: () => _pickDate(isFrom: true),
                ),
              ),
              8.horizontalSpace,
              Expanded(
                child: _DateBox(
                  label: 'To',
                  value: _fmt(to),
                  onTap: () => _pickDate(isFrom: false),
                ),
              ),
            ],
          ),

          20.verticalSpace,
          GradientButton(
            height: 50.h,
            text: "Apply and Download",
            onTap: () {
              Navigator.of(
                context,
              ).pop(_ReportFilter(type: selectedType, from: from, to: to));
            },
          ),
          8.verticalSpace,
          Center(
            child: CustomTextButton(
              text: 'Reset',
              color: AppColors.grey,
              onPressed: () {
                setState(() {
                  selectedType = 'full';
                  from = null;
                  to = null;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DateBox extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const _DateBox({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(text: label, style: AppsStyles.s12Bold),
            4.verticalSpace,
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 14,
                  color: AppColors.primary,
                ),
                6.horizontalSpace,
                AppText(text: value, style: AppsStyles.s12Bold),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
