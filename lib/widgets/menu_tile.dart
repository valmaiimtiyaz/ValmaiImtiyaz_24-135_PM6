import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/utils/responsive.dart';

class MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const MenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final r = Responsive.of(context);

    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: r.all(10),
        decoration: BoxDecoration(
          color: AppColors.lightNavyBlue.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.lightNavyBlue, size: r.s(24)),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: r.font(16),
          fontWeight: FontWeight.w600,
          color: isDark ? AppColors.champagne : AppColors.coffeeBean,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: isDark
            ? AppColors.champagne.withValues(alpha: 0.5)
            : AppColors.coffeeBean.withValues(alpha: 0.5),
      ),
    );
  }
}
