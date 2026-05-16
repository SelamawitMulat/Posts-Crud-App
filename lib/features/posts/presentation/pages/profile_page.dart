import 'package:flutter/material.dart';
import 'add_edit_post_page.dart'; // Reuses FieldLabel asset styles cleanly

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFF1B254B)),
          onPressed: () {},
        ),
        title: const Text('Profile',
            style: TextStyle(
                color: Color(0xFF1B254B), fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              icon: const Icon(Icons.close, color: Colors.grey),
              onPressed: () => Navigator.pop(context)),
          IconButton(
              icon: const Icon(Icons.check, color: Color(0xFF2F80ED)),
              onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      )
                    ]),
                    child: const CircleAvatar(
                      radius: 64,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80'),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2F80ED),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt,
                          color: Colors.white, size: 18),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFEFEFEF)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FieldLabel('Name'),
                  StaticProfileField(value: 'Alex Johnson'),
                  SizedBox(height: 20),
                  FieldLabel('Email'),
                  StaticProfileField(value: 'alex@postsmanager.pro'),
                  SizedBox(height: 20),
                  FieldLabel('Bio'),
                  StaticProfileField(
                      value: 'Productivity enthusiast and design lover.',
                      maxLines: 3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StaticProfileField extends StatelessWidget {
  final String value;
  final int maxLines;

  const StaticProfileField({super.key, required this.value, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FB),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFECECEC)),
      ),
      child: Text(
        value,
        maxLines: maxLines,
        style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF1B254B),
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
