import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/weakness.dart';
import 'package:booqs_mobile/components/quiz/answer_part.dart';
import 'package:booqs_mobile/components/quiz/question_part.dart';
import 'package:booqs_mobile/components/quiz/unsolved_content.dart';
import 'package:booqs_mobile/components/quiz/unsolved_footer.dart';
import 'package:booqs_mobile/components/weakness/quiz_header.dart';
import 'package:flutter/material.dart';

class WeaknessUnsolvedQuizWrapper extends StatelessWidget {
  const WeaknessUnsolvedQuizWrapper({Key? key, required this.weakness})
      : super(key: key);
  final Weakness weakness;

  @override
  Widget build(BuildContext context) {
    final Quiz? quiz = weakness.quiz;

    if (quiz == null) {
      return Container(
          padding: const EdgeInsets.all(24),
          child: Text(
              'エラー: quiz-${weakness.quizId}は存在しません。 weakness-${weakness.id}'));
    }

    final Drill? drill = quiz.drill;
    if (drill == null) {
      return Container(
          padding: const EdgeInsets.all(24),
          child: Text(
              'エラー: drill-${quiz.drillId}が存在しません。weakness-${weakness.id}'));
    }

    final Review? review = quiz.review;

    final header = WeaknessQuizHeader(
      weakness: weakness,
    );
    final question = QuizQuestionPart(quiz: quiz, drill: drill);
    final answer = QuizAnswerPart(
      quiz: quiz,
      unsolved: true,
    );
    final footer = QuizUnsolvedFooter(quiz: quiz, review: review);

    // 解答時に問題をフェイドアウトする際にリビルドされてレイアウトが崩れるのを防ぐために、外部からwidgetを渡す
    // ref: https://qiita.com/chooyan_eng/items/ec11f6dcf714f7a2fa3d
    return QuizUnsolvedContent(
        quiz: quiz,
        header: header,
        question: question,
        answer: answer,
        footer: footer);
  }
}
