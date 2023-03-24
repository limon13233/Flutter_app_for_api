// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loginresponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LoginResponse _$$_LoginResponseFromJson(Map<String, dynamic> json) =>
    _$_LoginResponse(
      userName: json['userName'] as String,
      email: json['email'] as String?,
      token: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$$_LoginResponseToJson(_$_LoginResponse instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'email': instance.email,
      'refreshToken': instance.token,
    };
