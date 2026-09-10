// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportsResponseModel _$ReportsResponseModelFromJson(
  Map<String, dynamic> json,
) => ReportsResponseModel(
  course: json['course'],
  from: json['from'],
  to: json['to'],
  financial:
      json['financial'] == null
          ? null
          : FinancialModel.fromJson(json['financial'] as Map<String, dynamic>),
  performance:
      json['performance'] == null
          ? null
          : PerformanceModel.fromJson(
            json['performance'] as Map<String, dynamic>,
          ),
  enrollment:
      json['enrollment'] == null
          ? null
          : EnrollmentModel.fromJson(
            json['enrollment'] as Map<String, dynamic>,
          ),
  perCourse:
      (json['per_course'] as List<dynamic>?)
          ?.map((e) => PerCourseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$ReportsResponseModelToJson(
  ReportsResponseModel instance,
) => <String, dynamic>{
  'course': instance.course,
  'from': instance.from,
  'to': instance.to,
  'financial': instance.financial?.toJson(),
  'performance': instance.performance?.toJson(),
  'enrollment': instance.enrollment?.toJson(),
  'per_course': instance.perCourse?.map((e) => e.toJson()).toList(),
};

FinancialModel _$FinancialModelFromJson(Map<String, dynamic> json) =>
    FinancialModel(
      totalCollected: json['total_collected'] as num?,
      totalPending: json['total_pending'] as num?,
      totalRefunded: json['total_refunded'] as num?,
      totalFailed: json['total_failed'] as num?,
      byMethod: json['by_method'] as Map<String, dynamic>?,
      byPayableType: json['by_payable_type'] as Map<String, dynamic>?,
      timeSeries:
          (json['time_series'] as List<dynamic>?)
              ?.map(
                (e) => TimeSeriesPointModel.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      outstanding:
          json['outstanding'] == null
              ? null
              : OutstandingModel.fromJson(
                json['outstanding'] as Map<String, dynamic>,
              ),
      transactionCount: (json['transaction_count'] as num?)?.toInt(),
      averagePayment: json['average_payment'] as num?,
    );

Map<String, dynamic> _$FinancialModelToJson(FinancialModel instance) =>
    <String, dynamic>{
      'total_collected': instance.totalCollected,
      'total_pending': instance.totalPending,
      'total_refunded': instance.totalRefunded,
      'total_failed': instance.totalFailed,
      'by_method': instance.byMethod,
      'by_payable_type': instance.byPayableType,
      'time_series': instance.timeSeries?.map((e) => e.toJson()).toList(),
      'outstanding': instance.outstanding?.toJson(),
      'transaction_count': instance.transactionCount,
      'average_payment': instance.averagePayment,
    };

TimeSeriesPointModel _$TimeSeriesPointModelFromJson(
  Map<String, dynamic> json,
) => TimeSeriesPointModel(
  date: json['date'] as String?,
  value: json['value'] as num?,
);

Map<String, dynamic> _$TimeSeriesPointModelToJson(
  TimeSeriesPointModel instance,
) => <String, dynamic>{'date': instance.date, 'value': instance.value};

OutstandingModel _$OutstandingModelFromJson(Map<String, dynamic> json) =>
    OutstandingModel(
      count: (json['count'] as num?)?.toInt(),
      totalDue: json['total_due'] as num?,
      overdueCount: (json['overdue_count'] as num?)?.toInt(),
      overdueTotal: json['overdue_total'] as num?,
    );

Map<String, dynamic> _$OutstandingModelToJson(OutstandingModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'total_due': instance.totalDue,
      'overdue_count': instance.overdueCount,
      'overdue_total': instance.overdueTotal,
    };

PerformanceModel _$PerformanceModelFromJson(Map<String, dynamic> json) =>
    PerformanceModel(
      exams:
          json['exams'] == null
              ? null
              : ExamStatsModel.fromJson(json['exams'] as Map<String, dynamic>),
      assignments:
          json['assignments'] == null
              ? null
              : ExamStatsModel.fromJson(
                json['assignments'] as Map<String, dynamic>,
              ),
      combined:
          json['combined'] == null
              ? null
              : CombinedStatsModel.fromJson(
                json['combined'] as Map<String, dynamic>,
              ),
      attendance:
          json['attendance'] == null
              ? null
              : AttendanceModel.fromJson(
                json['attendance'] as Map<String, dynamic>,
              ),
      overdue:
          json['overdue'] == null
              ? null
              : OverdueModel.fromJson(json['overdue'] as Map<String, dynamic>),
      marksTimeSeries:
          (json['marks_time_series'] as List<dynamic>?)
              ?.map(
                (e) => TimeSeriesPointModel.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
    );

Map<String, dynamic> _$PerformanceModelToJson(PerformanceModel instance) =>
    <String, dynamic>{
      'exams': instance.exams?.toJson(),
      'assignments': instance.assignments?.toJson(),
      'combined': instance.combined?.toJson(),
      'attendance': instance.attendance?.toJson(),
      'overdue': instance.overdue?.toJson(),
      'marks_time_series':
          instance.marksTimeSeries?.map((e) => e.toJson()).toList(),
    };

ExamStatsModel _$ExamStatsModelFromJson(Map<String, dynamic> json) =>
    ExamStatsModel(
      attempted: (json['attempted'] as num?)?.toInt(),
      graded: (json['graded'] as num?)?.toInt(),
      averagePercent: (json['average_percent'] as num?)?.toDouble(),
      highest: (json['highest'] as num?)?.toDouble(),
      lowest: (json['lowest'] as num?)?.toDouble(),
      attempts: json['attempts'] as List<dynamic>?,
    );

Map<String, dynamic> _$ExamStatsModelToJson(ExamStatsModel instance) =>
    <String, dynamic>{
      'attempted': instance.attempted,
      'graded': instance.graded,
      'average_percent': instance.averagePercent,
      'highest': instance.highest,
      'lowest': instance.lowest,
      'attempts': instance.attempts,
    };

CombinedStatsModel _$CombinedStatsModelFromJson(Map<String, dynamic> json) =>
    CombinedStatsModel(
      attempted: (json['attempted'] as num?)?.toInt(),
      graded: (json['graded'] as num?)?.toInt(),
      averagePercent: (json['average_percent'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CombinedStatsModelToJson(CombinedStatsModel instance) =>
    <String, dynamic>{
      'attempted': instance.attempted,
      'graded': instance.graded,
      'average_percent': instance.averagePercent,
    };

AttendanceModel _$AttendanceModelFromJson(Map<String, dynamic> json) =>
    AttendanceModel(
      totalSessions: (json['total_sessions'] as num?)?.toInt(),
      attended: (json['attended'] as num?)?.toInt(),
      absent: (json['absent'] as num?)?.toInt(),
      late: (json['late'] as num?)?.toInt(),
      excused: (json['excused'] as num?)?.toInt(),
      byStatus:
          (json['by_status'] as List<dynamic>?)
              ?.map(
                (e) =>
                    AttendanceStatusModel.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      rate: (json['rate'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AttendanceModelToJson(AttendanceModel instance) =>
    <String, dynamic>{
      'total_sessions': instance.totalSessions,
      'attended': instance.attended,
      'absent': instance.absent,
      'late': instance.late,
      'excused': instance.excused,
      'by_status': instance.byStatus?.map((e) => e.toJson()).toList(),
      'rate': instance.rate,
    };

AttendanceStatusModel _$AttendanceStatusModelFromJson(
  Map<String, dynamic> json,
) => AttendanceStatusModel(
  status: json['status'] as String?,
  label: json['label'] as String?,
  color: json['color'] as String?,
  count: (json['count'] as num?)?.toInt(),
  percent: (json['percent'] as num?)?.toDouble(),
);

Map<String, dynamic> _$AttendanceStatusModelToJson(
  AttendanceStatusModel instance,
) => <String, dynamic>{
  'status': instance.status,
  'label': instance.label,
  'color': instance.color,
  'count': instance.count,
  'percent': instance.percent,
};

OverdueModel _$OverdueModelFromJson(Map<String, dynamic> json) => OverdueModel(
  missedAssignments:
      (json['missed_assignments'] as List<dynamic>?)
          ?.map(
            (e) => MissedAssignmentModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
  missedExams: json['missed_exams'] as List<dynamic>?,
  attendanceIssues: json['attendance_issues'] as List<dynamic>?,
  counts:
      json['counts'] == null
          ? null
          : OverdueCountsModel.fromJson(json['counts'] as Map<String, dynamic>),
);

Map<String, dynamic> _$OverdueModelToJson(OverdueModel instance) =>
    <String, dynamic>{
      'missed_assignments':
          instance.missedAssignments?.map((e) => e.toJson()).toList(),
      'missed_exams': instance.missedExams,
      'attendance_issues': instance.attendanceIssues,
      'counts': instance.counts?.toJson(),
    };

MissedAssignmentModel _$MissedAssignmentModelFromJson(
  Map<String, dynamic> json,
) => MissedAssignmentModel(
  title: json['title'] as String?,
  course: json['course'] as String?,
  deadline: json['deadline'] as String?,
);

Map<String, dynamic> _$MissedAssignmentModelToJson(
  MissedAssignmentModel instance,
) => <String, dynamic>{
  'title': instance.title,
  'course': instance.course,
  'deadline': instance.deadline,
};

OverdueCountsModel _$OverdueCountsModelFromJson(Map<String, dynamic> json) =>
    OverdueCountsModel(
      missedAssignments: (json['missed_assignments'] as num?)?.toInt(),
      missedExams: (json['missed_exams'] as num?)?.toInt(),
      absences: (json['absences'] as num?)?.toInt(),
      lates: (json['lates'] as num?)?.toInt(),
      excused: (json['excused'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OverdueCountsModelToJson(OverdueCountsModel instance) =>
    <String, dynamic>{
      'missed_assignments': instance.missedAssignments,
      'missed_exams': instance.missedExams,
      'absences': instance.absences,
      'lates': instance.lates,
      'excused': instance.excused,
    };

EnrollmentModel _$EnrollmentModelFromJson(Map<String, dynamic> json) =>
    EnrollmentModel(
      total: (json['total'] as num?)?.toInt(),
      active: (json['active'] as num?)?.toInt(),
      completed: (json['completed'] as num?)?.toInt(),
      inProgress: (json['in_progress'] as num?)?.toInt(),
      avgProgress: (json['avg_progress'] as num?)?.toDouble(),
      byCourse: json['by_course'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$EnrollmentModelToJson(EnrollmentModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'active': instance.active,
      'completed': instance.completed,
      'in_progress': instance.inProgress,
      'avg_progress': instance.avgProgress,
      'by_course': instance.byCourse,
    };

PerCourseModel _$PerCourseModelFromJson(Map<String, dynamic> json) =>
    PerCourseModel(
      courseId: (json['course_id'] as num?)?.toInt(),
      courseTitle: json['course_title'] as String?,
      revenue: json['revenue'] as num?,
      enrollments: (json['enrollments'] as num?)?.toInt(),
      avgProgress: (json['avg_progress'] as num?)?.toDouble(),
      avgExamMark: (json['avg_exam_mark'] as num?)?.toDouble(),
      attendanceRate: (json['attendance_rate'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PerCourseModelToJson(PerCourseModel instance) =>
    <String, dynamic>{
      'course_id': instance.courseId,
      'course_title': instance.courseTitle,
      'revenue': instance.revenue,
      'enrollments': instance.enrollments,
      'avg_progress': instance.avgProgress,
      'avg_exam_mark': instance.avgExamMark,
      'attendance_rate': instance.attendanceRate,
    };
