library route_pages;

import 'package:celebrare/src/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import '/src/core/error/error.dart';
import 'routes.dart';

class AppRoute {
  static const initial = RoutesName.initial;
  static Route<dynamic> generate(RouteSettings? settings) {
    switch (settings?.name) {
      case RoutesName.initial:
        return MaterialPageRoute(builder: (_) => HomePage());

      default:
        // If there is no such named route in the switch statement
        throw const RouteException('Route not found!');
    }
  }
}
