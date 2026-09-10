import 'package:json_annotation/json_annotation.dart';

part 'support_model.g.dart';

@JsonSerializable()
class SupportTicketModel {
  final int? id;
  final String? message;
  final String? status;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  SupportTicketModel({this.id, this.message, this.status, this.createdAt});

  factory SupportTicketModel.fromJson(Map<String, dynamic> json) =>
      _$SupportTicketModelFromJson(json);

  Map<String, dynamic> toJson() => _$SupportTicketModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SupportListModel {
  final List<SupportTicketModel>? data;

  SupportListModel({this.data});

  factory SupportListModel.fromJson(Map<String, dynamic> json) =>
      _$SupportListModelFromJson(json);

  Map<String, dynamic> toJson() => _$SupportListModelToJson(this);
}