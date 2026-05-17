import 'package:posts_crud_app/features/posts/domain/entities/post.dart';
import 'package:posts_crud_app/features/posts/domain/repository/post_repository.dart';

class UpdatePostUseCase {
  final PostRepository repository;

  UpdatePostUseCase(this.repository);

  Future<(String? failure, Post? updatedPost)> execute(Post post) async {
    return await repository.modifyPost(post);
  }
}
