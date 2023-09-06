import 'dart:convert';


RegisterModelRequest RegisterModelRequestFromJson(String str) =>
    RegisterModelRequest.fromJson(json.decode(str));

String RegisterModelRequestToJson(RegisterModelRequest data) =>
    json.encode(data.toJson());

class RegisterModelRequest {
  String firstName;
  String lastName;
  String email;
  String password;
  String passwordConfirmation;

  RegisterModelRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  factory RegisterModelRequest.fromJson(Map<String, dynamic> json) =>
      RegisterModelRequest(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"],
        passwordConfirmation: json["passwordConfirmation"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "passwordConfirmation": passwordConfirmation,
      };
}

