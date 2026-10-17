import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/responsive.dart';

void showThemeSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const ThemeSheet(),
  );
}

class ThemeSheet extends StatelessWidget {
  const ThemeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final r = Responsive.of(context);
    final themeProvider = context.watch<ThemeProvider>();

    Widget option({
      required IconData icon,
      required Color iconColor,
      required String label,
      required ThemeMode mode,
    }) {
      return ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(
          label,
          style: TextStyle(
            fontSize: r.font(16),
            color: isDark ? AppColors.champagne : AppColors.coffeeBean,
          ),
        ),
        trailing: themeProvider.themeMode == mode
            ? const Icon(Icons.check_rounded, color: AppColors.blazeOrange)
            : null,
        onTap: () {
          context.read<ThemeProvider>().setThemeMode(mode);
          Navigator.of(context).pop();
        },
      );
    }

    return Container(
      padding: r.all(24),
      decoration: BoxDecoration(
        color: isDark ? AppColors.coffeeBean : AppColors.champagne,
        borderRadius: BorderRadius.vertical(top: Radius.circular(r.s(30))),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Ganti Tema',
              style: TextStyle(
                fontSize: r.font(20),
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.champagne : AppColors.lightNavyBlue,
              ),
            ),
            SizedBox(height: r.s(16)),
            option(
              icon: Icons.light_mode_rounded,
              iconColor: AppColors.blazeOrange,
              label: 'Mode Terang (Light)',
              mode: ThemeMode.light,
            ),
            option(
              icon: Icons.dark_mode_rounded,
              iconColor: AppColors.lightNavyBlue,
              label: 'Mode Gelap (Dark)',
              mode: ThemeMode.dark,
            ),
            option(
              icon: Icons.brightness_auto_rounded,
              iconColor: AppColors.lightNavyBlue,
              label: 'Ikuti Sistem',
              mode: ThemeMode.system,
            ),
          ],
        ),
      ),
    );
  }
}
