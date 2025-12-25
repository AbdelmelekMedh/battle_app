import 'package:battle_app/models/image_profil_model.dart';

class CommentModel {
  final String id;
  final String content;
  final String authorId;
  final String authorName;
  final ImageProfile? authorAvatar;
  final String? parentCommentId;
  DateTime createdAt;
  DateTime updatedAt;

  CommentModel({
    required this.id,
    required this.content,
    required this.authorId,
    required this.authorName,
    this.authorAvatar,
    this.parentCommentId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as String,
      content: json['content'] as String,
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String,

      authorAvatar: json['authorAvatar'] != null
          ? ImageProfile.fromJson(json['authorAvatar'])
          : null,

      parentCommentId: json['parentCommentId'],

      createdAt: DateTime.parse(json['createdAt']),

      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.fromMillisecondsSinceEpoch(0), // or createdAt
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "authorId": authorId,
    "authorName": authorName,
    "authorAvatar": authorAvatar?.toJson(),
    "parentCommentId": parentCommentId,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
