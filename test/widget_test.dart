import 'package:film_shelf/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the FilmShelf app shell', (WidgetTester tester) async {
    await tester.pumpWidget(const FilmShelfApp());

    expect(find.text('FilmShelf'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
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

    await tester.tap(find.text('Search'));
    await tester.pumpAndSettle();

    expect(find.text('Find your next favorite'), findsOneWidget);

    await tester.tap(find.text('Library'));
    await tester.pumpAndSettle();

    expect(find.text('Your collection'), findsOneWidget);
  });
}
