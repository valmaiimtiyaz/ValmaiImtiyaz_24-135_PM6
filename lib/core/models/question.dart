import 'package:flutter/material.dart';

class Question {
  final String text;
  final List<String> options;
  final int correctIndex;

  const Question({
    required this.text,
    required this.options,
    required this.correctIndex,
  });
}

class QuizCategory {
  final String name;
  final IconData icon;
  final List<Question> questions;

  const QuizCategory({
    required this.name,
    required this.icon,
    required this.questions,
  });
}

class QuizResult {
  final String playerName;
  final String category;
  final int score;
  final int correctCount;
  final List<Question> questions;
  final Map<int, int> answers;

  const QuizResult({
    required this.playerName,
    required this.category,
    required this.score,
    required this.correctCount,
    required this.questions,
    required this.answers,
  });

  int get totalQuestions => questions.length;
}
