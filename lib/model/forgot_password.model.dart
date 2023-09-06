import 'dart:convert';

ForgotPasswordModelRequest ForgotPasswordModelRequestFromJson(String str) =>
    ForgotPasswordModelRequest.fromJson(json.decode(str));

String ForgotPasswordModelRequestToJson(ForgotPasswordModelRequest data) =>
    json.encode(data.toJson());

class ForgotPasswordModelRequest {
  String email;

  ForgotPasswordModelRequest({
    required this.email,
  });

  factory ForgotPasswordModelRequest.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordModelRequest(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

ResetPasswordModelRequeset ResetPasswordModelRequesetFromJson(String str) =>
    ResetPasswordModelRequeset.fromJson(json.decode(str));

String ResetPasswordModelRequesetToJson(ResetPasswordModelRequeset data) =>
    json.encode(data.toJson());

class ResetPasswordModelRequeset {
  String email;
  String password;
  String passwordConfirmation;

  ResetPasswordModelRequeset(
      {required this.email,
      required this.password,
      required this.passwordConfirmation});

  factory ResetPasswordModelRequeset.fromJson(Map<String, dynamic> json) =>
      ResetPasswordModelRequeset(
        email: json["email"],
        password: json["email"],
        passwordConfirmation: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "passwordConfirmation": passwordConfirmation,
      };
}
