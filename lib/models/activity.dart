import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:island/models/user.dart';

part 'activity.freezed.dart';
part 'activity.g.dart';

@freezed
abstract class SnActivity with _$SnActivity {
  const factory SnActivity({
    required String id,
    required String type,
    required String resourceIdentifier,
    required int visibility,
    required int accountId,
    required SnAccount account,
    required dynamic data,
    required DateTime createdAt,
    required DateTime updatedAt,
    required dynamic deletedAt,
  }) = _SnActivity;

  factory SnActivity.fromJson(Map<String, dynamic> json) =>
      _$SnActivityFromJson(json);
}
