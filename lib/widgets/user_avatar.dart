import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/utils/responsive.dart';

class UserAvatar extends StatelessWidget {
  final String? imagePath;
  final double radius;
  final Color? ringColor;
  final double ringWidth;
  final double ringGap;

  const UserAvatar({
    super.key,
    required this.imagePath,
    this.radius = 25,
    this.ringColor,
    this.ringWidth = 2,
    this.ringGap = 2,
  });

  ImageProvider? _imageProvider() {
    final path = imagePath;
    if (path == null) return null;
    return kIsWeb ? NetworkImage(path) : FileImage(File(path));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final r = Responsive.of(context);

    final avatar = CircleAvatar(
      radius: r.s(radius),
      backgroundColor: isDark
          ? AppColors.champagne.withValues(alpha: 0.2)
          : Colors.white,
      backgroundImage: _imageProvider(),
      child: imagePath == null
          ? Icon(
              Icons.person_rounded,
              color: AppColors.coffeeBean,
              size: r.s(radius * 1.2),
            )
          : null,
    );

    if (ringColor == null) return avatar;

    return Container(
      padding: EdgeInsets.all(r.s(ringGap)),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: ringColor!, width: ringWidth),
      ),
      child: avatar,
    );
  }
}
