import 'dart:async';
import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../models/movie.dart';
import 'featured_movie_hero.dart';

class FeaturedCarousel extends StatefulWidget {
  const FeaturedCarousel({
    this.movies = mockMovies,
    super.key,
  });

  final List<Movie> movies;

  @override
  State<FeaturedCarousel> createState() => _FeaturedCarouselState();
}

class _FeaturedCarouselState extends State<FeaturedCarousel> {
  late final PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  int get _itemCount => widget.movies.length < 3 ? widget.movies.length : 3;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.92, initialPage: 0);
    _startTimer();
  }

  @override
  void didUpdateWidget(covariant FeaturedCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.movies == widget.movies) return;

    _currentPage = 0;
    if (_pageController.hasClients) {
      _pageController.jumpToPage(0);
    }
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    if (_itemCount < 2) return;
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.hasClients) {
        int next = (_currentPage + 1) % _itemCount;
        _pageController.animateToPage(
          next,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _currentPage = index);
  }

  void _navPage(int delta) {
    if (_itemCount < 2) return;
    _startTimer();
    int next = (_currentPage + delta) % _itemCount;
    if (next < 0) next = _itemCount - 1;
    _pageController.animateToPage(
      next,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_itemCount == 0) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        SizedBox(
          height: 220,
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: _itemCount,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: FeaturedMovieHero(movie: widget.movies[index]),
                  );
                },
              ),
              // Navigation Arrows
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _ArrowButton(
                        icon: Icons.arrow_back_ios_new_rounded,
                        onPressed: () => _navPage(-1),
                      ),
                      _ArrowButton(
                        icon: Icons.arrow_forward_ios_rounded,
                        onPressed: () => _navPage(1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_itemCount, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white.withValues(alpha: 0.2),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _ArrowButton extends StatelessWidget {
  const _ArrowButton({required this.icon, required this.onPressed});
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: Icon(icon, color: Colors.white.withValues(alpha: 0.9), size: 18),
        ),
      ),
    );
  }
}
