import 'package:booqs_mobile/data/provider/weakness.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeaknessOrderSelectForm extends ConsumerWidget {
  const WeaknessOrderSelectForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 値
    String _value() {
      final sort = ref.watch(weaknessSortProvider);
      final order = ref.watch(weaknessOrderProvider);
      return '$sort-$order';
    }

    // 値に対応するフォームのラベル
    String _label(String value) {
      switch (value) {
        case 'correct_answer_rate-asc':
          return '正答率が低い順';
        case 'correct_answer_rate-desc':
          return '正答率が高い順';
        case 'incorrect_answers_count-desc':
          return '不正解が多い順';
        case 'incorrect_answers_count-asc':
          return '不正解が少ない順';
        case 'created_at-desc':
          return '追加日が新しい順';
        case 'created_at-asc':
          return '追加日が古い順';
        case 'random-random':
          return 'ランダム';
        default:
          return 'Error';
      }
    }

    // 値をProviderにセットして表示する問題を更新する
    void _set(String? newValue) {
      if (newValue == null) return;
      final List list = newValue.split('-');
      ref.read(weaknessSortProvider.notifier).state = list[0];
      ref.read(weaknessOrderProvider.notifier).state = list[1];
      ref.refresh(asyncUnsolvedWeaknessesProvider);
    }

    // ドロップダウンボタンの生成
    Widget _buildDropDown() {
      return Container(
        margin: const EdgeInsets.only(top: 24),
        height: 48,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 15.0, right: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.black87)),
        child: DropdownButton<String>(
          value: _value(),
          iconSize: 24,
          elevation: 16,
          onChanged: (String? newValue) {
            _set(newValue);
          },
          items: <String>[
            'correct_answer_rate-asc',
            'correct_answer_rate-desc',
            'incorrect_answers_count-desc',
            'incorrect_answers_count-asc',
            'created_at-desc',
            'created_at-asc',
            'random-random',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(_label(value),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87)),
            );
          }).toList(),
        ),
      );
    }

    return _buildDropDown();
  }
}
