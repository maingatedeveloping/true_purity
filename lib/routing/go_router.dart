import 'package:go_router/go_router.dart';

import '../auth/auth_page.dart';
import '../pages/homepage.dart';

GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/sign_up',
      builder: (context, state) => AuthPage(
        isLogIn: false,
      ),
      routes: [],
    ),
    GoRoute(
      path: '/sign_in',
      builder: (context, state) => AuthPage(
        isLogIn: true,
      ),
      routes: [],
    ),
  ],
);

// final GoRouter router = GoRouter(
//   navigatorKey: _rootNavigatorKey,
//   // initialLocation: '/',
//   debugLogDiagnostics: true,
//   routes: [
//     // Main routes in app
//     GoRoute(
//       path: '/',
//       builder: (context, state) => const HomePage(),
//       routes: [ ])]);