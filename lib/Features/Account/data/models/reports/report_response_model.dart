import 'package:json_annotation/json_annotation.dart';

part 'report_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ReportsResponseModel {
  final dynamic course;
  final dynamic from;
  final dynamic to;

  final FinancialModel? financial;
  final PerformanceModel? performance;
  final EnrollmentModel? enrollment;

  @JsonKey(name: 'per_course')
  final List<PerCourseModel>? perCourse;

  ReportsResponseModel({
    this.course,
    this.from,
    this.to,
    this.financial,
    this.performance,
    this.enrollment,
    this.perCourse,
  });

  factory ReportsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ReportsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportsResponseModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FinancialModel {
  @JsonKey(name: 'total_collected')
  final num? totalCollected;

  @JsonKey(name: 'total_pending')
  final num? totalPending;

  @JsonKey(name: 'total_refunded')
  final num? totalRefunded;

  @JsonKey(name: 'total_failed')
  final num? totalFailed;

  @JsonKey(name: 'by_method')
  final Map<String, dynamic>? byMethod;

  @JsonKey(name: 'by_payable_type')
  final Map<String, dynamic>? byPayableType;

  @JsonKey(name: 'time_series')
  final List<TimeSeriesPointModel>? timeSeries;

  final OutstandingModel? outstanding;

  @JsonKey(name: 'transaction_count')
  final int? transactionCount;

  @JsonKey(name: 'average_payment')
  final num? averagePayment;

  FinancialModel({
    this.totalCollected,
    this.totalPending,
    this.totalRefunded,
    this.totalFailed,
    this.byMethod,
    this.byPayableType,
    this.timeSeries,
    this.outstanding,
    this.transactionCount,
    this.averagePayment,
  });

  factory FinancialModel.fromJson(Map<String, dynamic> json) =>
      _$FinancialModelFromJson(json);

  Map<String, dynamic> toJson() => _$FinancialModelToJson(this);
}

@JsonSerializable()
class TimeSeriesPointModel {
  final String? date;
  final num? value;

  TimeSeriesPointModel({this.date, this.value});

  factory TimeSeriesPointModel.fromJson(Map<String, dynamic> json) =>
      _$TimeSeriesPointModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimeSeriesPointModelToJson(this);
}

@JsonSerializable()
class OutstandingModel {
  final int? count;

  @JsonKey(name: 'total_due')
  final num? totalDue;

  @JsonKey(name: 'overdue_count')
  final int? overdueCount;

  @JsonKey(name: 'overdue_total')
  final num? overdueTotal;

  OutstandingModel({
    this.count,
    this.totalDue,
    this.overdueCount,
    this.overdueTotal,
  });

  factory OutstandingModel.fromJson(Map<String, dynamic> json) =>
      _$OutstandingModelFromJson(json);

  Map<String, dynamic> toJson() => _$OutstandingModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PerformanceModel {
  final ExamStatsModel? exams;
  final ExamStatsModel? assignments;
  final CombinedStatsModel? combined;
  final AttendanceModel? attendance;
  final OverdueModel? overdue;

  @JsonKey(name: 'marks_time_series')
  final List<TimeSeriesPointModel>? marksTimeSeries;

  PerformanceModel({
    this.exams,
    this.assignments,
    this.combined,
    this.attendance,
    this.overdue,
    this.marksTimeSeries,
  });

  factory PerformanceModel.fromJson(Map<String, dynamic> json) =>
      _$PerformanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$PerformanceModelToJson(this);
}

@JsonSerializable()
class ExamStatsModel {
  final int? attempted;
  final int? graded;

  @JsonKey(name: 'average_percent')
  final double? averagePercent;

  final double? highest;
  final double? lowest;
  final List<dynamic>? attempts;

  ExamStatsModel({
    this.attempted,
    this.graded,
    this.averagePercent,
    this.highest,
    this.lowest,
    this.attempts,
  });

  factory ExamStatsModel.fromJson(Map<String, dynamic> json) =>
      _$ExamStatsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExamStatsModelToJson(this);
}

@JsonSerializable()
class CombinedStatsModel {
  final int? attempted;
  final int? graded;

  @JsonKey(name: 'average_percent')
  final double? averagePercent;

