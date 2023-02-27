import 'package:booqs_mobile/components/word/list_item.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';

class QuizExplanationWord extends StatelessWidget {
  const QuizExplanationWord({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    final Word? word = quiz.word;

    if (word != null) {
      return WordListItem(
        word: word,
      );
    }
    return Container();
  }
}