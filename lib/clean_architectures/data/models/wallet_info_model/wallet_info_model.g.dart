// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletInfoModel _$WalletInfoModelFromJson(Map<String, dynamic> json) =>
    WalletInfoModel(
      json['amount'] as String?,
      json['isBlocked'] as bool?,
      json['bonus'] as int?,
    );

Map<String, dynamic> _$WalletInfoModelToJson(WalletInfoModel instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'isBlocked': instance.isBlocked,
      'bonus': instance.bonus,
    };
