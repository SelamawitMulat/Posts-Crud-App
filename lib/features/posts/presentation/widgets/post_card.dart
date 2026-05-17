import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/post.dart';
import '../bloc/post_bloc.dart';
import '../bloc/post_state.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const PostCard({
    super.key,
    required this.post,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          // FIX: Changed 'backgroundColor' to 'color' which is the proper property name for a Card widget
          color: state.isDarkMode ? const Color(0xFF131A32) : Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        post.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: state.isDarkMode
                              ? Colors.white
                              : const Color(0xFF1B254B),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined,
                              color: Colors.blue),
                          onPressed: onEdit,
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline,
                              color: Colors.red),
                          onPressed: onDelete,
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  post.body,
                  style: TextStyle(
                    fontSize: 14,
                    color: state.isDarkMode ? Colors.white70 : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
