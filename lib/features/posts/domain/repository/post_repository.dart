import '../entities/post.dart';

abstract class PostRepository {
  Future<(String? failure, List<Post>? posts)> getPosts();
  Future<(String? failure, Post? post)> createPost(Post post);
  Future<(String? failure, Post? post)> modifyPost(Post post);
  Future<(String? failure, bool? success)> removePost(String id);
}
