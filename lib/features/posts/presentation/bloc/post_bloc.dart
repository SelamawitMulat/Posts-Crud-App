import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_crud_app/features/posts/domain/entities/post.dart';
import 'package:posts_crud_app/features/posts/domain/usecases/create_post.dart';
import 'package:posts_crud_app/features/posts/domain/usecases/delete_post.dart';
import 'package:posts_crud_app/features/posts/domain/usecases/get_posts.dart';
import 'package:posts_crud_app/features/posts/domain/usecases/update_post.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final FetchPostsUseCase getPostsUseCase;
  final CreatePostUseCase createPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final DeletePostUseCase deletePostUseCase;

  List<Post> _currentPosts = [];
  String _currentSearchQuery = '';

  PostBloc({
    required this.getPostsUseCase,
    required this.createPostUseCase,
    required this.updatePostUseCase,
    required this.deletePostUseCase,
  }) : super(const PostLoading()) {
    on<LoadPosts>(_onLoadPosts);
    on<AddPost>(_onAddPost);
    on<UpdatePost>(_onUpdatePost);
    on<DeletePost>(_onDeletePost);
    on<SearchPosts>(_onSearchPosts);
    on<ToggleTheme>(_onToggleTheme);
    on<UpdateUserProfile>(_onUpdateUserProfile);
  }

  Future<void> _onLoadPosts(LoadPosts event, Emitter<PostState> emit) async {
    emit(PostLoading(
        isDarkMode: state.isDarkMode,
        userName: state.userName,
        userEmail: state.userEmail,
        userBio: state.userBio));

    final (failure, posts) = await getPostsUseCase.execute();

    if (failure != null) {
      emit(PostError(failure,
          isDarkMode: state.isDarkMode,
          userName: state.userName,
          userEmail: state.userEmail,
          userBio: state.userBio));
    } else if (posts == null || posts.isEmpty) {
      _currentPosts = [];
      emit(PostEmpty(
          isDarkMode: state.isDarkMode,
          userName: state.userName,
          userEmail: state.userEmail,
          userBio: state.userBio));
    } else {
      _currentPosts = List.from(posts);
      emit(PostLoaded(List.from(_currentPosts),
          searchQuery: _currentSearchQuery,
          isDarkMode: state.isDarkMode,
          userName: state.userName,
          userEmail: state.userEmail,
          userBio: state.userBio));
    }
  }

  Future<void> _onAddPost(AddPost event, Emitter<PostState> emit) async {
    final (failure, createdPost) = await createPostUseCase.execute(event.post);
    if (failure == null && createdPost != null) {
      _currentPosts.insert(0, createdPost);
      emit(PostLoaded(List.from(_currentPosts),
          searchQuery: _currentSearchQuery,
          isDarkMode: state.isDarkMode,
          userName: state.userName,
          userEmail: state.userEmail,
          userBio: state.userBio));
    } else {
      emit(PostError(failure ?? 'Failed to attach entry records.',
          isDarkMode: state.isDarkMode,
          userName: state.userName,
          userEmail: state.userEmail,
          userBio: state.userBio));
    }
  }

  Future<void> _onUpdatePost(UpdatePost event, Emitter<PostState> emit) async {
    final (failure, updatedPost) = await updatePostUseCase.execute(event.post);
    if (failure == null && updatedPost != null) {
      final index = _currentPosts.indexWhere((p) => p.id == updatedPost.id);
      if (index != -1) {
        _currentPosts[index] = updatedPost;
      }
      emit(PostLoaded(List.from(_currentPosts),
          searchQuery: _currentSearchQuery,
          isDarkMode: state.isDarkMode,
          userName: state.userName,
          userEmail: state.userEmail,
          userBio: state.userBio));
    } else {
      emit(PostError(failure ?? 'Failed to save modifications.',
          isDarkMode: state.isDarkMode,
          userName: state.userName,
          userEmail: state.userEmail,
          userBio: state.userBio));
    }
  }

  Future<void> _onDeletePost(DeletePost event, Emitter<PostState> emit) async {
    final (failure, success) = await deletePostUseCase.execute(event.id);
    if (failure == null && success == true) {
      _currentPosts.removeWhere((p) => p.id == event.id);
      if (_currentPosts.isEmpty) {
        emit(PostEmpty(
            isDarkMode: state.isDarkMode,
            userName: state.userName,
            userEmail: state.userEmail,
            userBio: state.userBio));
      } else {
        emit(PostLoaded(List.from(_currentPosts),
            searchQuery: _currentSearchQuery,
            isDarkMode: state.isDarkMode,
            userName: state.userName,
            userEmail: state.userEmail,
            userBio: state.userBio));
      }
    } else {
      emit(PostError(failure ?? 'Failed to purge record.',
          isDarkMode: state.isDarkMode,
          userName: state.userName,
          userEmail: state.userEmail,
          userBio: state.userBio));
    }
  }

  void _onSearchPosts(SearchPosts event, Emitter<PostState> emit) {
    _currentSearchQuery = event.query;
    if (state is PostLoaded) {
      emit(PostLoaded(List.from(_currentPosts),
          searchQuery: _currentSearchQuery,
          isDarkMode: state.isDarkMode,
          userName: state.userName,
          userEmail: state.userEmail,
          userBio: state.userBio));
    }
  }

  void _onToggleTheme(ToggleTheme event, Emitter<PostState> emit) {
    final newMode = !state.isDarkMode;
    if (state is PostLoaded) {
      emit(PostLoaded(List.from(_currentPosts),
          searchQuery: _currentSearchQuery,
          isDarkMode: newMode,
          userName: state.userName,
          userEmail: state.userEmail,
          userBio: state.userBio));
    } else if (state is PostEmpty) {
      emit(PostEmpty(
          isDarkMode: newMode,
          userName: state.userName,
          userEmail: state.userEmail,
          userBio: state.userBio));
    } else if (state is PostLoading) {
      emit(PostLoading(
          isDarkMode: newMode,
          userName: state.userName,
          userEmail: state.userEmail,
          userBio: state.userBio));
    }
  }

  void _onUpdateUserProfile(UpdateUserProfile event, Emitter<PostState> emit) {
    if (state is PostLoaded) {
      emit(PostLoaded(List.from(_currentPosts),
          searchQuery: _currentSearchQuery,
          isDarkMode: state.isDarkMode,
          userName: event.name,
          userEmail: event.email,
          userBio: event.bio));
    } else if (state is PostEmpty) {
      emit(PostEmpty(
          isDarkMode: state.isDarkMode,
          userName: event.name,
          userEmail: event.email,
          userBio: event.bio));
    } else if (state is PostLoading) {
      emit(PostLoading(
          isDarkMode: state.isDarkMode,
          userName: event.name,
          userEmail: event.email,
          userBio: event.bio));
    }
  }
}
