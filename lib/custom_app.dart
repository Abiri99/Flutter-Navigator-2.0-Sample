import 'package:flutter/material.dart';
import 'package:flutter_navigator2_sample/core/helper/todo_database_helper.dart';
import 'package:flutter_navigator2_sample/di/service_locator.dart';
import 'package:flutter_navigator2_sample/navigation/custom_router_delegate.dart';
import 'package:flutter_navigator2_sample/navigation/route_information_parser.dart';

class CustomApp extends StatefulWidget {
  const CustomApp({Key key}) : super(key: key);

  @override
  _CustomAppState createState() => _CustomAppState();
}

class _CustomAppState extends State<CustomApp> {

  var _routerDelegate;

  @override
  void initState() {
    _routerDelegate = sl<CustomRouterDelegate>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _routerDelegate,
      // backButtonDispatcher: RootBackButtonDispatcher(),
      routeInformationParser: CustomRouteInformationParser(),
      theme: ThemeData(
        brightness: Brightness.light
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}