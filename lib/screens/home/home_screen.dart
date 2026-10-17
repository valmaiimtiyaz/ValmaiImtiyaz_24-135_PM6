import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/data/quiz_data.dart';
import '../../core/providers/quiz_provider.dart';
import '../../core/providers/user_provider.dart';
import '../../core/routes/app_router.dart';
import '../../core/utils/responsive.dart';
import '../../widgets/category_card.dart';
import '../../widgets/name_dialog.dart';
import '../../widgets/user_avatar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _startQuiz(BuildContext context, String category) async {
    final quiz = context.read<QuizProvider>();
    final user = context.read<UserProvider>();
    if (quiz.canResume(category)) {
      context.push(AppRoutes.quiz);
      return;
    }

    final name = await showNameDialog(context, initialName: user.name);
    if (name == null || !context.mounted) return;

    user.updateName(name);
    quiz.startQuiz(category);
    context.push(AppRoutes.quiz);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final r = Responsive.of(context);
    final user = context.watch<UserProvider>();
    final quiz = context.watch<QuizProvider>();

    final titleColor = isDark ? AppColors.champagne : AppColors.lightNavyBlue;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: r.symmetric(horizontal: 24, vertical: 24),
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
                          'Halo, ${user.displayName}! 👋',
                          style: TextStyle(
                            fontSize: r.font(24),
                            fontWeight: FontWeight.w800,
                            color: titleColor,
                          ),
                        ),
                        SizedBox(height: r.s(4)),
                        Text(
                          'Siap memecahkan rekor hari ini?',
                          style: TextStyle(
                            fontSize: r.font(14),
                            color: isDark
                                ? AppColors.champagne.withValues(alpha: 0.8)
                                : AppColors.blazeOrange,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: r.s(12)),
                  UserAvatar(
                    imagePath: user.profileImagePath,
                    radius: 25,
                    ringColor: isDark
                        ? AppColors.champagne
                        : AppColors.lightNavyBlue.withValues(alpha: 0.3),
                  ),
                ],
              ),
              SizedBox(height: r.s(32)),
              Container(
                width: double.infinity,
                padding: r.all(24),
                decoration: BoxDecoration(
                  color: AppColors.blazeOrange,
                  borderRadius: BorderRadius.circular(r.s(24)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blazeOrange.withValues(alpha: 0.3),
                      blurRadius: r.s(16),
                      offset: Offset(0, r.s(8)),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: r.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(r.s(16)),
                      ),
                      child: Icon(
                        Icons.emoji_events_rounded,
                        color: AppColors.champagne,
                        size: r.s(36),
                      ),
                    ),
                    SizedBox(width: r.s(20)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Skor',
                            style: TextStyle(
                              fontSize: r.font(16),
                              fontWeight: FontWeight.w600,
                              color: AppColors.champagne.withValues(alpha: 0.9),
                            ),
                          ),
                          SizedBox(height: r.s(4)),
                          Text(
                            '${user.totalScore}',
                            style: TextStyle(
                              fontSize: r.font(40),
                              fontWeight: FontWeight.w800,
                              height: 1.1,
                              color: AppColors.champagne,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: r.s(40)),
              Text(
                'Pilih Tantangan',
                style: TextStyle(
                  fontSize: r.font(22),
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                ),
              ),
              SizedBox(height: r.s(20)),
              for (final category in QuizData.categories) ...[
                CategoryCard(
                  title: category.name,
                  icon: category.icon,
                  subtitle: quiz.canResume(category.name)
                      ? 'Lanjutkan kuis'
                      : null,
                  onTap: () => _startQuiz(context, category.name),
                ),
                SizedBox(height: r.s(16)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
