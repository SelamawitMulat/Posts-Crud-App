import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:posts_crud_app/main.dart';
import 'package:posts_crud_app/features/posts/data/datasource/post_remote_data_source.dart';
import 'package:posts_crud_app/features/posts/data/repository/post_repository_impl.dart';

void main() {
  testWidgets('App launch smoke test', (WidgetTester tester) async {
    // 1. Mock or create the required underlying architecture instances for the test context
    final Dio dioClient = Dio();
    final PostRemoteDataSource remoteDataSource =
        PostRemoteDataSource(dio: dioClient);
    final PostRepositoryImpl postRepository =
        PostRepositoryImpl(remoteDataSource: remoteDataSource);

    // 2. Build our app and trigger a frame, passing the mandatory repository dependency
    await tester.pumpWidget(PostsCrudApp(repository: postRepository));

    // 3. Verifies that the app successfully sets up without crashing
    expect(find.byType(PostsCrudApp), findsOneWidget);
  });
}
