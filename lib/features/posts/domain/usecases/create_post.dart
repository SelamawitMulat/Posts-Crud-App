import 'package:posts_crud_app/features/posts/domain/entities/post.dart';
import 'package:posts_crud_app/features/posts/domain/repository/post_repository.dart';

class CreatePostUseCase {
  final PostRepository repository;

  CreatePostUseCase(this.repository);

  Future<(String? failure, Post? createdPost)> execute(Post post) async {
    return await repository.createPost(post);
  }
}
