import 'package:freezed_annotation/freezed_annotation.dart';

part 'loginrequest.freezed.dart';
part 'loginrequest.g.dart';

@freezed
class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String userName,
    required String password,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}