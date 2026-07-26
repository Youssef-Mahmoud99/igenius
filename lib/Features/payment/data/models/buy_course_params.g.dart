// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buy_course_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuyCourseParams _$BuyCourseParamsFromJson(Map<String, dynamic> json) =>
    BuyCourseParams(
      method: json['method'] as String,
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$BuyCourseParamsToJson(BuyCourseParams instance) =>
    <String, dynamic>{'method': instance.method, 'id': instance.id};
