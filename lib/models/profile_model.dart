// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ProfileModel profileFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  String id;
  String userId;
  String name;
  String address;
  String phoneNumber;
  String bio;
  String gender;
  DateTime? dateOfBirth;
  ImageProfile? imageProfile;
  DateTime createdAt;
  DateTime updatedAt;
  SocialLinks? socialLinks;
  List<String> interests;
  List<String> languages;
  bool active;

  ProfileModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.bio,
    required this.gender,
    this.dateOfBirth,
    this.imageProfile,
    required this.createdAt,
    required this.updatedAt,
    required this.socialLinks,
    required this.interests,
    required this.languages,
    required this.active,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json["id"],
    userId: json["userId"],
    name: json["name"] ?? "",
    address: json["address"] ?? "",
    phoneNumber: json["phoneNumber"] ?? "",
    bio: json["bio"] ?? "",
    gender: json["gender"] ?? "",
    dateOfBirth: json["dateOfBirth"] != null
        ? DateTime.parse(json["dateOfBirth"])
        : null,
    imageProfile: json["imageProfile"] != null
        ? ImageProfile.fromJson(json["imageProfile"])
        : null,
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    socialLinks: SocialLinks.fromJson(json["socialLinks"] ?? {}),
    interests: List<String>.from(json["interests"] ?? []),
    languages: List<String>.from(json["languages"] ?? []),
    active: json["active"] ?? true,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "name": name,
    "address": address,
    "phoneNumber": phoneNumber,
    "bio": bio,
    "gender": gender,
    "dateOfBirth": dateOfBirth?.toIso8601String(),
    "imageProfile": imageProfile?.toJson(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "socialLinks": socialLinks?.toJson(),
    "interests": interests,
    "languages": languages,
    "active": active,
  };
}

class ImageProfile {
  String? filename;
  String? fileType;
  String? filePathUrl;

  ImageProfile({
    this.filename,
    this.fileType,
    this.filePathUrl,
  });

  factory ImageProfile.fromJson(Map<String, dynamic> json) => ImageProfile(
    filename: json["filename"],
    fileType: json["fileType"],
    filePathUrl: json["filePathUrl"],
  );

  Map<String, dynamic> toJson() => {
    "filename": filename,
    "fileType": fileType,
    "filePathUrl": filePathUrl,
  };
}

class SocialLinks {
  Map<String, String> links;

  SocialLinks({required this.links});

  factory SocialLinks.fromJson(Map<String, dynamic> json) =>
      SocialLinks(
        links: json.map((k, v) => MapEntry(k, v.toString())),
      );

  Map<String, dynamic> toJson() => links;
}
