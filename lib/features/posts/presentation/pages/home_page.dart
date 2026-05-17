// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/post.dart';
import '../bloc/post_bloc.dart';
import '../bloc/post_event.dart';
import '../bloc/post_state.dart';
import '../widgets/post_card.dart';
import '../widgets/loading_widget.dart';
import '../widgets/navigation_drawer_widget.dart';
import 'package:posts_crud_app/features/posts/presentation/widgets/error_widget.dart';
import 'add_edit_post_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  void _showDeleteDialog(BuildContext context, String postId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Center(
          child: Text('Delete Post',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFF1B254B))),
        ),
        content: const Text(
            'Are you sure you want to delete this post?\nThis action cannot be undone.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 14)),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF4F5F7),
              elevation: 0,
              foregroundColor: Colors.black87,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel',
                style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF3B30),
              elevation: 0,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              BlocProvider.of<PostBloc>(context).add(DeletePost(postId));
              Navigator.of(ctx).pop();
            },
            child: const Text('Delete',
                style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        final currentBgColor = state.isDarkMode
            ? const Color(0xFF0F1424)
            : const Color(0xFFF8F9FA);

        return Scaffold(
          backgroundColor: currentBgColor,
          appBar: AppBar(
            backgroundColor:
                state.isDarkMode ? const Color(0xFF131A32) : Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(
                color:
                    state.isDarkMode ? Colors.white : const Color(0xFF1B254B)),
            title: _isSearching
                ? TextField(
                    controller: _searchController,
                    autofocus: true,
                    style: TextStyle(
                        color:
                            state.isDarkMode ? Colors.white : Colors.black87),
                    decoration: const InputDecoration(
                      hintText: 'Search posts...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      context.read<PostBloc>().add(SearchPosts(value));
                    },
                  )
                : Text('Posts',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: state.isDarkMode
                            ? Colors.white
                            : const Color(0xFF1B254B))),
            actions: [
              IconButton(
                icon: Icon(_isSearching ? Icons.close : Icons.search,
                    color: state.isDarkMode
                        ? Colors.white
                        : const Color(0xFF1B254B)),
                onPressed: () {
                  setState(() {
                    if (_isSearching) {
                      _isSearching = false;
                      _searchController.clear();
                      context.read<PostBloc>().add(const SearchPosts(''));
                    } else {
                      _isSearching = true;
                    }
                  });
                },
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ProfilePage())),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.0),
                  child: CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=100&q=80'),
                  ),
                ),
              )
            ],
          ),
          drawer: const NavigationDrawerWidget(activeRoute: 'home'),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFF2F80ED),
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AddEditPostPage())),
            child: const Icon(Icons.add, size: 28),
          ),
          body: BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              if (state is PostLoading) {
                return const LoadingWidget();
              } else if (state is PostLoaded) {
                final visiblePosts = state.filteredPosts;
                if (visiblePosts.isEmpty) {
                  return Center(
                      child: Text('No matching posts found.',
                          style: TextStyle(
                              color: state.isDarkMode
                                  ? Colors.white60
                                  : Colors.black54)));
                }
                return ListView.builder(
                  itemCount: visiblePosts.length,
                  padding: const EdgeInsets.only(bottom: 80, top: 8),
                  itemBuilder: (context, index) {
                    final item = visiblePosts[index];
                    return PostCard(
                      post: item,
                      onEdit: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => AddEditPostPage(post: item))),
                      onDelete: () => _showDeleteDialog(context, item.id),
                    );
                  },
                );
              } else if (state is PostEmpty) {
                return Center(
                    child: Text('No posts available. Add one now!',
                        style: TextStyle(
                            color: state.isDarkMode
                                ? Colors.white60
                                : Colors.black54)));
              } else if (state is PostError) {
                return MyErrorWidget(
                    errorMessage: state.errorMessage,
                    onPressed: () => context.read<PostBloc>().add(LoadPosts()));
              }
              return const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}
