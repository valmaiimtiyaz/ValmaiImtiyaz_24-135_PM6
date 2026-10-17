import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/utils/responsive.dart';

class QuestionCard extends StatelessWidget {
  final String text;

  const QuestionCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final r = Responsive.of(context);

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: r.hp(14)),
      padding: r.all(24),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.champagne.withValues(alpha: 0.1)
            : Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(r.s(20)),
        border: Border.all(
          color: isDark
              ? Colors.transparent
              : AppColors.coffeeBean.withValues(alpha: 0.05),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: r.font(20),
          fontWeight: FontWeight.w600,
          height: 1.5,
          color: isDark ? AppColors.champagne : AppColors.coffeeBean,
        ),
      ),
    );
  }
}
