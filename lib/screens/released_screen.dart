import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../widgets/modern_movie_card.dart';

class ReleasedScreen extends StatelessWidget {
  const ReleasedScreen({super.key});

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
                    Row(
                      children: [
                        const Text(
                          'Hot',
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.local_fire_department_rounded, color: Theme.of(context).colorScheme.primary, size: 32),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Trending in theaters and streaming',
                      style: TextStyle(color: Colors.white54, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => ModernMovieCard(movie: mockMovies[index % mockMovies.length]),
                  childCount: mockMovies.length * 2,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
