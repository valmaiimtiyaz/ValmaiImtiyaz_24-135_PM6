import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/providers/user_provider.dart';
import '../../core/routes/app_router.dart';
import '../../core/utils/responsive.dart';
import '../../widgets/menu_tile.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/user_avatar.dart';
import 'widgets/edit_profile_sheet.dart';
import 'widgets/theme_sheet.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final r = Responsive.of(context);
    final user = context.watch<UserProvider>();
    final titleColor = isDark ? AppColors.champagne : AppColors.lightNavyBlue;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: r.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              UserAvatar(
                imagePath: user.profileImagePath,
                radius: 50,
                ringColor: AppColors.blazeOrange,
                ringWidth: 3,
                ringGap: 4,
              ),
              SizedBox(height: r.s(16)),
              Text(
                user.displayName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: r.font(24),
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                ),
              ),
              SizedBox(height: r.s(4)),
              Text(
                user.handle,
                style: TextStyle(
                  fontSize: r.font(14),
                  color: (isDark ? AppColors.champagne : AppColors.coffeeBean)
                      .withValues(alpha: 0.7),
                ),
              ),
              SizedBox(height: r.s(32)),

              // PERBAIKAN: Dibungkus dengan IntrinsicHeight untuk mencegah "forces an infinite height"
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: StatCard(
                        title: 'Total Skor',
                        value: '${user.totalScore}',
                        icon: Icons.star_rounded,
                      ),
                    ),
                    SizedBox(width: r.s(16)),
                    Expanded(
                      child: StatCard(
                        title: 'Kuis Selesai',
                        value: '${user.completedQuizzes}',
                        icon: Icons.task_alt_rounded,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: r.s(40)),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Pengaturan Akun',
                  style: TextStyle(
                    fontSize: r.font(22),
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                ),
              ),
              SizedBox(height: r.s(16)),
              MenuTile(
                icon: Icons.edit_rounded,
                title: 'Edit Profil',
                onTap: () => showEditProfileSheet(context),
              ),
              MenuTile(
                icon: Icons.color_lens_rounded,
                title: 'Tema Tampilan',
                onTap: () => showThemeSheet(context),
              ),
              MenuTile(
                icon: Icons.help_outline_rounded,
                title: 'Pusat Bantuan',
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Pusat Bantuan sedang dalam pengembangan.'),
                  ),
                ),
              ),
              SizedBox(height: r.s(32)),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => context.go(AppRoutes.signIn),
                  icon: const Icon(
                    Icons.logout_rounded,
                    color: Colors.redAccent,
                  ),
                  label: Text(
                    'Keluar Akun',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: r.font(16),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: r.s(16)),
                    side: const BorderSide(color: Colors.redAccent, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(r.s(16)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: r.s(24)),
            ],
          ),
        ),
      ),
    );
  }
}
