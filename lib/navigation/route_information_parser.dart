import 'package:flutter/material.dart';
import 'package:flutter_navigator2_sample/navigation/custom_route_configuration.dart';

class CustomRouteInformationParser extends RouteInformationParser<CustomRouteConfiguration> {
  
  @override
  Future<CustomRouteConfiguration> parseRouteInformation(RouteInformation routeInformation) {
    final uri = Uri.parse(routeInformation.location);
    return Future.value(CustomRouteConfiguration(
      todoId: uri.queryParameters['todoId'] != null ? int.parse(uri.queryParameters['todoId']) : null,
    ));
  }

  @override
  RouteInformation restoreRouteInformation(CustomRouteConfiguration configuration) {
    if (configuration.todoId != null) {
      return RouteInformation(location: '/?imdbId=${configuration.todoId}');
    } else {
      return RouteInformation(location: '/');
    }
  }
}