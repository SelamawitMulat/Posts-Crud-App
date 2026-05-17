import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Core Utilities
import 'package:posts_crud_app/core/api/dio_client.dart';

// Data Layer Dependencies
import 'package:posts_crud_app/features/posts/data/datasource/post_remote_data_source.dart';
import 'package:posts_crud_app/features/posts/data/repository/post_repository_impl.dart';

// Domain Layer Use Cases
import 'package:posts_crud_app/features/posts/domain/usecases/create_post.dart';
import 'package:posts_crud_app/features/posts/domain/usecases/delete_post.dart';
import 'package:posts_crud_app/features/posts/domain/usecases/get_posts.dart';
import 'package:posts_crud_app/features/posts/domain/usecases/update_post.dart';

// Presentation Layer State Management & Pages
import 'package:posts_crud_app/features/posts/presentation/bloc/post_bloc.dart';
import 'package:posts_crud_app/features/posts/presentation/bloc/post_event.dart';
import 'package:posts_crud_app/features/posts/presentation/bloc/post_state.dart';
import 'package:posts_crud_app/features/posts/presentation/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Initialize centralized Core Network client
  final DioClient coreDioClient = DioClient();

  // 2. Build data-layer dependencies
  // FIXED HERE: Reverted back to the exact parameter label (dio: coreDioClient.dio) your class constructor expects!
  final PostRemoteDataSource remoteDataSource =
      PostRemoteDataSource(dio: coreDioClient.dio);
  final PostRepositoryImpl postRepository =
      PostRepositoryImpl(remoteDataSource: remoteDataSource);

  // 3. Instantiate Domain Layer Use Cases
  final getPostsUseCase = FetchPostsUseCase(postRepository);
  final createPostUseCase = CreatePostUseCase(postRepository);
  final updatePostUseCase = UpdatePostUseCase(postRepository);
  final deletePostUseCase = DeletePostUseCase(postRepository);

  runApp(PostsCrudApp(
    getPostsUseCase: getPostsUseCase,
    createPostUseCase: createPostUseCase,
    updatePostUseCase: updatePostUseCase,
    deletePostUseCase: deletePostUseCase,
  ));
}

class PostsCrudApp extends StatelessWidget {
  final FetchPostsUseCase getPostsUseCase;
  final CreatePostUseCase createPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final DeletePostUseCase deletePostUseCase;

  const PostsCrudApp({
    super.key,
    required this.getPostsUseCase,
    required this.createPostUseCase,
    required this.updatePostUseCase,
    required this.deletePostUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostBloc>(
      create: (context) => PostBloc(
        getPostsUseCase: getPostsUseCase,
        createPostUseCase: createPostUseCase,
        updatePostUseCase: updatePostUseCase,
        deletePostUseCase: deletePostUseCase,
      )..add(LoadPosts()),
      child: BlocBuilder<PostBloc, PostState>(
        buildWhen: (previous, current) =>
            previous.isDarkMode != current.isDarkMode,
        builder: (context, state) {
          return MaterialApp(
            title: 'Crud Posts App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: const Color(0xFF2F80ED),
              brightness: state.isDarkMode ? Brightness.dark : Brightness.light,
              appBarTheme: AppBarTheme(
                backgroundColor:
                    state.isDarkMode ? const Color(0xFF131A32) : Colors.white,
                elevation: 0,
                iconTheme: IconThemeData(
                  color:
                      state.isDarkMode ? Colors.white : const Color(0xFF1B254B),
                ),
              ),
            ),
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
