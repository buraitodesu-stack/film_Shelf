import 'package:flutter/material.dart';

class MovieSearchBar extends StatelessWidget {
  const MovieSearchBar({
    this.onChanged,
    this.controller,
    this.onFilterTap,
    this.isFilterActive = false,
    super.key,
  });

  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final VoidCallback? onFilterTap;
  final bool isFilterActive;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1B22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: 'Search titles, actors...',
          hintStyle: TextStyle(
            color: Colors.white.withValues(alpha: 0.4),
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            size: 20,
            color: Colors.white.withValues(alpha: 0.4),
          ),
          suffixIcon: IconButton(
            tooltip: 'Filters',
            onPressed: onFilterTap,
            icon: Icon(
              Icons.tune_rounded,
              size: 20,
              color: isFilterActive ? Colors.black : colorScheme.primary,
            ),
            style: IconButton.styleFrom(
              backgroundColor:
                  isFilterActive ? colorScheme.primary : Colors.transparent,
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