  CombinedStatsModel({this.attempted, this.graded, this.averagePercent});

  factory CombinedStatsModel.fromJson(Map<String, dynamic> json) =>
      _$CombinedStatsModelFromJson(json);

  Map<String, dynamic> toJson() => _$CombinedStatsModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AttendanceModel {
  @JsonKey(name: 'total_sessions')
  final int? totalSessions;

  final int? attended;
  final int? absent;
  final int? late;
  final int? excused;

  @JsonKey(name: 'by_status')
  final List<AttendanceStatusModel>? byStatus;

  final double? rate;

  AttendanceModel({
    this.totalSessions,
    this.attended,
    this.absent,
    this.late,
    this.excused,
    this.byStatus,
    this.rate,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceModelToJson(this);
}

@JsonSerializable()
class AttendanceStatusModel {
  final String? status;
  final String? label;
  final String? color;
  final int? count;
  final double? percent;

  AttendanceStatusModel({
    this.status,
    this.label,
    this.color,
    this.count,
    this.percent,
  });

  factory AttendanceStatusModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceStatusModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OverdueModel {
  @JsonKey(name: 'missed_assignments')
  final List<MissedAssignmentModel>? missedAssignments;

  @JsonKey(name: 'missed_exams')
  final List<dynamic>? missedExams;

  @JsonKey(name: 'attendance_issues')
  final List<dynamic>? attendanceIssues;

  final OverdueCountsModel? counts;

  OverdueModel({
    this.missedAssignments,
    this.missedExams,
    this.attendanceIssues,
    this.counts,
  });

  factory OverdueModel.fromJson(Map<String, dynamic> json) =>
      _$OverdueModelFromJson(json);

  Map<String, dynamic> toJson() => _$OverdueModelToJson(this);
}

@JsonSerializable()
class MissedAssignmentModel {
  final String? title;
  final String? course;
  final String? deadline;

  MissedAssignmentModel({this.title, this.course, this.deadline});

  factory MissedAssignmentModel.fromJson(Map<String, dynamic> json) =>
      _$MissedAssignmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$MissedAssignmentModelToJson(this);
}

@JsonSerializable()
class OverdueCountsModel {
  @JsonKey(name: 'missed_assignments')
  final int? missedAssignments;

  @JsonKey(name: 'missed_exams')
  final int? missedExams;

  final int? absences;
  final int? lates;
  final int? excused;

  OverdueCountsModel({
    this.missedAssignments,
    this.missedExams,
    this.absences,
    this.lates,
    this.excused,
  });

  factory OverdueCountsModel.fromJson(Map<String, dynamic> json) =>
      _$OverdueCountsModelFromJson(json);

  Map<String, dynamic> toJson() => _$OverdueCountsModelToJson(this);
}

@JsonSerializable()
class EnrollmentModel {
  final int? total;
  final int? active;
  final int? completed;

  @JsonKey(name: 'in_progress')
  final int? inProgress;

  @JsonKey(name: 'avg_progress')
  final double? avgProgress;

  @JsonKey(name: 'by_course')
  final Map<String, dynamic>? byCourse;

  EnrollmentModel({
    this.total,
    this.active,
    this.completed,
    this.inProgress,
    this.avgProgress,
    this.byCourse,
  });

  factory EnrollmentModel.fromJson(Map<String, dynamic> json) =>
      _$EnrollmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$EnrollmentModelToJson(this);
}

@JsonSerializable()
class PerCourseModel {
  @JsonKey(name: 'course_id')
  final int? courseId;

  @JsonKey(name: 'course_title')
  final String? courseTitle;

  final num? revenue;
  final int? enrollments;

  @JsonKey(name: 'avg_progress')
  final double? avgProgress;

  @JsonKey(name: 'avg_exam_mark')
  final double? avgExamMark;

  @JsonKey(name: 'attendance_rate')
  final double? attendanceRate;

  PerCourseModel({
    this.courseId,
    this.courseTitle,
    this.revenue,
    this.enrollments,
    this.avgProgress,
    this.avgExamMark,
    this.attendanceRate,
  });

  factory PerCourseModel.fromJson(Map<String, dynamic> json) =>
      _$PerCourseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PerCourseModelToJson(this);
}