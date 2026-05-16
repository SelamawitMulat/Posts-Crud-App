// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/post.dart';
import '../bloc/post_bloc.dart';
import '../bloc/post_event.dart';
import '../bloc/post_state.dart';
import '../widgets/post_card.dart';
import '../widgets/loading_widget.dart';
import 'package:posts_crud_app/features/posts/presentation/widgets/error_widget.dart';
import 'add_edit_post_page.dart';
import 'profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showDeleteDialog(BuildContext context, int postId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Center(
          child: Text(
            'Delete Post',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFF1B254B)),
          ),
        ),
        content: const Text(
          'Are you sure you want to delete this post?\nThis action cannot be undone.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF4F5F7),
              elevation: 0,
              foregroundColor: Colors.black87,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Posts', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: false,
        actions: [
          IconButton(icon: const AppActionIcon(Icons.search), onPressed: () {}),
          GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const ProfilePage())),
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
      drawer: const NavigationDrawerWidget(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2F80ED),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddEditPostPage()),
          );
        },
        child: const Icon(Icons.add, size: 28),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const LoadingWidget();
          } else if (state is PostLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              padding: const EdgeInsets.only(bottom: 80, top: 8),
              itemBuilder: (context, index) {
                final item = state.posts[index];
                return PostCard(
                  post: item,
                  onEdit: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => AddEditPostPage(post: item)),
                    );
                  },
                  onDelete: () => _showDeleteDialog(context, item.id ?? 0),
                );
              },
            );
          } else if (state is PostEmpty) {
            return const Center(
                child: Text('No posts available. Add one now!'));
          } else if (state is PostError) {
            return MyErrorWidget(
              errorMessage: state.errorMessage,
              onPressed: () {
                context.read<PostBloc>().add(LoadPosts());
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class AppActionIcon extends StatelessWidget {
  final IconData icon;
  const AppActionIcon(this.icon, {super.key});
  @override
  Widget build(BuildContext context) =>
      Icon(icon, color: const Color(0xFF1B254B));
}

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 24),
            decoration: const BoxDecoration(
              color: Color(0xFF2F80ED),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 36,
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=150&q=80'),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Alex Johnson',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'alex@postsmanager.pro',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.85), fontSize: 13),
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.home_outlined, color: Color(0xFF2F80ED)),
            title: const Text(
              'Home',
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: Color(0xFF2F80ED)),
            ),
            selected: true,
            selectedTileColor: Color(0xFF2F80ED)
                .withOpacity(0.06), // Removed invalid runtime const prefix
            onTap: () =>
                Navigator.of(context).pop(), // Changed from onPressed to onTap
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Profile'),
            onTap: () {
              // Changed from onPressed to onTap
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ProfilePage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.dark_mode_outlined),
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: false,
              activeColor: const Color(0xFF2F80ED), // Clean constant handling
              onChanged: (bool value) {},
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About App'),
            onTap: () {}, // Changed from onPressed to onTap
          ),
        ],
      ),
    );
  }
}
