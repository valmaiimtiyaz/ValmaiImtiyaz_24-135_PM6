import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/utils/responsive.dart';

class OptionTile extends StatelessWidget {
  final String letter;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionTile({
    super.key,
    required this.letter,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final r = Responsive.of(context);
    final borderRadius = BorderRadius.circular(r.s(16));

    return Padding(
      padding: EdgeInsets.only(bottom: r.s(12)),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.blazeOrange.withValues(alpha: 0.15)
              : (isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.white.withValues(alpha: 0.5)),
          borderRadius: borderRadius,
          border: Border.all(
            color: isSelected ? AppColors.blazeOrange : Colors.transparent,
            width: r.s(2),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: borderRadius,
            child: Padding(
              padding: r.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Container(
                    width: r.s(36),
                    height: r.s(36),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? AppColors.blazeOrange
                          : (isDark
                                ? Colors.white.withValues(alpha: 0.1)
                                : AppColors.blazeOrange.withValues(
                                    alpha: 0.15,
                                  )),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      letter,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: r.font(16),
                        color: isSelected
                            ? Colors.white
                            : (isDark
                                  ? AppColors.champagne
                                  : AppColors.blazeOrange),
                      ),
                    ),
                  ),
                  SizedBox(width: r.s(16)),
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: r.font(16),
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: isDark
                            ? AppColors.champagne
                            : AppColors.coffeeBean,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
