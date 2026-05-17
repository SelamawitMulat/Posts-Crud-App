import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/post.dart';
import '../bloc/post_bloc.dart';
import '../bloc/post_event.dart';

class AddEditPostPage extends StatefulWidget {
  final Post? post;

  const AddEditPostPage({super.key, this.post});

  @override
  State<AddEditPostPage> createState() => _AddEditPostPageState();
}

class _AddEditPostPageState extends State<AddEditPostPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _bodyController;

  bool get isEditMode => widget.post != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.post?.title ?? '');
    _bodyController = TextEditingController(text: widget.post?.body ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _savePost() {
    if (!_formKey.currentState!.validate()) return;

    final title = _titleController.text.trim();
    final body = _bodyController.text.trim();

    if (isEditMode) {
      // Update existing post
      final updatedPost = widget.post!.copyWith(title: title, body: body);
      context.read<PostBloc>().add(UpdatePost(updatedPost));
    } else {
      // Create new post (MockAPI auto-generates ID string on server, so we send empty string)
      final newPost = Post(id: '', title: title, body: body);
      context.read<PostBloc>().add(AddPost(newPost));
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? 'Edit Post' : 'Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Title cannot be empty'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bodyController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Body Content',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Body cannot be empty'
                    : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F80ED),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _savePost,
                  child: Text(
                    isEditMode ? 'Save Changes' : 'Publish Post',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
