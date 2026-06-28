import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'coming_soon_screen.dart';
import 'released_screen.dart';
import 'search_screen.dart';
import 'watchlist_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;
  late final PageController _pageController;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
    _screens = const [
      HomeScreen(),
      ComingSoonScreen(),
      ReleasedScreen(),
      SearchScreen(),
      WatchlistScreen(),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onDestinationSelected(int index) {
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
          ),
        ),
        child: NavigationBar(
          height: 65,
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onDestinationSelected,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded, color: Theme.of(context).colorScheme.primary),
              label: 'Home',
            ),
            NavigationDestination(
              icon: const Icon(Icons.explore_outlined),
              selectedIcon:
                  Icon(Icons.explore_rounded, color: Theme.of(context).colorScheme.primary),
              label: 'Explore',
            ),
            NavigationDestination(
              icon: const Icon(Icons.local_fire_department_outlined),
              selectedIcon: Icon(Icons.local_fire_department_rounded,
                  color: Theme.of(context).colorScheme.primary),
              label: 'Hot',
            ),
            const NavigationDestination(
              icon: Icon(Icons.search_rounded),
              label: 'Search',
            ),
            NavigationDestination(
              icon: const Icon(Icons.bookmark_outline_rounded),
              selectedIcon:
                  Icon(Icons.bookmark_rounded, color: Theme.of(context).colorScheme.primary),
              label: 'Library',
            ),
          ],
        ),
      ),
    );
  }
}
