import 'package:booqs_mobile/data/remote/dictionaries.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 検索用の辞書ID
final dictionaryIdProvider = StateProvider<int>((ref) => 1);
// 非同期で辞書一覧を取得する
final asyncDictionariesProvider =
    FutureProvider<List<Dictionary>?>((ref) async {
  final Map? resMap = await RemoteDictionaries.index();
  if (resMap == null) return null;
  List<Dictionary> dictionaries = [];
  resMap['dictionaries']
      .forEach((e) => dictionaries.add(Dictionary.fromJson(e)));

  return dictionaries;
});

//
final dictionaryProvider = StateProvider<Dictionary?>((ref) => null);
final secondDictionaryProvider = StateProvider<Dictionary?>((ref) => null);

// 非同期で引数の辞書を取得する
// ref: https://riverpod.dev/ja/docs/concepts/modifiers/family
// 【重要】 オブジェクトが一定ではない場合は autoDispose 修飾子との併用が望ましい
// family を使って検索フィールドの入力値をプロバイダに渡す場合、その入力値は頻繁に変わる上に同じ値が再利用されることはありません。
// おまけにプロバイダは参照されなくなっても破棄されないのがデフォルトの動作であるため、この場合はメモリリークにつながります。
final asyncDictionaryFamily = FutureProvider.autoDispose
    .family<Dictionary?, int>((ref, dictionaryId) async {
  final Map? resMap = await RemoteDictionaries.show(dictionaryId);
  if (resMap == null) return null;
  final Dictionary dictionary = Dictionary.fromJson(resMap['dictionary']);
  return dictionary;
});
