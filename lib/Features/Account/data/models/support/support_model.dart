import 'package:json_annotation/json_annotation.dart';

part 'support_model.g.dart';

@JsonSerializable()
class SupportTicketModel {
  final int? id;
  final String? message;
  final bool? isRead;
  @JsonKey(name: 'created_at')
  final String? createdAt;

  SupportTicketModel({this.id, this.message, this.isRead, this.createdAt});

  factory SupportTicketModel.fromJson(Map<String, dynamic> json) =>
      _$SupportTicketModelFromJson(json);

  Map<String, dynamic> toJson() => _$SupportTicketModelToJson(this);
}

