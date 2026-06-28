import 'package:flutter/material.dart';
import '../widgets/movie_search_bar.dart';
import '../widgets/modern_movie_card.dart';
import '../core/constants.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Search',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 24),
                    const MovieSearchBar(),
                    const SizedBox(height: 32),
                    const Text(
                      'Popular Genres',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 2.5,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _GenreCard(
                    label: ['Action', 'Comedy', 'Drama', 'Sci-Fi', 'Horror', 'Romance'][index],
                    color: [Colors.red, Colors.orange, Colors.blue, Colors.purple, Colors.green, Colors.pink][index],
                  ),
                  childCount: 6,
                ),
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 16),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Recent Searches',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.history_rounded, color: Colors.white24),
                    title: Text(
                      ['Dune: Part Two', 'Spider-Man', 'Oppenheimer'][index],
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: const Icon(Icons.close_rounded, size: 18, color: Colors.white24),
                  ),
                  childCount: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GenreCard extends StatelessWidget {
  final String label;
  final Color color;
  const _GenreCard({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.8), color.withValues(alpha: 0.4)],
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
        ),
      ),
    );
  }
}
