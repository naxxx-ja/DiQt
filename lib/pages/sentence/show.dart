import 'package:booqs_mobile/data/provider/sentence.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/dictionary/name.dart';
import 'package:booqs_mobile/components/drill/list_quiz.dart';
import 'package:booqs_mobile/components/sentence/list_item.dart';
import 'package:booqs_mobile/components/sentence/sentence_requests_button.dart';
import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceShowPage extends ConsumerStatefulWidget {
  const SentenceShowPage({Key? key}) : super(key: key);

  static Future push(BuildContext context, int sentenceId) async {
    return Navigator.of(context)
        .pushNamed(sentenceShowPage, arguments: {'sentenceId': sentenceId});
  }

  static Future pushReplacement(BuildContext context, int sentenceId) async {
    return Navigator.of(context).pushReplacementNamed(sentenceShowPage,
        arguments: {'sentenceId': sentenceId});
  }

  @override
  SentenceShowPageState createState() => SentenceShowPageState();
}

class SentenceShowPageState extends ConsumerState<SentenceShowPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      final int sentenceId = arguments['sentenceId'];
      ref.invalidate(asyncSentenceFamily(sentenceId));
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final int sentenceId = arguments['sentenceId'];
    final future = ref.watch(asyncSentenceFamily(sentenceId));

    Widget quiz(Sentence sentence) {
      final Quiz? quiz = sentence.quiz;
      if (quiz == null) return Container();
      return DrillListQuiz(
        quiz: quiz,
        isShow: false,
      );
    }

    Widget speakingQuiz(Sentence sentence) {
      final Quiz? quiz = sentence.speakingQuiz;
      if (quiz == null) return Container();
      return DrillListQuiz(
        quiz: quiz,
        isShow: false,
      );
    }

    Widget body(Sentence? sentence) {
      if (sentence == null) return const Text('Sentence does not exist.');

      final Dictionary? dictionary = sentence.dictionary;
      if (dictionary == null) return const Text('Dictionary does not exist.');
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          DictionaryName(dictionary: dictionary),
          const SizedBox(height: 24),
          SentenceListItem(
            sentence: sentence,
            isShow: true,
          ),
          SentenceSentenceRequestsButton(sentence: sentence),
          const SizedBox(height: 24),
          const Divider(
            thickness: 1,
          ),
          const SizedBox(height: 16),
          quiz(sentence),
          speakingQuiz(sentence),
          const SizedBox(height: 48),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('例文'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: 24,
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: future.when(
            loading: () => const LoadingSpinner(),
            error: (err, stack) => Text('Error: $err'),
            data: (sentence) => body(sentence),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
