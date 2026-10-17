import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/providers/user_provider.dart';
import '../../core/routes/app_router.dart';
import '../../core/utils/responsive.dart';
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
  String? _usernameError;
  String? _passwordError;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    setState(() {
      _usernameError = username.isEmpty ? 'Nama pengguna wajib diisi' : null;
      _passwordError = password.isEmpty ? 'Kata sandi wajib diisi' : null;
    });
    if (_usernameError != null || _passwordError != null) return;

    final user = context.read<UserProvider>();
    if (!user.hasAccount) {
      setState(
        () => _usernameError = 'Akun belum terdaftar. Silakan buat akun dulu.',
      );
      return;
    }

    final success = user.signIn(username, password);
    if (success) {
      context.go(AppRoutes.home);
    } else {
      setState(() => _passwordError = 'Nama pengguna atau kata sandi salah');
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: r.symmetric(horizontal: 30, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: r.s(72),
                  height: r.s(72),
                ),
                SizedBox(height: r.s(24)),
                Text(
                  'Halo,\nSelamat Datang!',
                  style: textTheme.displayLarge?.copyWith(
                    fontSize: r.font(36),
                    height: 1.2,
                  ),
                ),
                SizedBox(height: r.s(12)),
                Text(
                  'Masuk ke akun AsahAsik Kamu\nuntuk memulai quiz.',
                  style: textTheme.bodyLarge?.copyWith(
                    fontSize: r.font(16),
                    height: 1.4,
                  ),
                ),
                SizedBox(height: r.hp(4)),
                CustomTextField(
                  hintText: 'Nama Pengguna',
                  icon: Icons.alternate_email_rounded,
                  controller: _usernameController,
                  errorText: _usernameError,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: r.s(20)),
                CustomTextField(
                  hintText: 'Kata Sandi',
                  icon: Icons.lock_outline_rounded,
                  isPassword: true,
                  controller: _passwordController,
                  errorText: _passwordError,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _submit(),
                ),
                SizedBox(height: r.s(12)),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fitur ini belum tersedia.'),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.lightNavyBlue,
                    ),
                    child: Text(
                      'Lupa kata sandi?',
                      style: TextStyle(
                        fontSize: r.font(14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: r.hp(2)),
                CustomButton(text: 'Masuk', onPressed: _submit),
                SizedBox(height: r.s(24)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Belum punya akun? ',
                      style: textTheme.bodyMedium?.copyWith(
                        fontSize: r.font(14),
                        color: AppColors.lightNavyBlue,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.push(AppRoutes.signUp),
                      child: Text(
                        'Buat akun',
                        style: TextStyle(
                          color: AppColors.blazeOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: r.font(14),
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
