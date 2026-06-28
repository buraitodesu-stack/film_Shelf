import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'edit_profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: -0.5),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          // 1. Profile Section
          const _ProfileHeader(),
          const SizedBox(height: 32),

          // 2. Preferences
          const _SettingsSectionHeader(title: 'Preferences'),
          _SettingsTile(
            icon: Icons.public_rounded,
            title: 'Region/Country',
            subtitle: 'United States',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.language_rounded,
            title: 'Language',
            subtitle: 'English (US)',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.tv_rounded,
            title: 'Streaming Services',
            subtitle: 'Netflix, Disney+, Prime',
            onTap: () {},
          ),

          const SizedBox(height: 24),
          // 3. App Settings
          const _SettingsSectionHeader(title: 'App Settings'),
          _SettingsTile(
            icon: Icons.notifications_none_rounded,
            title: 'Notifications',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.dark_mode_outlined,
            title: 'Appearance',
            subtitle: 'Dark Mode',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.storage_rounded,
            title: 'Storage',
            subtitle: 'Clear Cache (42 MB)',
            onTap: () {},
          ),

          const SizedBox(height: 24),
          // 4. Support & About
          const _SettingsSectionHeader(title: 'Support'),
          _SettingsTile(
            icon: Icons.help_outline_rounded,
            title: 'Help & Feedback',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.info_outline_rounded,
            title: 'About FilmShelf',
            onTap: () {},
          ),

          const SizedBox(height: 40),
          // 5. Sign Out
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: Text(
                'Sign Out',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 8, bottom: 40),
              child: Text(
                'Version 1.0.0',
                style: TextStyle(color: Colors.white24, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Color(0xFF2A2B32),
            child: Icon(Icons.person_outline, size: 50, color: Colors.white38),
          ),
          const SizedBox(height: 16),
          const Text(
            'John Doe',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 4),
          Text(
            'johndoe@example.com',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfileScreen()),
              );
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
            ),
            child: const Text('Edit Profile',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

class _SettingsSectionHeader extends StatelessWidget {
  final String title;
  const _SettingsSectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.2,
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white70, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: TextStyle(color: Colors.white38, fontSize: 13),
              )
            : null,
        trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white24, size: 14),
        onTap: onTap,
      ),
    );
  }
}
