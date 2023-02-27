import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/notifications/loading_unsolved_quizzes.dart';
import 'package:booqs_mobile/components/drill/introduction.dart';
import 'package:booqs_mobile/components/drill/order_select_form.dart';
import 'package:booqs_mobile/components/drill/status_tabs.dart';
import 'package:booqs_mobile/components/drill/unsolved_quizzes.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/components/user/drill_in_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrillUnsolvedScreen extends ConsumerStatefulWidget {
  const DrillUnsolvedScreen({Key? key}) : super(key: key);

  @override
  DrillUnsolvedScreenState createState() => DrillUnsolvedScreenState();
}

class DrillUnsolvedScreenState extends ConsumerState<DrillUnsolvedScreen> {
  @override
  void initState() {
    super.initState();
    // futureは結果をキャッシュするので、画面の読み込みのたびにrefreshして再度読み込みを行う。
    ref.refresh(asyncDrillUnsolvedQuizzesProvider);
  }

  @override
  Widget build(BuildContext context) {
    final future = ref.watch(asyncDrillUnsolvedQuizzesProvider);

    Widget unsolvedQuizzes() {
      return future.when(
        data: (data) => DrillUnsolvedQuizzes(quizzes: data),
        error: (err, stack) => Text('Error: $err'),
        loading: () => const LoadingSpinner(),
      );
    }

    return NotificationListener<LoadingUnsolvedQuizzesNotification>(
      onNotification: (notification) {
        // 次の問題が読み込まれるかの判断は、QuizUnsolvedContent で行い、通知している。
        // すべてのWeidgetの描画が終わるまで待たないと、初回から実行されてしまう。
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.refresh(asyncDrillUnsolvedQuizzesProvider);
        });
        // trueを返すことで通知がこれ以上遡らない
        return true;
      },
      child: Column(
        children: [
          const SizedBox(height: 32),
          const DrillIntroduction(),
          const DrillOrderSelectForm(type: 'unsolved'),
          const SizedBox(height: 40),
          const DrillStatusTabs(
            selected: 'unsolved',
          ),
          const SizedBox(height: 32),
          unsolvedQuizzes(),
          const SizedBox(height: 80),
          const UserDrillInProgress(),
        ],
      ),
    );
  }
}