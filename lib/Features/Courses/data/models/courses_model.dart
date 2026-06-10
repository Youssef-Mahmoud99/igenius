import 'package:json_annotation/json_annotation.dart';
import 'teacher.dart';

part 'courses_model.g.dart';

@JsonSerializable(genericArgumentFactories: true) // شيل ignoreUnannotated
class CourseModel {
  final int? id;
  final String? title;
  final String? description;
  final String? image;
  final int? price;

  @JsonKey(name: 'price_after_discount')
  final int? priceAfterDiscount;

  @JsonKey(name: 'effective_price')
  final int? effectivePrice;

  @JsonKey(name: 'has_discount')
  final bool? hasDiscount;

  @JsonKey(name: 'has_installment_plan')
  final bool? hasInstallmentPlan;

  @JsonKey(name: 'duration_weeks')
  final int? durationWeeks;

  @JsonKey(name: 'total_lessons')
  final int? totalLessons;

  @JsonKey(name: 'is_external_course')
  final bool? isExternalCourse;

  final Teacher? teacher;
  final Teacher? subject;
  final Teacher? level;
  final Teacher? board;
  final Teacher? system;

  const CourseModel({
    this.id,
    this.title,
    this.description,
    this.image,
    this.price,
    this.priceAfterDiscount,
    this.effectivePrice,
    this.hasDiscount,
    this.hasInstallmentPlan,
    this.durationWeeks,
    this.totalLessons,
    this.isExternalCourse,
    this.teacher,
    this.subject,
    this.level,
    this.board,
    this.system,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseModelToJson(this);

  CourseModel copyWith({
    int? id,
    String? title,
    String? description,
    String? image,
    int? price,
    int? priceAfterDiscount,
    int? effectivePrice,
    bool? hasDiscount,
    bool? hasInstallmentPlan,
    int? durationWeeks,
    int? totalLessons,
    bool? isExternalCourse,
    Teacher? teacher,
    Teacher? subject,
    Teacher? level,
    Teacher? board,
    Teacher? system,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
      priceAfterDiscount:
          priceAfterDiscount ?? this.priceAfterDiscount,
      effectivePrice: effectivePrice ?? this.effectivePrice,
      hasDiscount: hasDiscount ?? this.hasDiscount,
      hasInstallmentPlan:
          hasInstallmentPlan ?? this.hasInstallmentPlan,
      durationWeeks: durationWeeks ?? this.durationWeeks,
      totalLessons: totalLessons ?? this.totalLessons,
      isExternalCourse: isExternalCourse ?? this.isExternalCourse,
      teacher: teacher ?? this.teacher,
      subject: subject ?? this.subject,
      level: level ?? this.level,
      board: board ?? this.board,
      system: system ?? this.system,
    );
  }
}