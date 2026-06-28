import 'package:flutter/material.dart';

class ScreenPlaceholder extends StatelessWidget {
  const ScreenPlaceholder({
    required this.title,
    required this.subtitle,
    required this.icon,
    super.key,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
          ),
          Text(
            subtitle,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
          ),
        ],
      ),
    );
  }
}
