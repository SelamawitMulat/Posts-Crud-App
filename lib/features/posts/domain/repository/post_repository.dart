import '../../../../core/error/failures.dart';
import '../entities/post.dart';

abstract class PostRepository {
  Future<(Failure?, List<Post>?)> getPosts();
  Future<(Failure?, Post?)> createPost(Post post);
  Future<(Failure?, Post?)> modifyPost(Post post);
  Future<(Failure?, bool?)> removePost(int id);
}
