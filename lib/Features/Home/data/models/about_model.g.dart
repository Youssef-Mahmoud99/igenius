// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AboutDataModel _$AboutDataModelFromJson(Map<String, dynamic> json) =>
    AboutDataModel(
      content: json['content'] as String?,
      logo: json['logo'] as String?,
      socialLinks:
          json['social_links'] == null
              ? null
              : SocialLinksModel.fromJson(
                json['social_links'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$AboutDataModelToJson(AboutDataModel instance) =>
    <String, dynamic>{
      'content': instance.content,
      'logo': instance.logo,
      'social_links': instance.socialLinks?.toJson(),
    };

SocialLinksModel _$SocialLinksModelFromJson(Map<String, dynamic> json) =>
    SocialLinksModel(
      facebook: json['facebook'] as String?,
      twitter: json['twitter'] as String?,
      instagram: json['instagram'] as String?,
      linkedin: json['linkedin'] as String?,
      youtube: json['youtube'] as String?,
      tiktok: json['tiktok'] as String?,
    );

Map<String, dynamic> _$SocialLinksModelToJson(SocialLinksModel instance) =>
    <String, dynamic>{
      'facebook': instance.facebook,
      'twitter': instance.twitter,
      'instagram': instance.instagram,
      'linkedin': instance.linkedin,
      'youtube': instance.youtube,
      'tiktok': instance.tiktok,
    };
