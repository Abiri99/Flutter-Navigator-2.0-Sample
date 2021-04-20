import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_navigator2_sample/core/state_holder.dart';
import 'package:flutter_navigator2_sample/repository/movie_repository.dart';
import 'package:flutter_navigator2_sample/screen/home_screen.dart';
import 'package:flutter_navigator2_sample/viewmodel/home/home_bloc.dart';
import 'package:flutter_navigator2_sample/viewmodel/home/home_state.dart';

class HomePage extends Page {
  final List<Map<String, dynamic>> movies;
  final Function(String imdbID) onMovieItemTap;

  HomePage({
    @required this.movies,
    @required this.onMovieItemTap,
  }) : super(key: ValueKey('HomePage'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => BlocProvider<HomeBloc>(
        create: (_) => HomeBloc(
          movieRepository: MovieRepository(),
          initialState: HomeState(
            movies: StateHolder.empty(),
          ),
        ),
        child: HomeScreen(
          movies: movies,
          onMovieItemTap: onMovieItemTap,
        ),
      ),
    );
  }
}