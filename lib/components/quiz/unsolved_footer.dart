import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/components/quiz/skip_button.dart';
import 'package:booqs_mobile/components/review/setting/small_buttton.dart';
import 'package:flutter/material.dart';

class QuizUnsolvedFooter extends StatelessWidget {
  const QuizUnsolvedFooter({Key? key, required this.quiz, this.review})
      : super(key: key);
  final Quiz quiz;
  final Review? review;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ReviewSettingSmallButton(quiz: quiz, review: review),
        QuizSkipButton(quiz: quiz),
      ],
    );
  }
}
