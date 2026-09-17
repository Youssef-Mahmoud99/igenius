// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportTicketModel _$SupportTicketModelFromJson(Map<String, dynamic> json) =>
    SupportTicketModel(
      id: (json['id'] as num?)?.toInt(),
      message: json['message'] as String?,
      isRead: json['isRead'] as bool?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$SupportTicketModelToJson(SupportTicketModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'isRead': instance.isRead,
      'created_at': instance.createdAt,
    };
