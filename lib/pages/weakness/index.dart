import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/empty_app_bar.dart';
import 'package:booqs_mobile/widgets/weakness/introduction.dart';
import 'package:booqs_mobile/widgets/weakness/order_select_form.dart';
import 'package:booqs_mobile/widgets/weakness/quiz_list_view.dart';
import 'package:booqs_mobile/widgets/weakness/status_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeaknessIndexPage extends ConsumerStatefulWidget {
  const WeaknessIndexPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(weaknessIndexPage);
  }

  // 戻らせない画面遷移
  static Future pushReplacement(BuildContext context) async {
    return Navigator.of(context).pushReplacementNamed(weaknessIndexPage);
  }

  @override
  _WeaknessIndexPageState createState() => _WeaknessIndexPageState();
}

class _WeaknessIndexPageState extends ConsumerState<WeaknessIndexPage> {
  @override
  Widget build(BuildContext context) {
    final _body = Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        child: Column(
          children: const [
            SizedBox(height: 32),
            WeaknessIntroduction(),
            WeaknessOrderSelectForm(
              type: 'all',
            ),
            SizedBox(height: 32),
            WeaknessStatusTabs(
              selected: 'all',
            ),
            SizedBox(height: 8),
            WeaknessQuizListView(),
            SizedBox(height: 240),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: const EmptyAppBar(),
      body: _body,
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}