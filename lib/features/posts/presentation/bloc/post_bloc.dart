import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repository/post_repository.dart';
import '../../domain/entities/post.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;
  List<Post> _currentPosts = [];

  PostBloc({required this.repository}) : super(PostLoading()) {
    on<LoadPosts>(_onLoadPosts);
    on<AddPost>(_onAddPost);
    on<UpdatePost>(_onUpdatePost);
    on<DeletePost>(_onDeletePost);
  }

  Future<void> _onLoadPosts(LoadPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    final (failure, posts) = await repository.getPosts();
    if (failure != null) {
      emit(PostError(failure.message));
    } else if (posts == null || posts.isEmpty) {
      _currentPosts = [];
      emit(PostEmpty());
    } else {
      _currentPosts = List.from(posts);
      emit(PostLoaded(_currentPosts));
    }
  }

  Future<void> _onAddPost(AddPost event, Emitter<PostState> emit) async {
    final (failure, createdPost) = await repository.createPost(event.post);
    if (failure == null && createdPost != null) {
      // JSONPlaceholder generates a simulated ID like 101 for new items
      _currentPosts.insert(0, createdPost);
      emit(PostLoaded(List.from(_currentPosts)));
    } else {
      emit(PostError(failure?.message ?? 'Failed to attach new entry.'));
    }
  }

  Future<void> _onUpdatePost(UpdatePost event, Emitter<PostState> emit) async {
    final (failure, updatedPost) = await repository.modifyPost(event.post);
    if (failure == null && updatedPost != null) {
      final index = _currentPosts.indexWhere((p) => p.id == event.post.id);
      if (index != -1) {
        // Standard clear target matching logic
        _currentPosts[index] = updatedPost;
      }
      emit(PostLoaded(List.from(_currentPosts)));
    } else {
      emit(PostError(failure?.message ?? 'Failed to deploy mutations.'));
    }
  }

  Future<void> _onDeletePost(DeletePost event, Emitter<PostState> emit) async {
    final (failure, success) = await repository.removePost(event.id);
    if (failure == null && success == true) {
      _currentPosts.removeWhere((p) => p.id == event.id);
      if (_currentPosts.isEmpty) {
        emit(PostEmpty());
      } else {
        emit(PostLoaded(List.from(_currentPosts)));
      }
    } else {
      emit(PostError(failure?.message ?? 'Purge command dropped by cluster.'));
    }
  }
}
