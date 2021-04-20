import 'package:flutter/material.dart';

class MovieDetailScreen extends StatelessWidget {
  final Function() fetchPrerequisitesCallback;
  final Map<String, dynamic> movie;

  MovieDetailScreen({
    @required this.fetchPrerequisitesCallback,
    @required this.movie,
  }) : assert(movie != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            movie['imdbID'],
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
