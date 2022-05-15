import 'package:booqs_mobile/data/remote/sentences.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/pages/sentence/show.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/dictionary/icon.dart';
import 'package:booqs_mobile/widgets/sentence/form.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceEditPage extends ConsumerStatefulWidget {
  const SentenceEditPage({Key? key}) : super(key: key);

  static Future push(BuildContext context, int sentenceId) async {
    return Navigator.of(context)
        .pushNamed(sentenceEditPage, arguments: {'sentenceId': sentenceId});
  }

  @override
  _SentenceEditPageState createState() => _SentenceEditPageState();
}

class _SentenceEditPageState extends ConsumerState<SentenceEditPage> {
  Sentence? _sentence;
  bool _isLoading = true;
  // validatorを利用するために必要なkey
  final _formKey = GlobalKey<FormState>();
  final _originalController = TextEditingController();
  final _translationController = TextEditingController();
  final _explanationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      final int sentenceId = arguments['sentenceId'];
      _loadSentence(sentenceId);
    });
  }

  Future _loadSentence(int sentenceId) async {
    final Map? resMap = await RemoteSentences.edit(sentenceId);
    _isLoading = false;
    if (resMap == null) {
      return setState(() => _isLoading);
    }
    final Sentence sentence = Sentence.fromJson(resMap['sentence']);
    setState(() {
      _sentence = sentence;
      _isLoading;
    });
  }

  @override
  // widgetの破棄時にコントローラも破棄する。Controllerを使うなら必ず必要。
  // 参考： https://api.flutter.dev/flutter/widgets/TextEditingController-class.html
  void dispose() {
    _originalController.dispose();
    _translationController.dispose();
    _explanationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future _save(sentence) async {
      // 各Fieldのvalidatorを呼び出す
      if (!_formKey.currentState!.validate()) return;

      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      Map<String, dynamic> params = {
        'id': sentence.id,
        'original': _originalController.text,
        'translation': _translationController.text,
        'explanation': _explanationController.text
      };
      final Map? resMap = await RemoteSentences.update(params);

      if (resMap == null) {
        EasyLoading.dismiss();
        const snackBar = SnackBar(content: Text('辞書を更新できませんでした。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final sentence = Sentence.fromJson(resMap['sentence']);
        final snackBar = SnackBar(content: Text('${resMap['message']}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        SentenceShowPage.pushReplacement(context, sentence.id);
      }
      EasyLoading.dismiss();
    }

    // 更新ボタン
    Widget _submitButton() {
      return SizedBox(
        height: 48,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity,
                40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
          ),
          onPressed: () => {
            _save(_sentence),
          },
          icon: const Icon(Icons.update, color: Colors.white),
          label: const Text(
            '更新する',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      );
    }

    Widget _body(Sentence? sentence) {
      if (_isLoading) return const LoadingSpinner();
      if (sentence == null) return const Text('Sentence does not exists.');
      final Dictionary? dictionary = sentence.dictionary;
      if (dictionary == null) return const Text('Dictionary does not exists.');
      _originalController.text = sentence.original;
      _translationController.text = sentence.translation;
      _explanationController.text = sentence.explanation ?? '';

      return SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(20),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      DictionaryIcon(dictionary: dictionary),
                      SentenceForm(
                          originalController: _originalController,
                          translationController: _translationController,
                          explanationController: _explanationController),
                      const SizedBox(height: 40),
                      _submitButton(),
                      const SizedBox(height: 40),
                    ]))),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('例文の編集'),
      ),
      body: _body(_sentence),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}