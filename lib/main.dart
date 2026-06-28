import 'package:flutter/material.dart';
import 'core/app_colors.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const FilmShelfApp());
}

class FilmShelfApp extends StatelessWidget {
  const FilmShelfApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FilmShelf',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.logoGold,
          brightness: Brightness.dark,
          primary: AppColors.logoGold,
          onPrimary: Colors.black,
          surface: AppColors.surface,
        ),
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
        fontFamily: 'Inter',
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.surface,
          indicatorColor: AppColors.logoGold.withValues(alpha: 0.14),
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
