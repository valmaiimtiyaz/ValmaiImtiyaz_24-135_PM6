import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/utils/responsive.dart';
import 'glass_card.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final r = Responsive.of(context);

    return GlassCard(
      onTap: onTap,
      padding: r.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            padding: r.all(12),
            decoration: BoxDecoration(
              color: AppColors.blazeOrange.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.blazeOrange, size: r.s(28)),
          ),
          SizedBox(width: r.s(16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: r.font(16),
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.champagne : AppColors.coffeeBean,
                  ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: r.s(2)),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: r.font(12),
                      fontWeight: FontWeight.w600,
                      color: AppColors.blazeOrange,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Icon(
            Icons.play_arrow_rounded,
            color: isDark ? AppColors.champagne : AppColors.lightNavyBlue,
            size: r.s(28),
          ),
        ],
      ),
    );
  }
}
