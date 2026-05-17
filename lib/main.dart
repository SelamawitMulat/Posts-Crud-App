import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Import Core Layer Utilities
import 'package:posts_crud_app/core/api/dio_client.dart';

// Import Clean Architecture Layers
import 'features/posts/data/datasource/post_remote_data_source.dart';
import 'features/posts/data/repository/post_repository_impl.dart';
import 'features/posts/presentation/bloc/post_bloc.dart';
import 'features/posts/presentation/bloc/post_event.dart';
import 'features/posts/presentation/bloc/post_state.dart'; // Added to ensure PostState is found
import 'features/posts/presentation/pages/home_page.dart';

void main() {
  // 1. Initialize our centralized Core Network client
  final DioClient coreDioClient = DioClient();

  // 2. Build out data-layer dependencies
  final PostRemoteDataSource remoteDataSource =
      PostRemoteDataSource(dio: coreDioClient.dio);
  final PostRepositoryImpl postRepository =
      PostRepositoryImpl(remoteDataSource: remoteDataSource);

  runApp(PostsCrudApp(repository: postRepository));
}

class PostsCrudApp extends StatelessWidget {
  final PostRepositoryImpl repository;

  const PostsCrudApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    // FIX: Provide the BLoC at the very top so the BlocBuilder inside can access it safely
    return BlocProvider<PostBloc>(
      create: (context) => PostBloc(repository: repository)..add(LoadPosts()),
      child: BlocBuilder<PostBloc, PostState>(
        buildWhen: (previous, current) =>
            previous.isDarkMode != current.isDarkMode,
        builder: (context, state) {
          return MaterialApp(
            title: 'Clean CRUD App',
            debugShowCheckedModeBanner: false,
            // FIX: Dynamically switch the overall app brightness based on global BLoC state toggles
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
