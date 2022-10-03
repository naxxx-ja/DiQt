import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/widgets/shared/text_with_dict_link.dart';
import 'package:booqs_mobile/widgets/word/item/label.dart';
import 'package:booqs_mobile/widgets/word/item/small_translation_buttons.dart';
import 'package:flutter/material.dart';

class WordItemMeaning extends StatelessWidget {
  const WordItemMeaning({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    Widget _meaningText() {
      // 英英辞書なら全文辞書リンク
      if (word.langNumberOfEntry == word.langNumberOfMeaning &&
          word.langNumberOfMeaning == languageCodeMap['en']) {
        return TextWithDictLink(
          text: word.meaning,
          langNumber: word.langNumberOfMeaning,
          autoLinkEnabled: true,
          crossAxisAlignment: CrossAxisAlignment.start,
          dictionaryId: word.dictionaryId,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontColor: Colors.black87,
          selectable: true,
        );
      }
      return Text(
        word.meaning,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      );
    }

    Widget _meaning() {
      final String? pos = word.pos;
      if (pos == null || pos == '') {
        return _meaningText();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WordItemLabel(
            text: pos,
          ),
          _meaningText(),
          WordItemSmallTranslationButtons(
            original: word.meaning,
            word: word,
          ),
        ],
      );
    }

    return SizedBox(
      width: double.infinity,
      child: _meaning(),
    );
  }
}