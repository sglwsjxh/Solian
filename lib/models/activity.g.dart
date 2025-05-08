// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SnActivity _$SnActivityFromJson(Map<String, dynamic> json) => _SnActivity(
  id: json['id'] as String,
  type: json['type'] as String,
  resourceIdentifier: json['resource_identifier'] as String,
  visibility: (json['visibility'] as num).toInt(),
  accountId: (json['account_id'] as num).toInt(),
  account: SnAccount.fromJson(json['account'] as Map<String, dynamic>),
  data: json['data'],
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  deletedAt: json['deleted_at'],
);

Map<String, dynamic> _$SnActivityToJson(_SnActivity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'resource_identifier': instance.resourceIdentifier,
      'visibility': instance.visibility,
      'account_id': instance.accountId,
      'account': instance.account.toJson(),
      'data': instance.data,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'deleted_at': instance.deletedAt,
    };
