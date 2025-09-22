import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos/features/general/general.dart';
import 'package:pos/features/users/users.dart';

part 'user_response.freezed.dart';
part 'user_response.g.dart';

@freezed
sealed class UserResponse with _$UserResponse {
  const factory UserResponse({
    @JsonKey(name: 'diagnostic') Diagnostic? diagnostic,
    @JsonKey(name: 'data') DataUser? data,
  }) = _UserResponse;

  const UserResponse._();

  User toEntity() => User(
    name: data?.name,
    email: data?.email,
    avatar: data?.photo,
    isVerified: data?.verified,
    updatedAt: data?.updatedAt,
  );

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}
