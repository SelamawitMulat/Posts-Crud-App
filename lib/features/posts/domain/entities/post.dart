import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int? id;
  final String title;
  final String body;
  final String? imageUrl;

  const Post({
    this.id,
    required this.title,
    required this.body,
    this.imageUrl,
  });

  Post copyWith({
    int? id,
    String? title,
    String? body,
    String? imageUrl,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [id, title, body, imageUrl];
}
