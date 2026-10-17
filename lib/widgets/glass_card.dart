import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/utils/responsive.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double radius;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.radius = 20,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final r = Responsive.of(context);
    final borderRadius = BorderRadius.circular(r.s(radius));

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white.withValues(alpha: 0.5),
        borderRadius: borderRadius,
        border: Border.all(
          color: isDark ? Colors.transparent : Colors.white,
          width: r.s(1.5),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.coffeeBean.withValues(alpha: 0.03),
            blurRadius: r.s(15),
            offset: Offset(0, r.s(4)),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          child: Padding(padding: padding ?? r.all(16), child: child),
        ),
      ),
    );
  }
}
