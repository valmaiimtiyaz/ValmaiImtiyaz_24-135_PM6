import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/utils/responsive.dart';

enum ButtonVariant { filled, outlined, text }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = ButtonVariant.filled,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final r = Responsive.of(context);
    final enabled = onPressed != null;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(r.s(16)),
    );

    final labelStyle = TextStyle(
      fontSize: r.font(16),
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
    );

    final Widget button;
    switch (variant) {
      case ButtonVariant.filled:
        button = ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: isDark
                ? AppColors.champagne
                : AppColors.blazeOrange,
            foregroundColor: isDark
                ? AppColors.coffeeBean
                : AppColors.champagne,
            disabledBackgroundColor: AppColors.blazeOrange.withValues(
              alpha: 0.3,
            ),
            disabledForegroundColor: Colors.white70,
            shape: shape,
            elevation: 0,
          ),
          child: Text(text, style: labelStyle),
        );
        break;
      case ButtonVariant.outlined:
        final color = isDark ? AppColors.champagne : AppColors.lightNavyBlue;
        button = OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: color,
            disabledForegroundColor: Colors.grey,
            side: BorderSide(
              color: enabled ? color : Colors.transparent,
              width: r.s(1.5),
            ),
            shape: shape,
          ),
          child: Text(text, style: labelStyle),
        );
        break;
      case ButtonVariant.text:
        button = TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor:
                (isDark ? AppColors.champagne : AppColors.coffeeBean)
                    .withValues(alpha: 0.7),
            shape: shape,
          ),
          child: Text(text, style: labelStyle),
        );
        break;
    }

    return SizedBox(width: double.infinity, height: r.s(56), child: button);
  }
}
