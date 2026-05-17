import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/post_bloc.dart';
import '../bloc/post_state.dart';
import '../bloc/post_event.dart';
import '../pages/home_page.dart';
import '../pages/profile_page.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final String activeRoute;

  const NavigationDrawerWidget({super.key, required this.activeRoute});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        return Drawer(
          backgroundColor:
              state.isDarkMode ? const Color(0xFF131A32) : Colors.white,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                    top: 60, left: 20, right: 20, bottom: 24),
                decoration: const BoxDecoration(color: Color(0xFF2F80ED)),
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
                        // FIXED: Dynamically pulls profile updates instantly across both pages
                        Text(
                          state.userName,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          state.userEmail,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 13),
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

              // 1. HOME NAVIGATION ROUTE
              ListTile(
                leading: Icon(Icons.home_outlined,
                    color: activeRoute == 'home'
                        ? const Color(0xFF2F80ED)
                        : Colors.grey),
                title: Text('Home',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: activeRoute == 'home'
                            ? const Color(0xFF2F80ED)
                            : (state.isDarkMode
                                ? Colors.white
                                : Colors.black87))),
                selected: activeRoute == 'home',
                selectedTileColor: const Color(0xFF2F80ED).withOpacity(0.06),
                onTap: () {
                  Navigator.of(context).pop();
                  if (activeRoute != 'home') {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const HomePage()),
                      (route) => false,
                    );
                  }
                },
              ),

              // 2. PROFILE NAVIGATION ROUTE
              ListTile(
                leading: Icon(Icons.person_outline,
                    color: activeRoute == 'profile'
                        ? const Color(0xFF2F80ED)
                        : Colors.grey),
                title: Text('Profile',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: activeRoute == 'profile'
                            ? const Color(0xFF2F80ED)
                            : (state.isDarkMode
                                ? Colors.white
                                : Colors.black87))),
                selected: activeRoute == 'profile',
                selectedTileColor: const Color(0xFF2F80ED).withOpacity(0.06),
                onTap: () {
                  Navigator.of(context).pop();
                  if (activeRoute != 'profile') {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ProfilePage()));
                  }
                },
              ),
              const Divider(color: Colors.grey),

              // 3. DARK MODE SYSTEM INTERACTIVE SWITCH
              ListTile(
                leading: Icon(Icons.dark_mode_outlined,
                    color: state.isDarkMode
                        ? const Color(0xFF2F80ED)
                        : Colors.grey),
                title: Text('Dark Mode',
                    style: TextStyle(
                        color:
                            state.isDarkMode ? Colors.white : Colors.black87)),
                trailing: Switch(
                  value: state.isDarkMode,
                  activeColor: const Color(0xFF2F80ED),
                  onChanged: (bool value) {
                    context.read<PostBloc>().add(ToggleTheme());
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
