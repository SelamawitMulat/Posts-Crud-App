import 'package:dio/dio.dart';
import '../../domain/entities/post.dart';
import '../../domain/repository/post_repository.dart';
import '../datasource/post_remote_data_source.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<(String?, List<Post>?)> getPosts() async {
    try {
      final response = await remoteDataSource.getPosts();
      if (response.statusCode == 200 && response.data is List) {
        final List jsonList = response.data;
        final posts = jsonList.map((json) => Post.fromJson(json)).toList();
        return (null, posts);
      }
      return ('Unexpected response format from backend server.', null);
    } on DioException catch (e) {
      return (
        e.message ?? 'Failed to catch remote server payload links.',
        null
      );
    }
  }

  @override
  Future<(String?, Post?)> createPost(Post post) async {
    try {
      final response = await remoteDataSource.createPost(post);
      if (response.statusCode == 201 || response.statusCode == 200) {
        return (null, Post.fromJson(response.data));
      }
      return (
        'Server dropped remote collection validation authorization.',
        null
      );
    } on DioException catch (e) {
      return (
        e.message ?? 'Could not append cloud database entity records.',
        null
      );
    }
  }

  @override
  Future<(String?, Post?)> modifyPost(Post post) async {
    try {
      final response = await remoteDataSource.modifyPost(post);
      if (response.statusCode == 200) {
        return (null, Post.fromJson(response.data));
      }
      return ('Server rejected updating execution metadata paths.', null);
    } on DioException catch (e) {
      return (
        e.message ?? 'Downstream modifications synchronization failed.',
        null
      );
    }
  }

  @override
  Future<(String?, bool?)> removePost(String id) async {
    try {
      final response = await remoteDataSource.removePost(id);
      if (response.statusCode == 200) {
        return (null, true);
      }
      return ('Server dropped records removal operation permissions.', null);
    } on DioException catch (e) {
      return (e.message ?? 'Purge execution pipeline sequence dropped.', null);
    }
  }
}
