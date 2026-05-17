import 'package:posts_crud_app/features/posts/domain/repository/post_repository.dart';

class DeletePostUseCase {
  final PostRepository repository;

  DeletePostUseCase(this.repository);

  Future<(String? failure, bool? success)> execute(String id) async {
    return await repository.removePost(id);
  }
}
