import 'dart:convert';

List<VideoModel> VideoModelFromJson(String str) => List<VideoModel>.from(json.decode(str).map((x) => VideoModel.fromJson(x)));

String VideoModelToJson(List<VideoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VideoModel {
  String id;
  String path;
  String authorName;
  String? description;

  VideoModel({
    required this.id,
    required this.path,
    required this.authorName,
    this.description,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
    id: json["id"],
    path: json["path"],
    description: json["description"],
    authorName: json["authorName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "path": path,
    "authorName": authorName,
    "description": description,
  };
}
