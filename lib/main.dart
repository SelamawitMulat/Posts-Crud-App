import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/api/dio_client.dart';
import 'features/posts/data/datasource/post_remote_data_source.dart';
import 'features/posts/data/repository/post_repository_impl.dart';
import 'features/posts/presentation/bloc/post_bloc.dart';
import 'features/posts/presentation/bloc/post_event.dart';
import 'features/posts/presentation/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Instantiate network stack and layers using Clean Architecture rules
  final dioClient = DioClient();
  final remoteDataSource = PostRemoteDataSourceImpl(client: dioClient);
  final postRepository = PostRepositoryImpl(remoteDataSource: remoteDataSource);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: postRepository),
      ],
      child: BlocProvider(
        create: (context) =>
            PostBloc(repository: postRepository)..add(LoadPosts()),
        child: const PostsCrudApp(),
      ),
    ),
  );
}

class PostsCrudApp extends StatelessWidget {
  const PostsCrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Posts CRUD App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF2F80ED),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2F80ED),
          primary: const Color(0xFF2F80ED),
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF1B254B)),
          titleTextStyle: TextStyle(
            color: Color(0xFF1B254B),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        cardColor: Colors.white,
      ),
      home: const HomePage(),
    );
  }
}
