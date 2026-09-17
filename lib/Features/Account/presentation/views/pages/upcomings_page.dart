import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:igenius/core/utils/date_formmater.dart';

import '../../../../../core/base/cubit/base_state.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/utils/helpers/app_navigtion.dart';
import '../../../../Courses/data/models/course_details.dart';
import '../../../data/models/schedule/upcoming_model.dart';
import '../../cubits/schedule/get_upcomings_cubit.dart';

class UpcomingPage extends StatefulWidget {
  const UpcomingPage({super.key});

  @override
  State<UpcomingPage> createState() => _UpcomingPageState();
}

class _UpcomingPageState extends State<UpcomingPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final GetUpcomingsCubit _cubit;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);

    _cubit = context.read<GetUpcomingsCubit>();
    _cubit.getUpcomings();
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
            Expanded(
              child: BlocBuilder<GetUpcomingsCubit, BaseCubitState>(
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
                    final response = state.data as BaseResponse<UpcomingModel>;
                    final assignments = response.data?.assignments ?? [];
                    final exams = response.data?.exams ?? [];
                    final lessons = response.data?.lessons ?? [];

                    if (response.data == null) {
                      return const Center(
                        child: Text('No Upcomings available'),
                      );
                    }
                    return TabBarView(
                      controller: _tabController,
                      children: [
                        _LessonsTab(lessons: lessons),
                        _ExamsTab(exams: exams),
                        _AssignmentsTab(assignments: assignments),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF101D3D), Color(0xFF243B72)],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upcoming',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Lessons, exams and assignments coming up',
            style: TextStyle(color: Colors.white70, fontSize: 14),
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
        indicator: BoxDecoration(
          color: const Color(0xFF243B72),
          borderRadius: BorderRadius.circular(10),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey.shade600,
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        tabs: const [
          Tab(text: 'Lessons'),
          Tab(text: 'Exams'),
          Tab(text: 'Assignments'),
        ],
      ),
    );
  }
}

/// ------------------------------------------------------------
/// Lessons
/// ------------------------------------------------------------

class _LessonsTab extends StatelessWidget {
  final List<LessonModel>? lessons;

  const _LessonsTab({required this.lessons});

  @override
  Widget build(BuildContext context) {
    if (lessons == null || lessons!.isEmpty) {
      return const _EmptyView(
        icon: Icons.menu_book_outlined,
        title: 'No upcoming lessons',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 20),
      itemCount: lessons!.length,
      itemBuilder: (context, index) {
        final lesson = lessons![index];

        return _ScheduleCard(
          itemId: lesson.id!,
          type: "lesson",
          icon: Icons.menu_book_outlined,
          title: lesson.title ?? '',
          date: lesson.viewDate!,
        );
      },
    );
  }
}

/// ------------------------------------------------------------
/// Exams
/// ------------------------------------------------------------

class _ExamsTab extends StatelessWidget {
  final List<ExamModel>? exams;

  const _ExamsTab({required this.exams});

  @override
  Widget build(BuildContext context) {
    if (exams == null || exams!.isEmpty) {
      return const _EmptyView(
        icon: Icons.assignment_outlined,
        title: 'No upcoming exams',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 20),
      itemCount: exams!.length,
      itemBuilder: (context, index) {
        final exam = exams![index];

        return _ScheduleCard(
          itemId: exam.id!,
          type: "exam",
          icon: Icons.assignment_outlined,
          title: exam.title ?? '',
          date: exam.dueDate!,
        );
      },
    );
  }
}

/// ------------------------------------------------------------
/// Assignments
/// ------------------------------------------------------------

class _AssignmentsTab extends StatelessWidget {
  final List<AssignmentModel>? assignments;

  const _AssignmentsTab({required this.assignments});

  @override
  Widget build(BuildContext context) {
    if (assignments == null || assignments!.isEmpty) {
      return const _EmptyView(
        icon: Icons.edit_note_outlined,
        title: 'No upcoming assignments',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 20),
      itemCount: assignments!.length,
      itemBuilder: (context, index) {
        final assignment = assignments![index];

        return _ScheduleCard(
          itemId: assignment.id!,
          type: "assignment",
          icon: Icons.edit_note_outlined,
          title: assignment.title ?? '',
          date: assignment.dueDate ?? "",
        );
      },
    );
  }
}

/// ------------------------------------------------------------
/// Simple Schedule Card
/// ------------------------------------------------------------

class _ScheduleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String date;
  final String type;
  final int itemId;

  const _ScheduleCard({
    required this.icon,
    required this.title,
    required this.date,
    required this.type,
    required this.itemId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (type != "lesson") {
                  AppNavaigation.pushToPageWithParams(AppRoutes.assignmentViewScreen, {
          "isExam": type == "exam",
          "id": itemId,
          "unitTitle": '',
        });

        }
        else{
                  AppNavaigation.pushToPageWithParams(AppRoutes.lessonViewScreen, {
          "lessonId": itemId,
          "unitTitle": '',
          "isOwned": true,
        });
        }
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
                color: const Color(0xFFEEF2FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFF243B72), size: 23),
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
                      DateFormatter.formatApiDate(date),
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF687083),
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
