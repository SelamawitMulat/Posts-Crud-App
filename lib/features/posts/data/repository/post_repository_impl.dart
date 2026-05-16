import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/post.dart';
import '../../domain/repository/post_repository.dart';
import '../datasource/post_remote_data_source.dart';
import '../models/post_model.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<(Failure?, List<Post>?)> getPosts() async {
    try {
      final remotePosts = await remoteDataSource.getAllPosts();
      return (null, remotePosts);
    } on ServerException catch (e) {
      return (ServerFailure(e.message), null);
    }
  }

  @override
  Future<(Failure?, Post?)> createPost(Post post) async {
    try {
      final model = PostModel.fromEntity(post);
      final result = await remoteDataSource.addPost(model);
      return (null, result);
    } on ServerException catch (e) {
      return (ServerFailure(e.message), null);
    }
  }

  @override
  Future<(Failure?, Post?)> modifyPost(Post post) async {
    try {
      final model = PostModel.fromEntity(post);
      final result = await remoteDataSource.updatePost(model);
      return (null, result);
    } on ServerException catch (e) {
      return (ServerFailure(e.message), null);
    }
  }

  @override
  Future<(Failure?, bool?)> removePost(int id) async {
    try {
      await remoteDataSource.deletePost(id);
      return (null, true);
    } on ServerException catch (e) {
      return (ServerFailure(e.message), null);
    }
  }
}
