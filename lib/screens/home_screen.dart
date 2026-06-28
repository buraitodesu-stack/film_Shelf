import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../widgets/movie_search_bar.dart';
import '../widgets/movie_filter_row.dart';
import '../widgets/featured_carousel.dart';
import '../widgets/modern_movie_card.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _HomeHeader(textTheme: textTheme)),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: MovieFilterRow(),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: MovieSearchBar(),
              ),
              const SizedBox(height: 24),
              const FeaturedCarousel(),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _SectionHeader(title: 'Trending Now', count: mockMovies.length),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ModernMovieCard(movie: mockMovies[index]),
              childCount: mockMovies.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 10,
              childAspectRatio: 0.92,
            ),
          ),
        ),
      ],
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  'assets/images/filmshelf_logo.png',
                  width: 110,
                  height: 110,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              RichText(
                text: TextSpan(
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.8,
                    color: Colors.white,
                    fontFamily: 'Inter',
                  ),
                  children: [
                    const TextSpan(text: 'FILM'),
                    TextSpan(
                      text: 'SHELF',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
            icon: const CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFF2A2B32),
              child: Icon(
                Icons.person_outline,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.count});
  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
        ),
        const Spacer(),
        Text(
          '$count Items',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.4),
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
