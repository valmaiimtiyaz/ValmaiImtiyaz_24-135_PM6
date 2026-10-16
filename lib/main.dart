import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'core/routes/app_router.dart';

void main() {
  runApp(const AsahAsikApp());
}

class AsahAsikApp extends StatelessWidget {
  const AsahAsikApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'AsahAsik',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
