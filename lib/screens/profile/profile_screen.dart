import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/constants/app_colors.dart';
import '../../core/routes/app_router.dart';
import '../../core/theme/theme_provider.dart';
import '../../core/providers/user_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.blazeOrange,
                          width: 3.0,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: isDark
                            ? AppColors.champagne.withOpacity(0.2)
                            : Colors.white,
                        backgroundImage: userProvider.profileImagePath != null
                            ? FileImage(File(userProvider.profileImagePath!))
                            : null,
                        child: userProvider.profileImagePath == null
                            ? const Icon(
                                Icons.person_rounded,
                                color: AppColors.coffeeBean,
                                size: 60,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      userProvider.name,
                      style: textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? AppColors.champagne
                            : AppColors.lightNavyBlue,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userProvider.username,
                      style: textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? AppColors.champagne.withOpacity(0.7)
                            : AppColors.coffeeBean.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      title: 'Total Skor',
                      value: '${userProvider.totalScore}',
                      icon: Icons.star_rounded,
                      isDark: isDark,
                      textTheme: textTheme,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      title: 'Kuis Selesai',
                      value: '24',
                      icon: Icons.task_alt_rounded,
                      isDark: isDark,
                      textTheme: textTheme,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Pengaturan Akun',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? AppColors.champagne
                        : AppColors.lightNavyBlue,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              _buildMenuTile(
                icon: Icons.edit_rounded,
                title: 'Edit Profil',
                isDark: isDark,
                onTap: () => _showEditProfileSheet(context),
              ),
              _buildMenuTile(
                icon: Icons.color_lens_rounded,
                title: 'Tema Tampilan',
                isDark: isDark,
                onTap: () => _showThemeSheet(context),
              ),
              _buildMenuTile(
                icon: Icons.help_outline_rounded,
                title: 'Pusat Bantuan',
                isDark: isDark,
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Pusat Bantuan sedang dalam pengembangan.'),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => context.go(AppRoutes.signIn),
                  icon: const Icon(
                    Icons.logout_rounded,
                    color: Colors.redAccent,
                  ),
                  label: const Text(
                    'Keluar Akun',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Colors.redAccent, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditProfileSheet(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final nameController = TextEditingController(text: userProvider.name);
    final usernameController = TextEditingController(
      text: userProvider.username.replaceAll('@', ''),
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: EdgeInsets.only(
                top: 24,
                left: 24,
                right: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              decoration: BoxDecoration(
                color: isDark ? AppColors.coffeeBean : AppColors.champagne,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Edit Profil',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.champagne
                          : AppColors.lightNavyBlue,
                    ),
                  ),
                  const SizedBox(height: 24),

                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: isDark
                              ? AppColors.champagne.withOpacity(0.2)
                              : Colors.white,
                          backgroundImage: userProvider.profileImagePath != null
                              ? FileImage(File(userProvider.profileImagePath!))
                              : null,
                          child: userProvider.profileImagePath == null
                              ? const Icon(
                                  Icons.person_rounded,
                                  color: AppColors.coffeeBean,
                                  size: 50,
                                )
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () async {
                              try {
                                final ImagePicker picker = ImagePicker();
                                final XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery,
                                );

                                if (image != null) {
                                  userProvider.updateProfileImage(image.path);

                                  setModalState(() {});
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Gagal membuka galeri: $e'),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.blazeOrange,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isDark
                                      ? AppColors.coffeeBean
                                      : AppColors.champagne,
                                  width: 2.5,
                                ),
                              ),
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  CustomTextField(
                    hintText: 'Ubah Nama',
                    icon: Icons.person_outline_rounded,
                    controller: nameController,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hintText: 'Ubah Username',
                    icon: Icons.alternate_email_rounded,
                    controller: usernameController,
                  ),
                  const SizedBox(height: 24),

                  CustomButton(
                    text: 'Simpan Perubahan',
                    onPressed: () {
                      userProvider.updateProfile(
                        nameController.text,
                        '@${usernameController.text}',
                      );
                      context.pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Profil berhasil diperbarui!'),
                          backgroundColor: AppColors.blazeOrange,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showThemeSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isDark ? AppColors.coffeeBean : AppColors.champagne,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Ganti Tema',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.champagne : AppColors.lightNavyBlue,
                ),
              ),
              const SizedBox(height: 24),
              ListTile(
                leading: const Icon(
                  Icons.light_mode_rounded,
                  color: AppColors.blazeOrange,
                ),
                title: Text(
                  'Mode Terang (Light)',
                  style: TextStyle(
                    color: isDark ? AppColors.champagne : AppColors.coffeeBean,
                  ),
                ),
                onTap: () {
                  Provider.of<ThemeProvider>(
                    context,
                    listen: false,
                  ).setThemeMode(ThemeMode.light);
                  context.pop();
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.dark_mode_rounded,
                  color: AppColors.lightNavyBlue,
                ),
                title: Text(
                  'Mode Gelap (Dark)',
                  style: TextStyle(
                    color: isDark ? AppColors.champagne : AppColors.coffeeBean,
                  ),
                ),
                onTap: () {
                  Provider.of<ThemeProvider>(
                    context,
                    listen: false,
                  ).setThemeMode(ThemeMode.dark);
                  context.pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required bool isDark,
    required TextTheme textTheme,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        children: [
          Icon(icon, color: AppColors.blazeOrange, size: 32),
          const SizedBox(height: 12),
          Text(
            value,
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.champagne : AppColors.lightNavyBlue,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: textTheme.bodySmall?.copyWith(
              color: isDark
                  ? AppColors.champagne.withOpacity(0.7)
                  : AppColors.coffeeBean,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.lightNavyBlue.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.lightNavyBlue, size: 24),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: isDark ? AppColors.champagne : AppColors.coffeeBean,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: isDark
            ? AppColors.champagne.withOpacity(0.5)
            : AppColors.coffeeBean.withOpacity(0.5),
      ),
    );
  }
}
