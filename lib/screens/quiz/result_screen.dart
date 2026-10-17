import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/models/question.dart';
import '../../core/providers/quiz_provider.dart';
import '../../core/routes/app_router.dart';
import '../../core/utils/responsive.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/review_card.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  String _feedback(int score) {
    if (score == 100) return 'Sempurna! Kamu sungguh jenius!';
    if (score >= 80) return 'Luar Biasa! Sedikit lagi sempurna.';
    if (score >= 60) return 'Mantap! Otakmu makin tajam,\nyuk asah lagi!';
    return 'Jangan Menyerah! Ayo coba lagi.';
  }

  void _playAgain(BuildContext context, QuizResult result) {
    context.read<QuizProvider>().startQuiz(result.category);
    context.pushReplacement(AppRoutes.quiz);
  }

  void _showReview(BuildContext context, QuizResult result) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sheetRadius = Responsive.of(context).s(32);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? AppColors.coffeeBean : AppColors.champagne,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(sheetRadius)),
      ),
      builder: (sheetContext) {
        final r = Responsive.of(sheetContext);
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          expand: false,
          builder: (_, scrollController) {
            return Padding(
              padding: r.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: r.s(50),
                      height: r.s(5),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.champagne.withValues(alpha: 0.3)
                            : AppColors.coffeeBean.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(r.s(10)),
                      ),
                    ),
                  ),
                  SizedBox(height: r.s(20)),
                  Text(
                    'Pembahasan Kuis',
                    style: TextStyle(
                      fontSize: r.font(24),
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.champagne
                          : AppColors.lightNavyBlue,
                    ),
                  ),
                  SizedBox(height: r.s(16)),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: result.questions.length,
                      itemBuilder: (_, index) => ReviewCard(
                        number: index + 1,
                        question: result.questions[index],
                        userAnswer: result.answers[index],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final result = context.watch<QuizProvider>().lastResult;

    if (result == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) context.go(AppRoutes.home);
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final r = Responsive.of(context);
    final titleColor = isDark ? AppColors.champagne : AppColors.lightNavyBlue;
    final bodyColor = isDark ? AppColors.champagne : AppColors.coffeeBean;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: r.all(24),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: (constraints.maxHeight - r.s(48))
                      .clamp(0.0, double.infinity)
                      .toDouble(),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: r.all(28),
                      decoration: BoxDecoration(
                        color: AppColors.blazeOrange.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/trophy.png',
                        width: r.s(88),
                        height: r.s(88),
                      ),
                    ),
                    SizedBox(height: r.s(24)),
                    Text(
                      'Kuis Selesai!',
                      style: TextStyle(
                        fontSize: r.font(28),
                        fontWeight: FontWeight.bold,
                        color: titleColor,
                      ),
                    ),
                    SizedBox(height: r.s(8)),
                    Text(
                      'Kategori: ${result.category}',
                      style: TextStyle(
                        fontSize: r.font(16),
                        fontWeight: FontWeight.w600,
                        color: bodyColor.withValues(alpha: 0.7),
                      ),
                    ),
                    SizedBox(height: r.s(24)),
                    GlassCard(
                      radius: 24,
                      padding: r.symmetric(horizontal: 16, vertical: 28),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Text(
                              'Skor ${result.playerName}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: r.font(18),
                                fontWeight: FontWeight.w600,
                                color: bodyColor,
                              ),
                            ),
                            SizedBox(height: r.s(8)),
                            Text(
                              '${result.score}',
                              style: TextStyle(
                                fontSize: r.font(72),
                                fontWeight: FontWeight.w800,
                                height: 1.1,
                                color: AppColors.blazeOrange,
                              ),
                            ),
                            SizedBox(height: r.s(4)),
                            Text(
                              '${result.correctCount} dari ${result.totalQuestions} soal benar',
                              style: TextStyle(
                                fontSize: r.font(14),
                                color: bodyColor.withValues(alpha: 0.8),
                              ),
                            ),
                            SizedBox(height: r.s(16)),
                            Text(
                              _feedback(result.score),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: r.font(16),
                                fontWeight: FontWeight.w500,
                                color: bodyColor.withValues(alpha: 0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: r.s(28)),
                    CustomButton(
                      text: 'Main Lagi',
                      onPressed: () => _playAgain(context, result),
                    ),
                    SizedBox(height: r.s(12)),
                    CustomButton(
                      text: 'Lihat Pembahasan',
                      variant: ButtonVariant.outlined,
                      onPressed: () => _showReview(context, result),
                    ),
                    SizedBox(height: r.s(12)),
                    CustomButton(
                      text: 'Kembali ke Beranda',
                      variant: ButtonVariant.text,
                      onPressed: () => context.go(AppRoutes.home),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
