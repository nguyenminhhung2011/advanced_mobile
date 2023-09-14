// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenModel _$TokenModelFromJson(Map<String, dynamic> json) => TokenModel(
      json['access'] == null
          ? null
          : ChildToModel.fromJson(json['access'] as Map<String, dynamic>),
      json['refresh'] == null
          ? null
          : ChildToModel.fromJson(json['refresh'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TokenModelToJson(TokenModel instance) =>
    <String, dynamic>{
      'access': instance.access?.toJson(),
      'refresh': instance.refresh?.toJson(),
    };
