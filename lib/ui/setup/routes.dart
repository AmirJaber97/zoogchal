import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zoog/app/logger.dart';
import 'package:zoog/constants/app_routes.dart';
import 'package:zoog/ui/home/home.dart';

class Routes {
  static final logger = getLogger('Router');

  static Route<dynamic> generateRoute(RouteSettings settings) {
    logger.i(
        'generateRoute | name: ${settings.name} arguments: ${settings.arguments}');

    switch (settings.name) {
      case RoutePaths.Home:
        return CupertinoPageRoute(builder: (_) => HomeView());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
