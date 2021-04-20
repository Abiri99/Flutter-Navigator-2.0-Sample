import 'package:flutter/material.dart';
import 'package:flutter_navigator2_sample/navigation/custom_route_configuration.dart';

class CustomRouteInformationParser extends RouteInformationParser<CustomRouteConfiguration> {
  
  @override
  Future<CustomRouteConfiguration> parseRouteInformation(RouteInformation routeInformation) {
    final uri = Uri.parse(routeInformation.location);
    return Future.value(CustomRouteConfiguration(
      imdbId: uri.queryParameters['imdbId'],
    ));
  }

  @override
  RouteInformation restoreRouteInformation(CustomRouteConfiguration configuration) {
    if (configuration.imdbId != null) {
      return RouteInformation(location: '/?imdbId=${configuration.imdbId}');
    } else {
      return RouteInformation(location: '/');
    }
  }
}