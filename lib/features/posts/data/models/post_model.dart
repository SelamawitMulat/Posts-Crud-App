import '../../domain/entities/post.dart';

class PostModel extends Post {
  PostModel({
    required super.id,
    required super.title,
    required super.body,
  });

  // Factory to parse incoming JSON map fields from MockAPI safely
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      body: json['body']?.toString() ?? '',
    );
  }

  // Translates entity values back into raw string/map formats for outgoing Dio payloads
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }
}
