import 'package:apt3065/src/screens/home_page.dart';
import 'package:apt3065/src/screens/landing_page.dart';
import 'package:apt3065/src/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:apt3065/src/utils/auth_controller.dart';

final _key = GlobalKey<NavigatorState>();

enum AppRoute { splash, login, home }

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    navigatorKey: _key,

    /// Forwards diagnostic messages to the dart:developer log() API.
    debugLogDiagnostics: true,

    /// Initial Routing Location
    initialLocation: '/',

    /// The listeners are typically used to notify clients that the object has been
    /// updated.
    refreshListenable: authState,

    routes: [
      GoRoute(
        path: '/${AppRoute.splash.name}',
        name: AppRoute.splash.name,
        builder: (context, state) {
          return LandingPage();
        },
      ),
      GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: '/${AppRoute.login.name}',
        name: AppRoute.login.name,
        builder: (context, state) {
          return LandingPage();
        },
      ),
    ],
    redirect: (context, state) {
      /**
      * Your Redirection Logic Code  Here..........
      */
      final isAuthenticated = authState.isLoggedIn;

      /// [state.fullPath] will give current  route Path

      if (state.fullPath == '/${AppRoute.login.name}') {
        return isAuthenticated ? null : '/${AppRoute.login.name}';
      }

      /// null redirects to Initial Location

      return isAuthenticated ? null : '/${AppRoute.splash.name}';
    },
  );
});
