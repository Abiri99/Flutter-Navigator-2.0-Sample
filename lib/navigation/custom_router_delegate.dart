import 'package:flutter/material.dart';
import 'package:flutter_navigator2_sample/navigation/custom_route_configuration.dart';
import 'package:flutter_navigator2_sample/page/home_page.dart';
import 'package:flutter_navigator2_sample/page/movie_detail_page.dart';
import 'package:flutter_navigator2_sample/repository/movie_repository.dart';

class CustomRouterDelegate extends RouterDelegate<CustomRouteConfiguration>
    with
        ChangeNotifier,
        PopNavigatorRouterDelegateMixin<CustomRouteConfiguration> {
  final MovieRepository movieRepository;

  final GlobalKey<NavigatorState> _navigatorKey;

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  CustomRouterDelegate({@required this.movieRepository})
      : assert(movieRepository != null),
        _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }

  Future<void> _init() async {
    movies = await movieRepository.fetchMovies();
  }

  List<Map<String, dynamic>> _movies;
  List<Map<String, dynamic>> get movies => _movies;
  set movies(List<Map<String, dynamic>> value) {
    _movies = value;
    notifyListeners();
  }

  String _imdbId;
  String get imdbId => _imdbId;
  set imdbId(String value) {
    _imdbId = value;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      pages: [
        HomePage(
          movies: _movies,
          onMovieItemTap: (String imdbID) {
            imdbId = imdbID;
          },
        ),
        if (imdbId != null)
          MovieDetailPage(
            movie: movies.firstWhere((movie) {
              if (movie['imdbID'] == imdbId) {
                return true;
              }
              return false;
            }),
            fetchPrerequisitesCallback: () async {
              if (movies == null) {
                movies = await movieRepository.fetchMovies();
              }
            },
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        if (imdbId != null) imdbId = null;
        return true;
      },
    );
  }

  @override
  CustomRouteConfiguration get currentConfiguration {
    return CustomRouteConfiguration(imdbId: imdbId);
  }

  @override
  Future<void> setNewRoutePath(CustomRouteConfiguration configuration) async {
    movies = await movieRepository.fetchMovies();
    Future.delayed(Duration(milliseconds: 100), () {
      imdbId = configuration.imdbId;
    },);
    return null;
  }
}