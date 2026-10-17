import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../screens/auth/sign_in_screen.dart';
import '../../screens/auth/sign_up_screen.dart';
import '../../widgets/bottom_navigation_shell.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/quiz/quiz_screen.dart';

class AppRoutes {
  static const String signIn = '/';
  static const String signUp = '/sign-up';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String quiz = '/quiz';
  static const String result = '/result';
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.signIn,
    routes: [
      GoRoute(
        path: AppRoutes.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        builder: (context, state) => const SignUpScreen(),
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return BottomNavigationShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.quiz,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final category = state.extra as String? ?? 'Pengetahuan Umum';
          return QuizScreen(category: category);
        },
      ),
      GoRoute(
        path: AppRoutes.result,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Halaman Hasil'))),
      ),
    ],
  );
}
