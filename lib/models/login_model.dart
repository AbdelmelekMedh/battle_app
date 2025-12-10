import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  String refreshToken;
  final String id;
  final String username;
  final String email;
  final List<String> roles;
  String token;
  final String type;

  LoginResponseModel({
    required this.refreshToken,
    required this.id,
    required this.username,
    required this.email,
    required this.roles,
    required this.token,
    required this.type,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        refreshToken: json["refreshToken"],
        id: json["id"],
        username: json["username"],
        email: json["email"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        token: json["token"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
    "refreshToken": refreshToken,
    "id": id,
    "username": username,
    "email": email,
    "roles": List<dynamic>.from(roles.map((x) => x)),
    "token": token,
    "type": type,
  };
}
