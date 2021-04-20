import 'package:equatable/equatable.dart';
import 'package:flutter_navigator2_sample/core/state_holder.dart';

class HomeState extends Equatable {

  final StateHolder<List<Map<String, dynamic>>> movies;

  HomeState({this.movies});

  HomeState copyWith({StateHolder<List<Map<String, dynamic>>> movies}) {
    return HomeState(
      movies: movies ?? this.movies,
    );
  }

  @override
  List<Object> get props => [movies];
}