import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:igenius/Features/Account/presentation/cubits/schedule/get_overdues_cubit.dart';

import '../../../../../core/base/cubit/base_state.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/utils/date_formmater.dart';
import '../../../../../core/utils/helpers/app_navigtion.dart';
import '../../../../Courses/data/models/course_details.dart';
import '../../../data/models/schedule/overdue_model.dart';

class OverduePage extends StatefulWidget {
  const OverduePage({super.key});

  @override
  State<OverduePage> createState() => _OverduePageState();
}

class _OverduePageState extends State<OverduePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final GetOverduesCubit _cubit;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    _cubit = context.read<GetOverduesCubit>();
    _cubit.getOverdues();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildTabs(),
            BlocBuilder<GetOverduesCubit, BaseCubitState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Error
                if (state is ErrorState) {
                  return Center(
                    child: Text(state.message ?? 'Something went wrong'),
                  );
                }

                // Success
                if (state is SuccessState) {
                  final response = state.data as BaseResponse<OverdueModel>;
                  final assignments = response.data?.assignments ?? [];
                  final exams = response.data?.exams ?? [];

                  if (response.data == null) {
                    return const Center(child: Text('No Upcomings available'));
                  }
                  return Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _OverdueAssignmentsTab(assignments: assignments),
                        _OverdueExamsTab(exams: exams),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(8, 12, 20, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF8B1E1E), Color(0xFFC94A4A)],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () => AppNavaigation.pop(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: Colors.white,
            iconSize: 20,
            style: IconButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.18),
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Overdue Items',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Assignments and exams that are overdue',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 10),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TabBar(
        controller: _tabController,
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab, // 👈 على قد الـ tab كله
        indicatorPadding: EdgeInsets.zero,
        splashBorderRadius: BorderRadius.circular(10),
        indicator: BoxDecoration(
          color: const Color(0xFFB83232), // في Upcoming: Color(0xFF243B72)
          borderRadius: BorderRadius.circular(10),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey.shade600,
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
        tabs: const [
          Tab(height: 40, text: 'Assignments'),
          Tab(height: 40, text: 'Exams'),
        ],
      ),
    );
  }
}

/// ------------------------------------------------------------
/// Overdue Assignments
/// ------------------------------------------------------------

class _OverdueAssignmentsTab extends StatelessWidget {
  final List<AssignmentModel>? assignments;

  const _OverdueAssignmentsTab({required this.assignments});

  @override
  Widget build(BuildContext context) {
    if (assignments == null || assignments!.isEmpty) {
      return const _EmptyView(
        icon: Icons.check_circle_outline,
        title: 'No overdue assignments',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 20),
      itemCount: assignments!.length,
      itemBuilder: (context, index) {
        final assignment = assignments![index];

        return _OverdueCard(
          isExam: false,
          itemId: assignment.id!,
          icon: Icons.edit_note_outlined,
          title: assignment.title ?? '',
          date: assignment.dueDate,
        );
      },
    );
  }
}

/// ------------------------------------------------------------
/// Overdue Exams
/// ------------------------------------------------------------

class _OverdueExamsTab extends StatelessWidget {
  final List<ExamModel>? exams;

  const _OverdueExamsTab({required this.exams});

  @override
  Widget build(BuildContext context) {
    if (exams == null || exams!.isEmpty) {
      return const _EmptyView(
        icon: Icons.check_circle_outline,
        title: 'No overdue exams',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 20),
      itemCount: exams!.length,
      itemBuilder: (context, index) {
        final exam = exams![index];

        return _OverdueCard(
          itemId: exam.id!,
          isExam: true,
          icon: Icons.assignment_outlined,
          title: exam.title ?? '',
          date: exam.dueDate,
        );
      },
    );
  }
}

/// ------------------------------------------------------------
/// Simple Overdue Card
/// ------------------------------------------------------------

class _OverdueCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? date;
  final int itemId;
  final bool isExam;

  const _OverdueCard({
    required this.icon,
    required this.title,
    required this.date,
    required this.itemId,
    required this.isExam,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        AppNavaigation.pushToPageWithParams(AppRoutes.assignmentViewScreen, {
          "isExam": isExam,
          "id": itemId,
          "unitTitle": '',
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: const Color(0xFFFFEEEE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFFB83232), size: 23),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF20242C),
                    ),
                  ),
                  if (date != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      DateFormatter.formatApiDate(date!),
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFFB83232),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// Empty
/// ------------------------------------------------------------

class _EmptyView extends StatelessWidget {
  final IconData icon;
  final String title;

  const _EmptyView({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// ------------------------------------------------------------
/// Error
/// ------------------------------------------------------------

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 50, color: Colors.red.shade300),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
