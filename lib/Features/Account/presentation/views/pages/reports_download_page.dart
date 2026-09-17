import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:igenius/core/utils/helpers/helper_methods.dart';

import '../../../../../core/base/cubit/base_state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/toast_helper.dart';
import '../../cubits/reports/download_report_cubit.dart';

class ReportsDownloadPage extends StatefulWidget {
  final int? courseId;

  const ReportsDownloadPage({super.key, this.courseId});

  @override
  State<ReportsDownloadPage> createState() => _ReportsDownloadPageState();
}

class _ReportsDownloadPageState extends State<ReportsDownloadPage> {
  DateTimeRange? selectedRange;
  String selectedType = 'full';

  final List<Map<String, String>> reportTypes = const [
    {'value': 'full', 'label': 'Full Report'},
    {'value': 'financial', 'label': 'Financial Report'},
    {'value': 'academic', 'label': 'Academic Report'},
  ];

Future<void> _pickRange() async {
    final today = DateTime.now();
    final result = await HelperMethods.pickDateRange(
      context,
      today,
      selectedRange,
      () => setState(() => selectedRange = null),
    );
    print(result);
    if (result != null) {
      setState(() => selectedRange = result);
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DownloadReportCubit, BaseCubitState>(
      listener: (context, state) {
        if (state is SuccessState<String>) {
          ToastHelper.showSuccess('Reports downloaded successfully');
        } else if (state is ErrorState<String>) {
          ToastHelper.showError(state.message ?? 'Failed to download reports');
        }
      },
      builder: (context, state) {
        final isLoading = state is LoadingState;
        return Scaffold(
          appBar: AppBar(title: const Text('Download Report')),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
DropdownButtonFormField<String>(
  value: selectedType,
  style: const TextStyle(color: AppColors.black),
  decoration: InputDecoration(
    hintStyle: TextStyle(color: AppColors.black),
    labelStyle: TextStyle(color: AppColors.black),
    floatingLabelStyle: TextStyle(color: AppColors.black),
    labelText: 'Report Type',
    border: OutlineInputBorder(),
  ),
  items: reportTypes
      .map((t) => DropdownMenuItem(
            value: t['value'],
            child: Text(
              t['label']!,
              style: const TextStyle(color: AppColors.black),
            ),
          ))
      .toList(),
  onChanged: isLoading
      ? null
      : (value) => setState(() => selectedType = value!),
),                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: isLoading ? null : _pickRange,
                  icon: const Icon(Icons.date_range),
                  label: Text(
                    selectedRange == null
                        ? 'Select Time Range (Optional)'
                        : '${_fmt(selectedRange!.start)}  -  ${_fmt(selectedRange!.end)}',
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: isLoading
                      ? null
                      : () => context.read<DownloadReportCubit>().downloadReport(
                            courseId: widget.courseId,
                            type: selectedType,
                            from: selectedRange?.start,
                            to: selectedRange?.end,
                          ),
                  icon: const Icon(Icons.download),
                  label: const Text('Download Report'),
                ),
                const SizedBox(height: 12),
                // ElevatedButton.icon(
                //   onPressed: (isLoading || widget.courseId == null)
                //       ? null
                //       : () => context.read<DownloadReportCubit>().downloadReport(
                //             courseId: widget.courseId,
                //             type: selectedType,
                //           ),
                //   icon: const Icon(Icons.school),
                //   label: const Text('Download Course Report'),
                // ),
                if (isLoading) ...[
                  const SizedBox(height: 20),
                  const Center(child: CircularProgressIndicator()),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  String _fmt(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}