import 'package:dio/dio.dart';
import '../../../../core/api/dio_client.dart';
import '../../../../core/error/exceptions.dart';
import '../models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<PostModel> addPost(PostModel post);
  Future<PostModel> updatePost(PostModel post);
  Future<void> deletePost(int id);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final DioClient client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    try {
      final response = await client.dio.get('/posts');
      if (response.statusCode == 200) {
        final List list = response.data as List;
        return list.map((json) => PostModel.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to load posts from server.');
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Network collection protocol error.');
    }
  }

  @override
  Future<PostModel> addPost(PostModel post) async {
    try {
      final response = await client.dio.post('/posts', data: post.toJson());
      if (response.statusCode == 201 || response.statusCode == 200) {
        return PostModel.fromJson(response.data);
      } else {
        throw ServerException('Failed to generate resource on backend.');
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to submit post data.');
    }
  }

  @override
  Future<PostModel> updatePost(PostModel post) async {
    try {
      final response =
          await client.dio.put('/posts/${post.id}', data: post.toJson());
      if (response.statusCode == 200) {
        return PostModel.fromJson(response.data);
      } else {
        throw ServerException('Failed to execute target put update lifecycle.');
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server sync failed during update.');
    }
  }

  @override
  Future<void> deletePost(int id) async {
    try {
      final response = await client.dio.delete('/posts/$id');
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw ServerException('Destruction request declined by target host.');
      }
    } on DioException catch (e) {
      throw ServerException(
          e.message ?? 'Network execution failure during deletion.');
    }
  }
}
