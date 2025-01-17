import 'package:booqs_mobile/components/review/answer_setting_button.dart';
import 'package:booqs_mobile/components/review/heading.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/review/bulk_deletion_button.dart';
import 'package:booqs_mobile/components/review/order_select_form.dart';
import 'package:booqs_mobile/components/review/quiz_list_view.dart';
import 'package:booqs_mobile/components/review/status_tabs.dart';
import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/drawer_menu.dart';
import 'package:booqs_mobile/components/shared/empty_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewAllPage extends ConsumerStatefulWidget {
  const ReviewAllPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(reviewAllPage);
  }

  static Future pushReplacement(BuildContext context) async {
    return Navigator.of(context).pushReplacementNamed(reviewAllPage);
  }

  @override
  ReviewAllPageState createState() => ReviewAllPageState();
}

class ReviewAllPageState extends ConsumerState<ReviewAllPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EmptyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 32),
              ReviewHeading(),
              ReviewOrderSelectForm(type: 'all'),
              SizedBox(height: 24),
              ReviewAnswerSettingButton(),
              SizedBox(height: 48),
              ReviewStatusTabs(
                selected: 'all',
              ),
              SizedBox(height: 40),
              ReviewBulkDeletionButton(),
              SizedBox(height: 40),
              ReviewQuizListView(),
              SizedBox(height: 120),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
      drawer: const DrawerMenu(),
    );
  }
}
