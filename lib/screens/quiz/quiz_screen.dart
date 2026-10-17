import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/data/quiz_data.dart';

class QuizScreen extends StatefulWidget {
  final String category;

  const QuizScreen({super.key, required this.category});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  Map<int, int> userAnswers = {};

  List<Map<String, dynamic>> questions = [];

  @override
  void initState() {
    super.initState();
    questions =
        QuizData.categories[widget.category] ??
        QuizData.categories['Pengetahuan Umum']!;
  }

  void _nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      int finalScore = 0;
      for (int i = 0; i < questions.length; i++) {
        if (userAnswers[i] == questions[i]['correctIndex']) {
          finalScore += 20;
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kuis Selesai! Skor Akhir: $finalScore/100'),
          backgroundColor: AppColors.blazeOrange,
        ),
      );
      context.pop();
    }
  }

  void _previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;

    final currentQuestionData = questions[currentQuestionIndex];
    final totalQuestions = questions.length;
    final List<String> optionLetters = ['A', 'B', 'C', 'D'];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => context.pop(),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: isDark
                          ? AppColors.champagne
                          : AppColors.lightNavyBlue,
                    ),
                  ),
                  Text(
                    ' ${currentQuestionIndex + 1} / $totalQuestions',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.champagne
                          : AppColors.lightNavyBlue,
                    ),
                  ),
                  const SizedBox(width: 24),
                ],
              ),
              const SizedBox(height: 16),

              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: (currentQuestionIndex + 1) / totalQuestions,
                  minHeight: 6,
                  backgroundColor: isDark
                      ? AppColors.lightNavyBlue.withOpacity(0.3)
                      : AppColors.lightNavyBlue.withOpacity(0.4),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.blazeOrange,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.champagne.withOpacity(0.1)
                        : Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isDark
                          ? Colors.transparent
                          : AppColors.coffeeBean.withOpacity(0.05),
                    ),
                  ),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Text(
                        currentQuestionData['question'],
                        textAlign: TextAlign.center,
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppColors.champagne
                              : AppColors.coffeeBean,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              Expanded(
                flex: 5,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    final isSelected =
                        userAnswers[currentQuestionIndex] == index;

                    final optionText = currentQuestionData['options'][index];
                    final letter = optionLetters[index];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          userAnswers[currentQuestionIndex] = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.blazeOrange.withOpacity(0.15)
                              : (isDark
                                    ? Colors.white.withOpacity(0.05)
                                    : Colors.white.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.blazeOrange
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected
                                    ? AppColors.blazeOrange
                                    : (isDark
                                          ? Colors.white.withOpacity(0.1)
                                          : AppColors.blazeOrange.withOpacity(
                                              0.15,
                                            )),
                              ),
                              child: Center(
                                child: Text(
                                  letter,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: isSelected
                                        ? Colors.white
                                        : (isDark
                                              ? AppColors.champagne
                                              : AppColors.blazeOrange),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                optionText,
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                  color: isDark
                                      ? AppColors.champagne
                                      : AppColors.coffeeBean,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: currentQuestionIndex > 0
                          ? _previousQuestion
                          : null,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(
                          color: currentQuestionIndex > 0
                              ? (isDark
                                    ? AppColors.champagne.withOpacity(0.5)
                                    : AppColors.coffeeBean.withOpacity(0.2))
                              : Colors.transparent,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Sebelumnya',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: currentQuestionIndex > 0
                              ? (isDark
                                    ? AppColors.champagne
                                    : AppColors.coffeeBean)
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: userAnswers.containsKey(currentQuestionIndex)
                          ? _nextQuestion
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blazeOrange,
                        disabledBackgroundColor: AppColors.blazeOrange
                            .withOpacity(0.3),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        currentQuestionIndex == questions.length - 1
                            ? 'Selesai'
                            : 'Selanjutnya',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
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
