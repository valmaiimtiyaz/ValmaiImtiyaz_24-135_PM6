import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/providers/user_provider.dart';
import '../../core/utils/responsive.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _nameError;
  String? _usernameError;
  String? _passwordError;
  String? _confirmError;

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _nameController.text.trim();
    final username = _usernameController.text.trim();
    final password = _passwordController.text;
    final confirm = _confirmPasswordController.text;

    setState(() {
      _nameError = name.isEmpty ? 'Nama lengkap wajib diisi' : null;
      _usernameError = username.isEmpty ? 'Nama pengguna wajib diisi' : null;
      _passwordError = password.length < 6
          ? 'Kata sandi minimal 6 karakter'
          : null;
      _confirmError = confirm != password ? 'Kata sandi tidak sama' : null;
    });
    if (_nameError != null ||
        _usernameError != null ||
        _passwordError != null ||
        _confirmError != null) {
      return;
    }

    context.read<UserProvider>().register(
      name: name,
      username: username,
      password: password,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Akun berhasil dibuat! Silakan masuk.'),
        backgroundColor: AppColors.blazeOrange,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                padding: r.symmetric(horizontal: 30, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: r.s(40)),
                    Text(
                      'Buat Akun\nBaru!',
                      style: textTheme.displayLarge?.copyWith(
                        fontSize: r.font(36),
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: r.s(12)),
                    Text(
                      'Daftarkan dirimu dan mulai asah otakmu\nbersama AsahAsik.',
                      style: textTheme.bodyLarge?.copyWith(
                        fontSize: r.font(16),
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: r.hp(4)),
                    CustomTextField(
                      hintText: 'Nama Lengkap',
                      icon: Icons.person_outline_rounded,
                      controller: _nameController,
                      errorText: _nameError,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: r.s(16)),
                    CustomTextField(
                      hintText: 'Nama Pengguna',
                      icon: Icons.alternate_email_rounded,
                      controller: _usernameController,
                      errorText: _usernameError,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: r.s(16)),
                    CustomTextField(
                      hintText: 'Kata Sandi',
                      icon: Icons.lock_outline_rounded,
                      isPassword: true,
                      controller: _passwordController,
                      errorText: _passwordError,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: r.s(16)),
                    CustomTextField(
                      hintText: 'Konfirmasi Kata Sandi',
                      icon: Icons.lock_reset_rounded,
                      isPassword: true,
                      controller: _confirmPasswordController,
                      errorText: _confirmError,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _submit(),
                    ),
                    SizedBox(height: r.hp(4)),
                    CustomButton(text: 'Daftar Sekarang', onPressed: _submit),
                    SizedBox(height: r.s(24)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sudah punya akun? ',
                          style: textTheme.bodyMedium?.copyWith(
                            fontSize: r.font(14),
                            color: AppColors.lightNavyBlue,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: Text(
                            'Masuk di sini',
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
            Positioned(
              top: r.s(16),
              left: r.s(16),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.lightNavyBlue.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  color: AppColors.lightNavyBlue,
                  onPressed: () => context.pop(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
