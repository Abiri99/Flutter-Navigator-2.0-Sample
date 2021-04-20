import 'package:flutter/material.dart';
import 'package:flutter_navigator2_sample/screen/movie_detail_screen.dart';

class MovieDetailPage extends Page {
  final Function() fetchPrerequisitesCallback;
  final Map<String, dynamic> movie;

  MovieDetailPage({
    @required this.fetchPrerequisitesCallback,
    @required this.movie,
  }) : super(key: ValueKey('MovieDetailPage'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => MovieDetailScreen(
        movie: movie,
        fetchPrerequisitesCallback: fetchPrerequisitesCallback,
      ),
    );
  }
}