import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../models/movie.dart';
import '../widgets/movie_search_bar.dart';
import '../widgets/movie_filter_row.dart';
import '../widgets/featured_carousel.dart';
import '../widgets/modern_movie_card.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  String _selectedGenre = 'All';
  _MovieFilters _filters = const _MovieFilters();

  List<Movie> get _filteredMovies {
    final query = _searchController.text.trim().toLowerCase();
    final movies = mockMovies.where((movie) {
      final matchesGenre = _selectedGenre == 'All' ||
          movie.genre.toLowerCase().contains(_selectedGenre.toLowerCase());
      final matchesSearch = query.isEmpty ||
          movie.title.toLowerCase().contains(query) ||
          movie.genre.toLowerCase().contains(query) ||
          movie.releaseInfo.toLowerCase().contains(query);
      final matchesRelease = _filters.releaseStatus == 'Any' ||
          (_filters.releaseStatus == 'Coming Soon' &&
              movie.releaseInfo.toLowerCase().contains('coming')) ||
          movie.releaseInfo == _filters.releaseStatus;
      final rating = double.tryParse(movie.rating) ?? 0;
      final matchesRating = rating >= _filters.minRating;

      return matchesGenre && matchesSearch && matchesRelease && matchesRating;
    }).toList();

    switch (_filters.sortBy) {
      case 'Top Rated':
        movies.sort((a, b) {
          final aRating = double.tryParse(a.rating) ?? 0;
          final bRating = double.tryParse(b.rating) ?? 0;
          return bRating.compareTo(aRating);
        });
        break;
      case 'Newest':
        movies.sort((a, b) => b.year.compareTo(a.year));
        break;
    }

    return movies;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _showFilters() async {
    final filters = await showModalBottomSheet<_MovieFilters>(
      context: context,
      backgroundColor: const Color(0xFF121722),
      barrierColor: Colors.black.withValues(alpha: 0.65),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => _MovieFilterSheet(initialFilters: _filters),
    );

    if (filters == null) return;
    setState(() => _filters = filters);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final filteredMovies = _filteredMovies;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _HomeHeader(textTheme: textTheme)),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: MovieFilterRow(
                  selectedGenre: _selectedGenre,
                  onGenreSelected: (genre) {
                    setState(() => _selectedGenre = genre);
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: MovieSearchBar(
                  controller: _searchController,
                  isFilterActive: _filters.isActive,
                  onChanged: (_) => setState(() {}),
                  onFilterTap: _showFilters,
                ),
              ),
              const SizedBox(height: 24),
              FeaturedCarousel(movies: filteredMovies),
              SizedBox(height: filteredMovies.isEmpty ? 20 : 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _SectionHeader(
                  title: _selectedGenre == 'All' ? 'Trending Now' : _selectedGenre,
                  count: filteredMovies.length,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        if (filteredMovies.isEmpty)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: _EmptyMovieState(),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ModernMovieCard(movie: filteredMovies[index]),
                childCount: filteredMovies.length,
              ),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 118,
                mainAxisSpacing: 16,
                crossAxisSpacing: 10,
                childAspectRatio: 0.82,
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

class _MovieFilters {
  const _MovieFilters({
    this.releaseStatus = 'Any',
    this.minRating = 0,
    this.sortBy = 'Featured',
  });

  final String releaseStatus;
  final double minRating;
  final String sortBy;

  bool get isActive =>
      releaseStatus != 'Any' || minRating > 0 || sortBy != 'Featured';

  _MovieFilters copyWith({
    String? releaseStatus,
    double? minRating,
    String? sortBy,
  }) {
    return _MovieFilters(
      releaseStatus: releaseStatus ?? this.releaseStatus,
      minRating: minRating ?? this.minRating,
      sortBy: sortBy ?? this.sortBy,
    );
  }
}

class _MovieFilterSheet extends StatefulWidget {
  const _MovieFilterSheet({required this.initialFilters});

  final _MovieFilters initialFilters;

  @override
  State<_MovieFilterSheet> createState() => _MovieFilterSheetState();
}

class _MovieFilterSheetState extends State<_MovieFilterSheet> {
  late _MovieFilters _filters;

  @override
  void initState() {
    super.initState();
    _filters = widget.initialFilters;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          12,
          20,
          MediaQuery.viewInsetsOf(context).bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Text(
                  'Filters',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() => _filters = const _MovieFilters());
                  },
                  child: Text(
                    'Reset',
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _FilterChoiceRow(
              title: 'Release',
              options: const ['Any', 'Coming Soon', 'In Theaters', 'Released'],
              selected: _filters.releaseStatus,
              onSelected: (value) {
                setState(() {
                  _filters = _filters.copyWith(releaseStatus: value);
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              _filters.minRating == 0
                  ? 'Minimum rating: Any'
                  : 'Minimum rating: ${_filters.minRating.toStringAsFixed(1)}+',
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
            Slider(
              value: _filters.minRating,
              min: 0,
              max: 9,
              divisions: 9,
              label: _filters.minRating == 0
                  ? 'Any'
                  : '${_filters.minRating.toStringAsFixed(1)}+',
              onChanged: (value) {
                setState(() {
                  _filters = _filters.copyWith(minRating: value);
                });
              },
            ),
            const SizedBox(height: 8),
            _FilterChoiceRow(
              title: 'Sort by',
              options: const ['Featured', 'Top Rated', 'Newest'],
              selected: _filters.sortBy,
              onSelected: (value) {
                setState(() {
                  _filters = _filters.copyWith(sortBy: value);
                });
              },
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, _filters),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Apply Filters',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChoiceRow extends StatelessWidget {
  const _FilterChoiceRow({
    required this.title,
    required this.options,
    required this.selected,
    required this.onSelected,
  });

  final String title;
  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final option in options)
              ChoiceChip(
                label: Text(option),
                selected: option == selected,
                onSelected: (_) => onSelected(option),
                selectedColor: Theme.of(context).colorScheme.primary,
                backgroundColor: const Color(0xFF1A1B22),
                labelStyle: TextStyle(
                  color: option == selected
                      ? Colors.black
                      : Colors.white.withValues(alpha: 0.72),
                  fontWeight: FontWeight.w800,
                ),
                side: BorderSide(
                  color: option == selected
                      ? Colors.transparent
                      : Colors.white.withValues(alpha: 0.08),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _EmptyMovieState extends StatelessWidget {
  const _EmptyMovieState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.filter_alt_off_rounded,
              size: 56,
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.65),
            ),
            const SizedBox(height: 16),
            const Text(
              'No movies found',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 8),
            Text(
              'Try another genre or loosen the filters.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
            ),
          ],
        ),
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
