import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/utils/responsive.dart';
import 'glass_card.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final r = Responsive.of(context);

    return GlassCard(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Icon(icon, color: AppColors.blazeOrange, size: r.s(32)),
            SizedBox(height: r.s(12)),
            Text(
              value,
              style: TextStyle(
                fontSize: r.font(24),
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.champagne : AppColors.lightNavyBlue,
              ),
            ),
            SizedBox(height: r.s(4)),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: r.font(12),
                color: isDark
                    ? AppColors.champagne.withValues(alpha: 0.7)
                    : AppColors.coffeeBean,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
