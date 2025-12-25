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