import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../screens/auth/sign_in_screen.dart';

class AppRoutes {
  static const String signIn = '/';
  static const String signUp = '/sign-up';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String quiz = '/quiz';
  static const String result = '/result';
}

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.signIn,
    routes: [
      GoRoute(
        path: AppRoutes.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Halaman Sign Up'))),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Halaman Home'))),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Halaman Profil'))),
      ),
      GoRoute(
        path: AppRoutes.quiz,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Halaman Kuis'))),
      ),
      GoRoute(
        path: AppRoutes.result,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Halaman Hasil'))),
      ),
    ],
  );
}
