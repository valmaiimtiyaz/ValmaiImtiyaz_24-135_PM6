import 'package:flutter/foundation.dart';

import '../data/quiz_data.dart';
import '../models/question.dart';

class QuizProvider extends ChangeNotifier {
  QuizCategory? _category;
  int _currentIndex = 0;
  final Map<int, int> _answers = {};
  bool _isFinished = false;
  QuizResult? _lastResult;

  QuizCategory? get category => _category;
  List<Question> get questions => _category?.questions ?? const [];
  int get currentIndex => _currentIndex;
  int get totalQuestions => questions.length;
  Question get currentQuestion => questions[_currentIndex];
  int? get selectedAnswer => _answers[_currentIndex];
  bool get isFirstQuestion => _currentIndex == 0;
  bool get isLastQuestion => _currentIndex == totalQuestions - 1;
  bool get isFinished => _isFinished;
  QuizResult? get lastResult => _lastResult;

  double get progress =>
      totalQuestions == 0 ? 0 : (_currentIndex + 1) / totalQuestions;
  bool canResume(String categoryName) {
    return _category?.name == categoryName &&
        !_isFinished &&
        (_currentIndex > 0 || _answers.isNotEmpty);
  }

  void startQuiz(String categoryName) {
    _category = QuizData.byName(categoryName);
    _currentIndex = 0;
    _answers.clear();
    _isFinished = false;
    notifyListeners();
  }

  void selectAnswer(int optionIndex) {
    _answers[_currentIndex] = optionIndex;
    notifyListeners();
  }

  void next() {
    if (_category == null || isLastQuestion) return;
    _currentIndex++;
    notifyListeners();
  }

  void previous() {
    if (_currentIndex == 0) return;
    _currentIndex--;
    notifyListeners();
  }

  QuizResult finish(String playerName) {
    final category = _category!;
    var correct = 0;
    for (var i = 0; i < category.questions.length; i++) {
      if (_answers[i] == category.questions[i].correctIndex) correct++;
    }
    final total = category.questions.length;
    final score = total == 0 ? 0 : (correct * 100 / total).round();

    _isFinished = true;
    _lastResult = QuizResult(
      playerName: playerName,
      category: category.name,
      score: score,
      correctCount: correct,
      questions: category.questions,
      answers: Map<int, int>.from(_answers),
    );
    notifyListeners();
    return _lastResult!;
  }
}
