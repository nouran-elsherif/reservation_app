// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class Routes {
  final GlobalKey<NavigatorState>? navigatorKey;

  Routes({required this.navigatorKey});
// routes names
//   static const MOVIE_DETAILS_SCREEN = '/movieDetailsScreen';

  MaterialPageRoute? onGenerateRoute(RouteSettings settings) {
    var routes = <String, WidgetBuilder>{};

    WidgetBuilder? builder = routes[settings.name!];
    if (builder == null) {
      return null;
    }
    return MaterialPageRoute(builder: (context) => builder(context), settings: settings);
  }
}
