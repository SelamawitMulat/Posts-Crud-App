import 'package:posts_crud_app/features/posts/domain/entities/post.dart';
import 'package:posts_crud_app/features/posts/domain/repository/post_repository.dart';

class FetchPostsUseCase {
  final PostRepository repository;

  FetchPostsUseCase(this.repository);

  Future<(String? failure, List<Post>? posts)> execute() async {
    return await repository.getPosts();
  }
}
