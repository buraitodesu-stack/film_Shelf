import 'package:flutter/material.dart';

class Movie {
  const Movie({
    required this.title,
    required this.genre,
    required this.releaseInfo,
    required this.year,
    required this.duration,
    required this.rating,
    required this.posterColor,
  });

  final String title;
  final String genre;
  final String releaseInfo;
  final String year;
  final String duration;
  final String rating;
  final Color posterColor;
}
