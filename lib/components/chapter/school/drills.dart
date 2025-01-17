import 'package:booqs_mobile/data/provider/chapter.dart';
import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/components/chapter/introduction.dart';
import 'package:booqs_mobile/components/drill/feed.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChapterSchoolDrills extends ConsumerStatefulWidget {
  const ChapterSchoolDrills({Key? key}) : super(key: key);

  @override
  ChapterSchoolDrillsState createState() => ChapterSchoolDrillsState();
}

class ChapterSchoolDrillsState extends ConsumerState<ChapterSchoolDrills> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(asynSchoolDrillsProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Chapter? school = ref.watch(schoolProvider);
    final future = ref.watch(asynSchoolDrillsProvider);

    //
    Widget buildCards() {
      return future.when(
          loading: () => const LoadingSpinner(),
          error: (err, stack) => Text('Error: $err'),
          data: (drills) => DrillFeed(drills: drills!));
    }

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 16,
            ),
            ChapterIntroduction(chapter: school!),
            const SizedBox(
              height: 40,
            ),
            buildCards(),
          ],
        ),
      ),
    );
  }
}
