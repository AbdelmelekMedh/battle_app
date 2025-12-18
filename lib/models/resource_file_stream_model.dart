class ResourceFileStreamModel {
  String id;
  String filename;
  String storedName;
  String authorId;
  String authorName;
  String path;
  int downloads;
  int shares;
  int views;
  int likes;
  int commentsCount;
  String description;
  List<String> tags;
  List<dynamic> comments;
  DateTime? createdAt;
  bool isPublic;

  ResourceFileStreamModel({
    required this.id,
    required this.filename,
    required this.storedName,
    required this.authorId,
    required this.authorName,
    required this.path,
    required this.downloads,
    required this.shares,
    required this.views,
    required this.likes,
    required this.commentsCount,
    required this.description,
    required this.tags,
    required this.comments,
    this.createdAt,
    required this.isPublic,
  });

  factory ResourceFileStreamModel.fromJson(Map<String, dynamic> json) {
    return ResourceFileStreamModel(
      id: json["id"],
      filename: json["filename"],
      storedName: json["storedName"],
      authorId: json["authorId"],
      authorName: json["authorName"],
      path: json["path"],
      downloads: json["downloads"] ?? 0,
      shares: json["shares"] ?? 0,
      views: json["views"] ?? 0,
      likes: json["likes"] ?? 0,
      commentsCount: json["commentsCount"] ?? 0,
      description: json["description"] ?? "",
      tags: json["tags"] != null ? List<String>.from(json["tags"]) : [],
      comments: json["comments"] != null ? List<dynamic>.from(json["comments"]) : [],
      createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
      isPublic: json["public"] ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "filename": filename,
    "storedName": storedName,
    "authorId": authorId,
    "authorName": authorName,
    "path": path,
    "downloads": downloads,
    "shares": shares,
    "views": views,
    "likes": likes,
    "commentsCount": commentsCount,
    "description": description,
    "tags": tags,
    "comments": comments,
    "createdAt": createdAt?.toIso8601String(),
    "public": isPublic,
  };
}
