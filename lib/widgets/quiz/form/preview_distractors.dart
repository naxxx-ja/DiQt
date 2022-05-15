import 'package:booqs_mobile/widgets/shared/item_label.dart';
import 'package:flutter/material.dart';

class QuizFormPreviewDistractors extends StatelessWidget {
  const QuizFormPreviewDistractors({Key? key, required this.distractors})
      : super(key: key);
  final String distractors;

  @override
  Widget build(BuildContext context) {
    if (distractors == '') {
      return Container();
    }

    Widget _distractor(String distractor) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: const Icon(Icons.close, color: Colors.red, size: 24),
          ),
          // Expandedを使うと短い文章でも幅全体を埋めてしまい、結果的に左寄せになってしまうので Flexible を使う。
          Flexible(
            child: Text(distractor,
                style: const TextStyle(fontSize: 16, color: Colors.red)),
          ),
        ],
      );
    }

    // 選択肢（distracorsWidget）を作成する
    final List<String> answerTextList = distractors.split('\n');
    List<Widget> widgetList = [];
    answerTextList.asMap().forEach((int i, String value) {
      // 空文字の改行は選択肢にしない
      if (value == '') return;
      widgetList.add(
        Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: _distractor(value)),
      );
    });
    final Widget distracorsWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgetList,
    );

    return Column(children: <Widget>[
      const SharedItemLabel(text: '誤りの選択肢'),
      const SizedBox(
        height: 16,
      ),
      distracorsWidget,
      const SizedBox(
        height: 24,
      ),
    ]);
  }
}