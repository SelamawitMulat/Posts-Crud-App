import 'package:equatable/equatable.dart';
import '../../domain/entities/post.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object?> get props => [];
}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;
  const PostLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}

class PostEmpty extends PostState {}

class PostError extends PostState {
  final String errorMessage;
  const PostError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
