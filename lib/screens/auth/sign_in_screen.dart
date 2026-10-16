import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/routes/app_router.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? size.width * 0.25 : 30.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.lightNavyBlue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.waving_hand_rounded,
                    size: 32,
                    color: AppColors.lightNavyBlue,
                  ),
                ),
                const SizedBox(height: 24),

                Text(
                  'Halo,\nSelamat Datang!',
                  style: textTheme.displayLarge?.copyWith(
                    fontSize: 36,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Masuk ke akun AsahAsik Kamu\nuntuk memulai quiz.',
                  style: textTheme.bodyLarge?.copyWith(height: 1.4),
                ),
                SizedBox(height: size.height * 0.05),
                CustomTextField(
                  hintText: 'Nama Pengguna',
                  icon: Icons.alternate_email_rounded,
                  controller: _usernameController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Kata Sandi',
                  icon: Icons.lock_outline_rounded,
                  isPassword: true,
                  controller: _passwordController,
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.lightNavyBlue,
                    ),
                    child: const Text(
                      'Lupa kata sandi?',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),

                CustomButton(
                  text: 'Masuk',
                  onPressed: () {
                    context.go(AppRoutes.home);
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Belum punya akun? ',
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.lightNavyBlue,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.push(AppRoutes.signUp);
                      },
                      child: const Text(
                        'Buat akun',
                        style: TextStyle(
                          color: AppColors.blazeOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
