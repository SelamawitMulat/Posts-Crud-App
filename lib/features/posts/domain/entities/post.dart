class Post {
  final String id;
  final String title;
  final String body;

  Post({
    required this.id,
    required this.title,
    required this.body,
  });

  // Factory constructor to build a Post object from incoming API JSON data
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      body: json['body']?.toString() ?? '',
    );
  }

  // Converts our Post object to JSON format for outgoing Dio API requests
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }

  // Helper method to support clean copy modifications in our BLoC layer
  Post copyWith({String? id, String? title, String? body}) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }
}
