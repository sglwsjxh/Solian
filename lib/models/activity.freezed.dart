// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SnActivity {

 String get id; String get type; String get resourceIdentifier; int get visibility; int get accountId; SnAccount get account; dynamic get data; DateTime get createdAt; DateTime get updatedAt; dynamic get deletedAt;
/// Create a copy of SnActivity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SnActivityCopyWith<SnActivity> get copyWith => _$SnActivityCopyWithImpl<SnActivity>(this as SnActivity, _$identity);

  /// Serializes this SnActivity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SnActivity&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.resourceIdentifier, resourceIdentifier) || other.resourceIdentifier == resourceIdentifier)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.account, account) || other.account == account)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.deletedAt, deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,resourceIdentifier,visibility,accountId,account,const DeepCollectionEquality().hash(data),createdAt,updatedAt,const DeepCollectionEquality().hash(deletedAt));

@override
String toString() {
  return 'SnActivity(id: $id, type: $type, resourceIdentifier: $resourceIdentifier, visibility: $visibility, accountId: $accountId, account: $account, data: $data, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class $SnActivityCopyWith<$Res>  {
  factory $SnActivityCopyWith(SnActivity value, $Res Function(SnActivity) _then) = _$SnActivityCopyWithImpl;
@useResult
$Res call({
 String id, String type, String resourceIdentifier, int visibility, int accountId, SnAccount account, dynamic data, DateTime createdAt, DateTime updatedAt, dynamic deletedAt
});


$SnAccountCopyWith<$Res> get account;

}
/// @nodoc
class _$SnActivityCopyWithImpl<$Res>
    implements $SnActivityCopyWith<$Res> {
  _$SnActivityCopyWithImpl(this._self, this._then);

  final SnActivity _self;
  final $Res Function(SnActivity) _then;

/// Create a copy of SnActivity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? resourceIdentifier = null,Object? visibility = null,Object? accountId = null,Object? account = null,Object? data = freezed,Object? createdAt = null,Object? updatedAt = null,Object? deletedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,resourceIdentifier: null == resourceIdentifier ? _self.resourceIdentifier : resourceIdentifier // ignore: cast_nullable_to_non_nullable
as String,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as int,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as SnAccount,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as dynamic,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}
/// Create a copy of SnActivity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SnAccountCopyWith<$Res> get account {
  
  return $SnAccountCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _SnActivity implements SnActivity {
  const _SnActivity({required this.id, required this.type, required this.resourceIdentifier, required this.visibility, required this.accountId, required this.account, required this.data, required this.createdAt, required this.updatedAt, required this.deletedAt});
  factory _SnActivity.fromJson(Map<String, dynamic> json) => _$SnActivityFromJson(json);

@override final  String id;
@override final  String type;
@override final  String resourceIdentifier;
@override final  int visibility;
@override final  int accountId;
@override final  SnAccount account;
@override final  dynamic data;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  dynamic deletedAt;

/// Create a copy of SnActivity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SnActivityCopyWith<_SnActivity> get copyWith => __$SnActivityCopyWithImpl<_SnActivity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SnActivityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SnActivity&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.resourceIdentifier, resourceIdentifier) || other.resourceIdentifier == resourceIdentifier)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.account, account) || other.account == account)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.deletedAt, deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,resourceIdentifier,visibility,accountId,account,const DeepCollectionEquality().hash(data),createdAt,updatedAt,const DeepCollectionEquality().hash(deletedAt));

@override
String toString() {
  return 'SnActivity(id: $id, type: $type, resourceIdentifier: $resourceIdentifier, visibility: $visibility, accountId: $accountId, account: $account, data: $data, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class _$SnActivityCopyWith<$Res> implements $SnActivityCopyWith<$Res> {
  factory _$SnActivityCopyWith(_SnActivity value, $Res Function(_SnActivity) _then) = __$SnActivityCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, String resourceIdentifier, int visibility, int accountId, SnAccount account, dynamic data, DateTime createdAt, DateTime updatedAt, dynamic deletedAt
});


@override $SnAccountCopyWith<$Res> get account;

}
/// @nodoc
class __$SnActivityCopyWithImpl<$Res>
    implements _$SnActivityCopyWith<$Res> {
  __$SnActivityCopyWithImpl(this._self, this._then);

  final _SnActivity _self;
  final $Res Function(_SnActivity) _then;

/// Create a copy of SnActivity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? resourceIdentifier = null,Object? visibility = null,Object? accountId = null,Object? account = null,Object? data = freezed,Object? createdAt = null,Object? updatedAt = null,Object? deletedAt = freezed,}) {
  return _then(_SnActivity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,resourceIdentifier: null == resourceIdentifier ? _self.resourceIdentifier : resourceIdentifier // ignore: cast_nullable_to_non_nullable
as String,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as int,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as SnAccount,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as dynamic,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

/// Create a copy of SnActivity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SnAccountCopyWith<$Res> get account {
  
  return $SnAccountCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}

// dart format on
