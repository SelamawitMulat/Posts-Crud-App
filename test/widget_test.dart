// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Domain Layer Contracts & Entities
import 'package:posts_crud_app/features/posts/domain/entities/post.dart';
import 'package:posts_crud_app/features/posts/domain/repository/post_repository.dart';
import 'package:posts_crud_app/features/posts/domain/usecases/create_post.dart';
import 'package:posts_crud_app/features/posts/domain/usecases/delete_post.dart';
import 'package:posts_crud_app/features/posts/domain/usecases/get_posts.dart';
import 'package:posts_crud_app/features/posts/domain/usecases/update_post.dart';

// Presentation Layer Setup
import 'package:posts_crud_app/main.dart';
import 'package:posts_crud_app/features/posts/presentation/pages/home_page.dart';

/// A completely isolated Mock Repository to satisfy tests safely without real network bindings
class MockPostRepository implements PostRepository {
  @override
  Future<(String? failure, List<Post>? posts)> getPosts() async {
    return (
      null,
      [
        Post(
            id: '1',
            title: 'Mock Test Title',
            body: 'Mock test post description body elements.'),
      ]
    );
  }

  @override
  Future<(String? failure, Post? createdPost)> createPost(Post post) async {
    return (null, post);
  }

  @override
  Future<(String? failure, Post? updatedPost)> modifyPost(Post post) async {
    return (null, post);
  }

  @override
  Future<(String? failure, bool? success)> removePost(String id) async {
    return (null, true);
  }
}

void main() {
  testWidgets('App initialization smoke test and view configuration check',
      (WidgetTester tester) async {
    final mockRepository = MockPostRepository();

    final getPostsUseCase = FetchPostsUseCase(mockRepository);
    final createPostUseCase = CreatePostUseCase(mockRepository);
    final updatePostUseCase = UpdatePostUseCase(mockRepository);
    final deletePostUseCase = DeletePostUseCase(mockRepository);

    // Pump the root component layout containing our custom title settings
    await tester.pumpWidget(
      PostsCrudApp(
        getPostsUseCase: getPostsUseCase,
        createPostUseCase: createPostUseCase,
        updatePostUseCase: updatePostUseCase,
        deletePostUseCase: deletePostUseCase,
      ),
    );

    await tester.pump();

    // Verify widgets match and tree resolves flawlessly
    expect(find.byType(PostsCrudApp), findsOneWidget);
    expect(find.byType(HomePage), findsOneWidget);
  });
}
