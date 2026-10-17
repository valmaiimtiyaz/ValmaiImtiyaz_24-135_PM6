import 'package:flutter_test/flutter_test.dart';

import 'package:asah_asik/core/providers/quiz_provider.dart';
import 'package:asah_asik/core/providers/user_provider.dart';
import 'package:asah_asik/main.dart';

void main() {
  testWidgets('Aplikasi membuka halaman masuk', (WidgetTester tester) async {
    await tester.pumpWidget(const AsahAsikApp());
    await tester.pumpAndSettle();

    expect(find.textContaining('Selamat Datang'), findsOneWidget);
    expect(find.text('Masuk'), findsOneWidget);
  });

  group('QuizProvider', () {
    test('skor 100 jika semua jawaban benar', () {
      final quiz = QuizProvider()..startQuiz('Tebak Pola');
      for (var i = 0; i < quiz.totalQuestions; i++) {
        quiz.selectAnswer(quiz.currentQuestion.correctIndex);
        quiz.next();
      }
      final result = quiz.finish('Mai');

      expect(result.score, 100);
      expect(result.correctCount, quiz.totalQuestions);
      expect(result.playerName, 'Mai');
    });

    test('progres tersimpan dan bisa dilanjutkan', () {
      final quiz = QuizProvider()..startQuiz('Tebak Pola');
      quiz.selectAnswer(0);
      quiz.next();

      expect(quiz.canResume('Tebak Pola'), isTrue);
      expect(quiz.canResume('Logika & Analisis'), isFalse);
      expect(quiz.currentIndex, 1);
    });

    test('soal tanpa jawaban dihitung salah', () {
      final quiz = QuizProvider()..startQuiz('Tebak Pola');
      final result = quiz.finish('Mai');

      expect(result.score, 0);
    });
  });

  group('UserProvider', () {
    test('mengulang kuis tidak menggelembungkan total skor', () {
      final user = UserProvider();
      user.recordResult('Tebak Pola', 60);
      user.recordResult('Tebak Pola', 80);
      user.recordResult('Tebak Pola', 40);

      expect(user.totalScore, 80);
      expect(user.completedQuizzes, 3);
    });
  });
}
