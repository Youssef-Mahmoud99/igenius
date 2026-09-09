import 'package:json_annotation/json_annotation.dart';

part 'about_model.g.dart';


@JsonSerializable(explicitToJson: true)
class AboutDataModel {
  final String? content;
  final String? logo;
  @JsonKey(name: 'social_links')
  final SocialLinksModel? socialLinks;
  AboutDataModel({
    this.content,
    this.logo,
    this.socialLinks,
  });

  factory AboutDataModel.fromJson(Map<String, dynamic> json) =>
      _$AboutDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$AboutDataModelToJson(this);
}

@JsonSerializable()
class SocialLinksModel {
  final String? facebook;
  final String? twitter;
  final String? instagram;
  final String? linkedin;
  final String? youtube;
  final String? tiktok;

  SocialLinksModel({
    this.facebook,
    this.twitter,
    this.instagram,
    this.linkedin,
    this.youtube,
    this.tiktok,
  });

  factory SocialLinksModel.fromJson(Map<String, dynamic> json) =>
      _$SocialLinksModelFromJson(json);

  Map<String, dynamic> toJson() => _$SocialLinksModelToJson(this);
}