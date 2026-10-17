import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/providers/quiz_provider.dart';
import '../../core/providers/user_provider.dart';
import '../../core/routes/app_router.dart';
import '../../core/utils/responsive.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/option_tile.dart';
import '../../widgets/question_card.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  static const List<String> _optionLetters = ['A', 'B', 'C', 'D'];

  void _leave(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.home);
    }
  }

  void _finish(BuildContext context) {
    final quiz = context.read<QuizProvider>();
    if (quiz.isFinished) return;

    final user = context.read<UserProvider>();
    final result = quiz.finish(user.displayName);
    user.recordResult(result.category, result.score);
    context.pushReplacement(AppRoutes.result);
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();

    if (quiz.category == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) context.go(AppRoutes.home);
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final r = Responsive.of(context);
    final mainColor = isDark ? AppColors.champagne : AppColors.lightNavyBlue;
    final question = quiz.currentQuestion;

    final options = Column(
      children: [
        for (var i = 0; i < question.options.length; i++)
          OptionTile(
            letter: _optionLetters[i],
            text: question.options[i],
            isSelected: quiz.selectedAnswer == i,
            onTap: () => quiz.selectAnswer(i),
          ),
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: r.all(24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => _leave(context),
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: mainColor,
                      size: r.s(24),
                    ),
                  ),
                  Text(
                    '${quiz.currentIndex + 1} / ${quiz.totalQuestions}',
                    style: TextStyle(
                      fontSize: r.font(20),
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                  ),
                  SizedBox(width: r.s(48)),
                ],
              ),
              SizedBox(height: r.s(12)),
              ClipRRect(
                borderRadius: BorderRadius.circular(r.s(10)),
                child: LinearProgressIndicator(
                  value: quiz.progress,
                  minHeight: r.s(6),
                  backgroundColor: AppColors.lightNavyBlue.withValues(
                    alpha: isDark ? 0.3 : 0.4,
                  ),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.blazeOrange,
                  ),
                ),
              ),
              SizedBox(height: r.s(20)),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final sideBySide =
                        constraints.maxWidth > constraints.maxHeight * 1.2;

                    if (sideBySide) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: QuestionCard(text: question.text),
                            ),
                          ),
                          SizedBox(width: r.s(16)),
                          Expanded(
                            child: SingleChildScrollView(child: options),
                          ),
                        ],
                      );
                    }

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          QuestionCard(text: question.text),
                          SizedBox(height: r.s(20)),
                          options,
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: r.s(12)),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Sebelumnya',
                      variant: ButtonVariant.outlined,
                      onPressed: quiz.isFirstQuestion ? null : quiz.previous,
                    ),
                  ),
                  SizedBox(width: r.s(16)),
                  Expanded(
                    child: CustomButton(
                      text: quiz.isLastQuestion ? 'Selesai' : 'Selanjutnya',
                      onPressed: quiz.selectedAnswer == null
                          ? null
                          : (quiz.isLastQuestion
                                ? () => _finish(context)
                                : quiz.next),
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
