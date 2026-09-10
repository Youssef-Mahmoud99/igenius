// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportTicketModel _$SupportTicketModelFromJson(Map<String, dynamic> json) =>
    SupportTicketModel(
      id: (json['id'] as num?)?.toInt(),
      message: json['message'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$SupportTicketModelToJson(SupportTicketModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'status': instance.status,
      'created_at': instance.createdAt,
    };

SupportListModel _$SupportListModelFromJson(Map<String, dynamic> json) =>
    SupportListModel(
      data:
          (json['data'] as List<dynamic>?)
              ?.map(
                (e) => SupportTicketModel.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
    );

Map<String, dynamic> _$SupportListModelToJson(SupportListModel instance) =>
    <String, dynamic>{'data': instance.data?.map((e) => e.toJson()).toList()};
