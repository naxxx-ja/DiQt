import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/pages/dictionary/show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryName extends ConsumerWidget {
  const DictionaryName({Key? key, required this.dictionary}) : super(key: key);
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton.icon(
      onPressed: () {
        DictionaryShowPage.push(context, dictionary.id);
      },
      icon: const Icon(
        Icons.book,
        size: 16,
        color: Colors.black54,
      ),
      label: Text(dictionary.title,
          style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.normal)),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.only(left: 0),
      ),
    );
  }
}