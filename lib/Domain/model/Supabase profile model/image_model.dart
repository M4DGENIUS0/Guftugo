class ImageModel {
  final String url;
  final String fileName;
  final String? format; // (optional: file format like .jpg, .png)
  final int? size; // (optional: file size in bytes)
  final DateTime? uploadedAt; // (optional: upload timestamp)

  ImageModel({
    required this.url,
    required this.fileName,
    this.format,
    this.size,
    this.uploadedAt,
  });

  // You can create a factory method to convert JSON data to ImageModel
  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      url: json['url'],
      fileName: json['file_name'],
      format: json['format'],
      size: json['size'],
      uploadedAt: json['uploaded_at'] != null
          ? DateTime.parse(json['uploaded_at'])
          : null,
    );
  }

  // Optionally, create a method to convert ImageModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'file_name': fileName,
      'format': format,
      'size': size,
      'uploaded_at': uploadedAt?.toIso8601String(),
    };
  }
}
