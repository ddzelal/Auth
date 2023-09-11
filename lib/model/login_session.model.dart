import 'dart:convert';

class LoginResponseModel {
  LoginResponseModel({
    required this.accessToken,
    required this.refreshToken,
  });
  late final String accessToken;
  late final String refreshToken;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['accessToken'] = accessToken;
    _data['refreshToken'] = refreshToken;
    return _data;
  }
}

String LoginRequestModelToJson(LoginRequestModel data) =>
    json.encode(data.toJson());

class LoginRequestModel {
  LoginRequestModel({
    required this.email,
    required this.password,
  });
  late final String email;
  late final String password;

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['password'] = password;
    return _data;
  }
}
