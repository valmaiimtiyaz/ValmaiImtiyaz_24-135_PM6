import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/routes/app_router.dart';
import '../../core/providers/user_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Halo, ${userProvider.name}! 👋',
                          style: textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: isDark
                                ? AppColors.champagne
                                : AppColors.lightNavyBlue,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Siap memecahkan rekor hari ini?',
                          style: textTheme.bodyMedium?.copyWith(
                            color: isDark
                                ? AppColors.champagne.withOpacity(0.8)
                                : AppColors.blazeOrange,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDark
                            ? AppColors.champagne
                            : AppColors.lightNavyBlue.withOpacity(0.3),
                        width: 2.0,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: isDark
                          ? AppColors.champagne.withOpacity(0.2)
                          : Colors.white.withOpacity(0.5),
                      backgroundImage: userProvider.profileImagePath != null
                          ? FileImage(File(userProvider.profileImagePath!))
                          : null,
                      child: userProvider.profileImagePath == null
                          ? const Icon(
                              Icons.person_rounded,
                              color: AppColors.coffeeBean,
                              size: 30,
                            )
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.blazeOrange,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blazeOrange.withOpacity(0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.emoji_events_rounded,
                        color: AppColors.champagne,
                        size: 36,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Skor Tertinggi',
                            style: textTheme.titleMedium?.copyWith(
                              color: AppColors.champagne.withOpacity(0.9),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '1,250',
                            style: textTheme.displayLarge?.copyWith(
                              color: AppColors.champagne,
                              fontSize: 40,
                              fontWeight: FontWeight.w900,
                              height: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              Text(
                'Pilih Tantangan',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.champagne : AppColors.lightNavyBlue,
                ),
              ),
              const SizedBox(height: 20),

              _buildQuizTile(
                context: context,
                title: 'Pengetahuan Umum',
                icon: Icons.public_rounded,
                isDark: isDark,
              ),
              const SizedBox(height: 16),
              _buildQuizTile(
                context: context,
                title: 'Logika & Analisis',
                icon: Icons.extension_rounded,
                isDark: isDark,
              ),
              const SizedBox(height: 16),
              _buildQuizTile(
                context: context,
                title: 'Tebak Pola',
                icon: Icons.radar_rounded,
                isDark: isDark,
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuizTile({
    required BuildContext context,
    required String title,
    required IconData icon,
    required bool isDark,
  }) {
    return InkWell(
      onTap: () {
        context.push(AppRoutes.quiz);
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.05)
              : Colors.white.withOpacity(0.5),

          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark ? Colors.transparent : Colors.white,
            width: 1.5,
          ),

          boxShadow: [
            BoxShadow(
              color: AppColors.coffeeBean.withOpacity(0.03),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.blazeOrange.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.blazeOrange, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.champagne : AppColors.coffeeBean,
                ),
              ),
            ),
            const Icon(
              Icons.play_arrow_rounded,
              color: AppColors.lightNavyBlue,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
