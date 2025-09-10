import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponseDto {
  const UserResponseDto({
    this.id = 0,
    this.name = '',
    this.email = '',
    this.phone = '',
    this.avatar = '',
    this.role = '',
    this.isActive = false,
    this.createdAt = '',
    this.updatedAt = '',
  });

  factory UserResponseDto.fromJson(Map<String, dynamic> json) =>
      _$UserResponseDtoFromJson(json);

  final int id;
  final String name;
  final String email;
  final String phone;
  final String avatar;
  final String role;
  final bool isActive;
  final String createdAt;
  final String updatedAt;

  Map<String, dynamic> toJson() => _$UserResponseDtoToJson(this);
}

@JsonSerializable()
class UserListResponseDto {
  const UserListResponseDto({
    @JsonKey(name: 'data') this.data = const [],
    this.status,
    this.isSuccess = false,
    this.totalCount = 0,
    this.message,
  });

  factory UserListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$UserListResponseDtoFromJson(json);

  @JsonKey(name: 'data')
  final List<UserResponseDto?> data;
  final String? status;
  final bool isSuccess;
  final int totalCount;
  final String? message;

  Map<String, dynamic> toJson() => _$UserListResponseDtoToJson(this);
}

@JsonSerializable()
class UserCreateRequestDto {
  const UserCreateRequestDto({
    required this.name,
    required this.email,
    required this.phone,
    this.avatar,
    this.role,
    this.isActive = true,
  });

  factory UserCreateRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UserCreateRequestDtoFromJson(json);

  final String name;
  final String email;
  final String phone;
  final String? avatar;
  final String? role;
  final bool isActive;

  Map<String, dynamic> toJson() => _$UserCreateRequestDtoToJson(this);
}

@JsonSerializable()
class UserUpdateRequestDto {
  const UserUpdateRequestDto({
    this.name,
    this.email,
    this.phone,
    this.avatar,
    this.role,
    this.isActive,
  });

  factory UserUpdateRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UserUpdateRequestDtoFromJson(json);

  final String? name;
  final String? email;
  final String? phone;
  final String? avatar;
  final String? role;
  final bool? isActive;

  Map<String, dynamic> toJson() => _$UserUpdateRequestDtoToJson(this);
}
