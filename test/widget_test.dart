import 'package:film_shelf/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _finishSplash(WidgetTester tester) async {
  await tester.pump(const Duration(seconds: 10));
  await tester.pumpAndSettle();
}

Future<void> _signIn(WidgetTester tester) async {
  await _finishSplash(tester);
  await tester.tap(find.text('Sign In'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('shows the splash screen before login', (WidgetTester tester) async {
    await tester.pumpWidget(const FilmShelfApp());

    expect(find.byType(Image), findsOneWidget);
    expect(find.text('Welcome Back'), findsNothing);

    await tester.pump(const Duration(seconds: 9));

    expect(find.text('Welcome Back'), findsNothing);

    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.text('Welcome Back'), findsOneWidget);
  });

  testWidgets('shows the FilmShelf app shell after sign in', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const FilmShelfApp());
    await _signIn(tester);

    expect(find.text('Search titles, actors...'), findsOneWidget);
    expect(find.text('Dune: Part Three'), findsOneWidget);
    expect(find.text('Spider-Verse: Beyond'), findsAtLeastNWidgets(1));
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Explore'), findsOneWidget);
    expect(find.text('Hot'), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Library'), findsOneWidget);
  });

  testWidgets('switches between bottom navigation tabs', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const FilmShelfApp());
    await _signIn(tester);

    await tester.tap(find.text('Search').last);
    await tester.pumpAndSettle();

    expect(find.text('Find your next favorite'), findsOneWidget);

    await tester.tap(find.text('Library'));
    await tester.pumpAndSettle();

    expect(find.text('Your collection'), findsOneWidget);
  });
}
