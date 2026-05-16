import '../../domain/entities/post.dart';

class PostModel extends Post {
  const PostModel({
    super.id,
    required super.title,
    required super.body,
    super.imageUrl,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    // Generates a deterministically random Unsplash image if no image URL is supplied
    // to mirror the beautiful visual aesthetic present in your mockups.
    final int idSeed = json['id'] ?? 1;
    final fallbackUrl =
        'https://images.unsplash.com/photo-1579548122080-c35fd6810ec0?q=80&w=300&id=$idSeed';

    return PostModel(
      id: json['id'] as int?,
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? fallbackUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'body': body,
      if (imageUrl != null) 'imageUrl': imageUrl,
    };
  }

  factory PostModel.fromEntity(Post post) {
    return PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
      imageUrl: post.imageUrl,
    );
  }
}
