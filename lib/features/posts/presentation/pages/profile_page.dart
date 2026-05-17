import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/post_bloc.dart';
import '../bloc/post_state.dart';
import '../bloc/post_event.dart';
import '../widgets/navigation_drawer_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isEditing = false;

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;

  final String _profileImageUrl =
      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80';

  @override
  void initState() {
    super.initState();
    final blocState = context.read<PostBloc>().state;
    _nameController = TextEditingController(text: blocState.userName);
    _emailController = TextEditingController(text: blocState.userEmail);
    _bioController = TextEditingController(text: blocState.userBio);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        final cardBgColor =
            state.isDarkMode ? const Color(0xFF131A32) : Colors.white;
        final textMainColor =
            state.isDarkMode ? Colors.white : const Color(0xFF1B254B);

        return Scaffold(
          key: _scaffoldKey,
          drawer: const NavigationDrawerWidget(activeRoute: 'profile'),
          backgroundColor: state.isDarkMode
              ? const Color(0xFF0F1424)
              : const Color(0xFFF8F9FA),
          appBar: AppBar(
            backgroundColor:
                state.isDarkMode ? const Color(0xFF131A32) : Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.menu, color: textMainColor),
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
            title: Text('Profile',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: textMainColor)),
            actions: [
              if (!_isEditing)
                IconButton(
                  icon:
                      const Icon(Icons.edit_outlined, color: Color(0xFF2F80ED)),
                  onPressed: () => setState(() => _isEditing = true),
                )
              else ...[
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () {
                    setState(() {
                      _isEditing = false;
                      _nameController.text = state.userName;
                      _emailController.text = state.userEmail;
                      _bioController.text = state.userBio;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.check, color: Color(0xFF2F80ED)),
                  onPressed: () {
                    // Email validation logic checking for "@" syntax rules
                    final emailText = _emailController.text.trim();
                    if (!emailText.contains('@')) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: Text(
                              'Please enter a valid email address containing "@"'),
                        ),
                      );
                      return;
                    }

                    context.read<PostBloc>().add(UpdateUserProfile(
                          name: _nameController.text.trim(),
                          email: emailText,
                          bio: _bioController.text.trim(),
                        ));
                    setState(() => _isEditing = false);
                  },
                ),
              ]
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Center(
                  // FIXED: Simplified down to a clean, non-interactive avatar image shell
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: cardBgColor, width: 4),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 12,
                            offset: const Offset(0, 4))
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(_profileImageUrl),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: cardBgColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 16,
                          offset: const Offset(0, 4))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProfileField(
                          label: 'NAME',
                          controller: _nameController,
                          isEditable: _isEditing,
                          textDarkMode: state.isDarkMode),
                      const SizedBox(height: 20),
                      _buildProfileField(
                          label: 'EMAIL',
                          controller: _emailController,
                          isEditable: _isEditing,
                          textDarkMode: state.isDarkMode),
                      const SizedBox(height: 20),
                      _buildProfileField(
                          label: 'BIO',
                          controller: _bioController,
                          isEditable: _isEditing,
                          maxLines: 3,
                          textDarkMode: state.isDarkMode),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                if (!_isEditing)
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF2F80ED).withOpacity(0.08),
                        foregroundColor: const Color(0xFF2F80ED),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      onPressed: () => setState(() => _isEditing = true),
                      child: const Text('Edit Profile',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileField({
    required String label,
    required TextEditingController controller,
    required bool isEditable,
    required bool textDarkMode,
    int maxLines = 1,
  }) {
    final textMainColor = textDarkMode ? Colors.white : const Color(0xFF1B254B);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: textDarkMode ? Colors.white60 : const Color(0xFF8A94A6),
                letterSpacing: 1.1)),
        const SizedBox(height: 8),
        if (isEditable)
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            style: TextStyle(
                fontSize: 15,
                color: textMainColor,
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              filled: true,
              fillColor: textDarkMode
                  ? const Color(0xFF1C2442)
                  : const Color(0xFFF4F5F7),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(controller.text,
                style: TextStyle(
                    fontSize: 16,
                    color: textMainColor,
                    fontWeight: FontWeight.w500)),
          ),
        if (!isEditable) ...[
          const SizedBox(height: 8),
          Divider(
              color: textDarkMode ? Colors.white10 : const Color(0xFFEDF2F7),
              height: 1),
        ]
      ],
    );
  }
}
