import 'package:equatable/equatable.dart';
import '../../domain/entities/post.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

class LoadPosts extends PostEvent {}

class AddPost extends PostEvent {
  final Post post;
  const AddPost(this.post);

  @override
  List<Object?> get props => [post];
}

class UpdatePost extends PostEvent {
  final Post post;
  const UpdatePost(this.post);

  @override
  List<Object?> get props => [post];
}

class DeletePost extends PostEvent {
  final int id;
  const DeletePost(this.id);

  @override
  List<Object?> get props => [id];
}
