import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/routes/app_router.dart';

class ResultScreen extends StatelessWidget {
  final String category;
  final int score;
  final Map<int, int> userAnswers;
  final List<Map<String, dynamic>> questions;

  const ResultScreen({
    super.key,
    required this.category,
    required this.score,
    required this.userAnswers,
    required this.questions,
  });

  void _showReviewBottomSheet(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? AppColors.coffeeBean : AppColors.champagne,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.champagne.withOpacity(0.3)
                            : AppColors.coffeeBean.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Pembahasan Kuis',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.champagne
                          : AppColors.lightNavyBlue,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: questions.length,
                      itemBuilder: (context, index) {
                        final questionData = questions[index];
                        final userAnswerIndex = userAnswers[index];
                        final correctAnswerIndex = questionData['correctIndex'];
                        final isCorrect = userAnswerIndex == correctAnswerIndex;

                        final correctColor = AppColors.blazeOrange;
                        final wrongColor = isDark
                            ? AppColors.champagne.withOpacity(0.6)
                            : AppColors.coffeeBean.withOpacity(0.5);
                        final infoColor = AppColors.lightNavyBlue;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.champagne.withOpacity(0.05)
                                : AppColors.coffeeBean.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isCorrect
                                  ? correctColor.withOpacity(0.5)
                                  : wrongColor.withOpacity(0.3),
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Soal ${index + 1}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? AppColors.champagne
                                      : AppColors.lightNavyBlue,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                questionData['question'],
                                style: TextStyle(
                                  color: isDark
                                      ? AppColors.champagne.withOpacity(0.9)
                                      : AppColors.coffeeBean.withOpacity(0.9),
                                ),
                              ),
                              const SizedBox(height: 12),

                              Row(
                                children: [
                                  Icon(
                                    isCorrect
                                        ? Icons.check_circle_rounded
                                        : Icons.cancel_rounded,
                                    color: isCorrect
                                        ? correctColor
                                        : wrongColor,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Jawabanmu: ${userAnswerIndex != null ? questionData['options'][userAnswerIndex] : 'Tidak dijawab'}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: isCorrect
                                            ? correctColor
                                            : wrongColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              if (!isCorrect) ...[
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.info_rounded,
                                      color: infoColor,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'Benar: ${questionData['options'][correctAnswerIndex]}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: infoColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        );
                      },
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;

    String feedbackMessage;
    if (score == 100) {
      feedbackMessage = 'Sempurna! Kamu sungguh jenius!';
    } else if (score >= 80) {
      feedbackMessage = 'Luar Biasa! Sedikit lagi sempurna.';
    } else if (score >= 60) {
      feedbackMessage = 'Mantap! Otakmu makin tajam, \n yuk asah lagi!';
    } else {
      feedbackMessage = 'Jangan Menyerah! Ayo coba lagi.';
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: AppColors.blazeOrange.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.emoji_events_rounded,
                  size: 100,
                  color: AppColors.blazeOrange,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Kuis Selesai!',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.champagne : AppColors.lightNavyBlue,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Kategori: $category',
                style: textTheme.titleMedium?.copyWith(
                  color: isDark
                      ? AppColors.champagne.withOpacity(0.7)
                      : AppColors.coffeeBean.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 32),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withOpacity(0.05)
                      : Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(24),
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
                    Text(
                      'Skor Kamu',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.champagne
                            : AppColors.coffeeBean,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$score',
                      style: textTheme.displayLarge?.copyWith(
                        fontSize: 80,
                        fontWeight: FontWeight.w900,
                        color: AppColors.blazeOrange,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      feedbackMessage,
                      textAlign: TextAlign.center,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? AppColors.champagne.withOpacity(0.8)
                            : AppColors.coffeeBean,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.pushReplacement(AppRoutes.quiz, extra: category);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blazeOrange,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Main Lagi',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  OutlinedButton(
                    onPressed: () => _showReviewBottomSheet(context, isDark),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 56),
                      side: const BorderSide(
                        color: AppColors.lightNavyBlue,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Lihat Pembahasan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.lightNavyBlue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  TextButton(
                    onPressed: () {
                      context.go(AppRoutes.home);
                    },
                    style: TextButton.styleFrom(
                      minimumSize: const Size(double.infinity, 56),
                    ),
                    child: Text(
                      'Kembali ke Beranda',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.champagne.withOpacity(0.7)
                            : AppColors.coffeeBean.withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
