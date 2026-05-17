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
}

class UpdatePost extends PostEvent {
  final Post post;
  const UpdatePost(this.post);
}

class DeletePost extends PostEvent {
  final String id;
  const DeletePost(this.id);
}

// 1. Search UI trigger event
class SearchPosts extends PostEvent {
  final String query;
  const SearchPosts(this.query);
}

// 2. Theme settings layout switcher event
class ToggleTheme extends PostEvent {}

// 3. Global profile updater event
class UpdateUserProfile extends PostEvent {
  final String name;
  final String email;
  final String bio;
  const UpdateUserProfile(
      {required this.name, required this.email, required this.bio});
}
