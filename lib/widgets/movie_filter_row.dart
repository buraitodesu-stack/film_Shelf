import 'package:flutter/material.dart';

class MovieFilterRow extends StatelessWidget {
  const MovieFilterRow({
    required this.selectedGenre,
    required this.onGenreSelected,
    this.genres = const [
      'All',
      'Action',
      'Adventure',
      'Animation',
      'Comedy',
      'Crime',
      'Drama',
      'Mystery',
      'Sci-Fi',
      'Space',
      'Thriller',
    ],
    super.key,
  });

  final String selectedGenre;
  final ValueChanged<String> onGenreSelected;
  final List<String> genres;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final genre in genres) ...[
            _ModernFilterChip(
              label: genre,
              isSelected: genre == selectedGenre,
              onTap: () => onGenreSelected(genre),
            ),
            const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}

class _ModernFilterChip extends StatelessWidget {
  const _ModernFilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : const Color(0xFF1A1B22),
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ]
                : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              color:
                  isSelected ? Colors.white : Colors.white.withValues(alpha: 0.5),
            ),
          ),
        ),
      ),
    );
  }
}
