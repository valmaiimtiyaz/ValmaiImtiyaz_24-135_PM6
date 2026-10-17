import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/providers/quiz_provider.dart';
import 'core/providers/user_provider.dart';
import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'widgets/responsive_wrapper.dart';

void main() {
  runApp(const AsahAsikApp());
}

class AsahAsikApp extends StatelessWidget {
  const AsahAsikApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp.router(
      title: 'AsahAsik',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      routerConfig: AppRouter.router,
      builder: (context, child) =>
          ResponsiveWrapper(child: child ?? const SizedBox.shrink()),
    );
  }
}
