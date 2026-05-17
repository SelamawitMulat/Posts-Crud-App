import 'package:dio/dio.dart';
import '../../../../core/utils/constants.dart';
import '../../domain/entities/post.dart';

class PostRemoteDataSource {
  final Dio dio;

  PostRemoteDataSource({required this.dio});

  // 1. READ
  Future<Response> getPosts() async {
    return await dio.get(AppConstants.postsEndpoint);
  }

  // 2. CREATE
  Future<Response> createPost(Post post) async {
    return await dio.post(
      AppConstants.postsEndpoint,
      data: post.toJson(),
    );
  }

  // 3. UPDATE
  Future<Response> modifyPost(Post post) async {
    return await dio.put(
      '${AppConstants.postsEndpoint}/${post.id}',
      data: post.toJson(),
    );
  }

  // 4. DELETE
  Future<Response> removePost(String id) async {
    return await dio.delete('${AppConstants.postsEndpoint}/$id');
  }
}
