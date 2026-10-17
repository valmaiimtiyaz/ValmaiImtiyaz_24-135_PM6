import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/models/question.dart';
import '../core/utils/responsive.dart';

class ReviewCard extends StatelessWidget {
  final int number;
  final Question question;
  final int? userAnswer;

  const ReviewCard({
    super.key,
    required this.number,
    required this.question,
    required this.userAnswer,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final r = Responsive.of(context);
    final isCorrect = userAnswer == question.correctIndex;

    const correctColor = AppColors.blazeOrange;
    const infoColor = AppColors.lightNavyBlue;
    final wrongColor = isDark
        ? AppColors.champagne.withValues(alpha: 0.6)
        : AppColors.coffeeBean.withValues(alpha: 0.5);
    final answerColor = isCorrect ? correctColor : wrongColor;

    return Container(
      margin: EdgeInsets.only(bottom: r.s(16)),
      padding: r.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.champagne.withValues(alpha: 0.05)
            : AppColors.coffeeBean.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(r.s(16)),
        border: Border.all(
          color: isCorrect
              ? correctColor.withValues(alpha: 0.5)
              : wrongColor.withValues(alpha: 0.3),
          width: r.s(1.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Soal $number',
            style: TextStyle(
              fontSize: r.font(14),
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.champagne : AppColors.lightNavyBlue,
            ),
          ),
          SizedBox(height: r.s(8)),
          Text(
            question.text,
            style: TextStyle(
              fontSize: r.font(14),
              color: isDark
                  ? AppColors.champagne.withValues(alpha: 0.9)
                  : AppColors.coffeeBean.withValues(alpha: 0.9),
            ),
          ),
          SizedBox(height: r.s(12)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                color: answerColor,
                size: r.s(20),
              ),
              SizedBox(width: r.s(8)),
              Expanded(
                child: Text(
                  'Jawabanmu: ${userAnswer != null ? question.options[userAnswer!] : 'Tidak dijawab'}',
                  style: TextStyle(
                    fontSize: r.font(14),
                    fontWeight: FontWeight.w600,
                    color: answerColor,
                  ),
                ),
              ),
            ],
          ),
          if (!isCorrect) ...[
            SizedBox(height: r.s(4)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_rounded, color: infoColor, size: r.s(20)),
                SizedBox(width: r.s(8)),
                Expanded(
                  child: Text(
                    'Benar: ${question.options[question.correctIndex]}',
                    style: TextStyle(
                      fontSize: r.font(14),
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
  }
}
