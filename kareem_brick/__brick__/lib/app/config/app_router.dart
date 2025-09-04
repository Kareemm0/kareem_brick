import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final navigatorKey = GlobalKey<NavigatorState>();

abstract class Routes {
  static const loginRoute = "login";
}

final appRouter = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: navigatorKey,
  // initialLocation: ,
  routes: [],
);
