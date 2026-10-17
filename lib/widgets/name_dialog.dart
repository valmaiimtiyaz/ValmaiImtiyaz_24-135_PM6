import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/utils/responsive.dart';
import 'custom_textfield.dart';

Future<String?> showNameDialog(
  BuildContext context, {
  String initialName = '',
}) {
  return showDialog<String>(
    context: context,
    builder: (_) => NameDialog(initialName: initialName),
  );
}

class NameDialog extends StatefulWidget {
  final String initialName;

  const NameDialog({super.key, this.initialName = ''});

  @override
  State<NameDialog> createState() => _NameDialogState();
}

class _NameDialogState extends State<NameDialog> {
  late final TextEditingController _controller;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _controller.text.trim();
    if (name.isEmpty) {
      setState(() => _error = 'Nama tidak boleh kosong');
      return;
    }
    Navigator.of(context).pop(name);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final r = Responsive.of(context);
    final titleColor = isDark ? AppColors.champagne : AppColors.lightNavyBlue;

    return AlertDialog(
      scrollable: true,
      backgroundColor: isDark ? AppColors.coffeeBean : AppColors.champagne,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(r.s(24)),
      ),
      title: Text(
        'Siapa namamu?',
        style: TextStyle(
          fontSize: r.font(20),
          fontWeight: FontWeight.bold,
          color: titleColor,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nama ini akan tampil pada skor akhir kuismu.',
            style: TextStyle(
              fontSize: r.font(14),
              color: isDark ? AppColors.champagne : AppColors.coffeeBean,
            ),
          ),
          SizedBox(height: r.s(16)),
          CustomTextField(
            hintText: 'Nama',
            icon: Icons.person_outline_rounded,
            controller: _controller,
            errorText: _error,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _submit(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Batal',
            style: TextStyle(
              color: (isDark ? AppColors.champagne : AppColors.coffeeBean)
                  .withValues(alpha: 0.7),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.blazeOrange,
            foregroundColor: Colors.white,
          ),
          child: const Text(
            'Mulai',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
