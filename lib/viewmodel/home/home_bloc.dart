import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_navigator2_sample/core/state_holder.dart';
import 'package:flutter_navigator2_sample/repository/movie_repository.dart';
import 'package:flutter_navigator2_sample/viewmodel/home/home_event.dart';
import 'package:flutter_navigator2_sample/viewmodel/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MovieRepository movieRepository;

  HomeBloc({@required this.movieRepository, HomeState initialState})
      : assert(movieRepository != null),
        super(initialState);

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeMoviesFetched) {
      yield* _mapMoviesFetchedToState();
    }
  }

  Stream<HomeState> _mapMoviesFetchedToState() async* {
    yield state.copyWith(
      movies: StateHolder.loading(),
    );
    var response = await movieRepository.fetchMovies();
    yield state.copyWith(
      movies: StateHolder.completed(response),
    );
  }
}
