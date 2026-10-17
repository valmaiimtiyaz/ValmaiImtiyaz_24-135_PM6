import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/utils/responsive.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/user_avatar.dart';

void showEditProfileSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const EditProfileSheet(),
  );
}

class EditProfileSheet extends StatefulWidget {
  const EditProfileSheet({super.key});

  @override
  State<EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends State<EditProfileSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    final user = context.read<UserProvider>();
    _nameController = TextEditingController(text: user.name);
    _usernameController = TextEditingController(text: user.username);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final user = context.read<UserProvider>();
    final messenger = ScaffoldMessenger.of(context);
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) user.updateProfileImage(image.path);
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('Gagal membuka galeri: $e')),
      );
    }
  }

  void _save() {
    final messenger = ScaffoldMessenger.of(context);
    final snackRadius = Responsive.of(context).s(10);
    context.read<UserProvider>().updateProfile(
      _nameController.text,
      _usernameController.text.replaceAll('@', ''),
    );
    Navigator.of(context).pop();
    messenger.showSnackBar(
      SnackBar(
        content: const Text('Profil berhasil diperbarui!'),
        backgroundColor: AppColors.blazeOrange,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(snackRadius),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final r = Responsive.of(context);
    final user = context.watch<UserProvider>();

    return Container(
      padding: EdgeInsets.only(
        top: r.s(24),
        left: r.s(24),
        right: r.s(24),
        bottom: MediaQuery.viewInsetsOf(context).bottom + r.s(24),
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.coffeeBean : AppColors.champagne,
        borderRadius: BorderRadius.vertical(top: Radius.circular(r.s(30))),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Edit Profil',
              style: TextStyle(
                fontSize: r.font(20),
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.champagne : AppColors.lightNavyBlue,
              ),
            ),
            SizedBox(height: r.s(24)),
            Stack(
              children: [
                UserAvatar(imagePath: user.profileImagePath, radius: 45),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: _pickImage,
                    customBorder: const CircleBorder(),
                    child: Container(
                      padding: r.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.blazeOrange,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark
                              ? AppColors.coffeeBean
                              : AppColors.champagne,
                          width: r.s(2.5),
                        ),
                      ),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.white,
                        size: r.s(18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: r.s(32)),
            CustomTextField(
              hintText: 'Ubah Nama',
              icon: Icons.person_outline_rounded,
              controller: _nameController,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: r.s(16)),
            CustomTextField(
              hintText: 'Ubah Username',
              icon: Icons.alternate_email_rounded,
              controller: _usernameController,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: r.s(24)),
            CustomButton(text: 'Simpan Perubahan', onPressed: _save),
          ],
        ),
      ),
    );
  }
}
