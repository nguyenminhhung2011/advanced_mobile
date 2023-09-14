// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_to_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChildToModel _$ChildToModelFromJson(Map<String, dynamic> json) => ChildToModel(
      json['token'] as String?,
      json['expires'] == null
          ? null
          : DateTime.parse(json['expires'] as String),
    );

Map<String, dynamic> _$ChildToModelToJson(ChildToModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'expires': instance.expires?.toIso8601String(),
    };
