import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos/features/general/general.dart';
import 'package:pos/features/users/users.dart';

part 'users_response.freezed.dart';
part 'users_response.g.dart';

@freezed
sealed class UsersResponse with _$UsersResponse {
  const factory UsersResponse({
    Diagnostic? diagnostic,
    List<DataUser>? data,
    Page? page,
  }) = _UsersResponse;

  const UsersResponse._();

  Users toEntity() => Users(
    users: data
        ?.map(
          (data) => User(
            name: data.name,
            email: data.email,
            avatar: data.photo,
            isVerified: data.verified,
            updatedAt: data.updatedAt,
          ),
        )
        .toList(),
    currentPage: page?.currentPage,
    lastPage: page?.lastPage,
  );

  factory UsersResponse.fromJson(Map<String, dynamic> json) =>
      _$UsersResponseFromJson(json);
}

@freezed
sealed class DataUser with _$DataUser {
  const factory DataUser({
    String? id,
    String? name,
    String? email,
    String? photo,
    bool? verified,
    String? createdAt,
    String? updatedAt,
  }) = _DataUser;

  factory DataUser.fromJson(Map<String, dynamic> json) =>
      _$DataUserFromJson(json);
}
