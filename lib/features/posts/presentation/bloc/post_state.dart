import 'package:equatable/equatable.dart';
import '../../domain/entities/post.dart';

abstract class PostState extends Equatable {
  final bool isDarkMode;
  final String userName;
  final String userEmail;
  final String userBio;

  const PostState({
    this.isDarkMode = false,
    this.userName = 'Alex Johnson',
    this.userEmail = 'alex@postsmanager.pro',
    this.userBio = 'Productivity enthusiast and design lover.',
  });

  @override
  List<Object?> get props => [isDarkMode, userName, userEmail, userBio];
}

class PostLoading extends PostState {
  const PostLoading(
      {super.isDarkMode, super.userName, super.userEmail, super.userBio});
}

class PostEmpty extends PostState {
  const PostEmpty(
      {super.isDarkMode, super.userName, super.userEmail, super.userBio});
}

class PostLoaded extends PostState {
  final List<Post> posts;
  final String searchQuery;

  const PostLoaded(
    this.posts, {
    this.searchQuery = '',
    super.isDarkMode,
    super.userName,
    super.userEmail,
    super.userBio,
  });

  // Getter to provide dynamically filtered search result arrays on the fly
  List<Post> get filteredPosts {
    if (searchQuery.trim().isEmpty) return posts;
    return posts.where((post) {
      return post.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          post.body.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  List<Object?> get props =>
      [posts, searchQuery, isDarkMode, userName, userEmail, userBio];
}

class PostError extends PostState {
  final String errorMessage;
  const PostError(this.errorMessage,
      {super.isDarkMode, super.userName, super.userEmail, super.userBio});

  @override
  List<Object?> get props =>
      [errorMessage, isDarkMode, userName, userEmail, userBio];
}
