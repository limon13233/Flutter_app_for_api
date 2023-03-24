import 'package:app_for_api/logindata.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'loginresponse.freezed.dart';
part 'loginresponse.g.dart';

@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    required String userName,
    String? email,
    @JsonKey(name: 'refreshToken') String? token,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
