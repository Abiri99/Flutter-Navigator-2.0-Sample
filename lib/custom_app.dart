import 'package:flutter/material.dart';
import 'package:flutter_navigator2_sample/navigation/custom_router_delegate.dart';
import 'package:flutter_navigator2_sample/navigation/route_information_parser.dart';
import 'package:flutter_navigator2_sample/repository/movie_repository.dart';

class CustomApp extends StatefulWidget {
  const CustomApp({Key key}) : super(key: key);

  @override
  _CustomAppState createState() => _CustomAppState();
}

class _CustomAppState extends State<CustomApp> {

  var _routerDelegate;

  @override
  void initState() {
    _routerDelegate = CustomRouterDelegate(movieRepository: MovieRepository());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _routerDelegate,
      backButtonDispatcher: RootBackButtonDispatcher(),
      routeInformationParser: CustomRouteInformationParser(),
      // routeInformationProvider: ,
    );
  }
}