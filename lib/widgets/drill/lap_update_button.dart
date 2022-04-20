import 'package:booqs_mobile/data/provider/drill_lap.dart';
import 'package:booqs_mobile/models/drill_lap.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/widgets/button/large_button.dart';
import 'package:booqs_mobile/widgets/drill/lap_update_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrillLapUpdateButton extends ConsumerWidget {
  const DrillLapUpdateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DrillLap? drillLap = ref.watch(drillLapProvider);
    final int newLapNumber = drillLap!.numberOfLaps! + 1;

    Widget _lapInfo() {
      return Text(
        '${drillLap.numberOfLaps}周クリアしました',
        style: const TextStyle(
            fontSize: 32, color: Colors.black54, fontWeight: FontWeight.bold),
      );
    }

    return Column(children: [
      const SizedBox(height: 32),
      _lapInfo(),
      const SizedBox(height: 32),
      InkWell(
        onTap: () {
          const screen = DrillLapUpdateScreen();
          Dialogs.slideFromBottomFade(screen);
        },
        child: LargeButton(btnText: '$newLapNumber周目を始める'),
      ),
    ]);
  }
}
