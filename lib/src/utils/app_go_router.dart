import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:meta_business/src/presentation/home/splash_screen.dart';

import 'app_get.dart';

GlobalKey<NavigatorState> get navigatorKey =>
    findInstance<GlobalKey<NavigatorState>>();

// GoRouter configuration
final goRouter = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: "/",
  routes: [
    GoRoute(
        name: 'home',
        path: '/',
        builder: (context, state) => const SplashScreen()),
  ],
);
