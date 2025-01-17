import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/drill_lap.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/drill/unsolved.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DrillCard extends ConsumerWidget {
  const DrillCard({Key? key, required this.drill}) : super(key: key);
  final Drill drill;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1,000のようなdelimiterを使って解答数を整形する。参考： https://stackoverflow.com/questions/62580280/how-to-format-numbers-as-thousands-separators-in-dart
    final formatter = NumberFormat('#,###,000');
    final answerHistoriesCount = formatter.format(drill.answerHistoriesCount);
    final DrillLap? drillLap = drill.drillLap;

    // Drillページに遷移
    void moveToDrillPage(drill) {
      final User? user = ref.watch(currentUserProvider);
      if (user == null) {
        const snackBar = SnackBar(content: Text('問題を解くにはログインが必要です。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        UserMyPage.push(context);
      } else {
        ref.read(drillProvider.notifier).state = drill;
        DrillUnsolvedPage.push(context);
      }
    }

    Widget subtitle() {
      if (drillLap == null) {
        return Text(
          '$answerHistoriesCount解答',
          style: TextStyle(color: Colors.black.withOpacity(0.6)),
        );
      }
      return Text(
        '$answerHistoriesCount解答 / ${drillLap.clearsCount}周クリア',
        style: TextStyle(color: Colors.black.withOpacity(0.6)),
      );
    }

    // カードデザインの参考： https://material.io/components/cards/flutter
    return Card(
      margin: const EdgeInsets.only(bottom: 24),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        splashColor: Colors.green.withAlpha(30),
        onTap: () {
          moveToDrillPage(drill);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Container(
                padding: const EdgeInsets.only(top: 8),
                child: Text(drill.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              subtitle: subtitle(),
            ),
            CachedNetworkImage(
              imageUrl: drill.thumbnailUrl,
              placeholder: (context, url) => Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 16.0, left: 16, top: 16, bottom: 32),
              child: Text(
                drill.introduction,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
