import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/purchase/introduction.dart';
import 'package:booqs_mobile/components/purchase/introduction_footer.dart';
import 'package:booqs_mobile/components/purchase/subscription_button.dart';
import 'package:booqs_mobile/components/purchase/restore_button.dart';
import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:flutter/material.dart';

// プレミアムプランの紹介・課金ページ
class PremiumPlanPage extends StatefulWidget {
  const PremiumPlanPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(userPremiumPlanPage);
  }

  @override
  createState() => _PremiumPlanPageState();
}

class _PremiumPlanPageState extends State<PremiumPlanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('プレミアムプラン'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: ResponsiveValues.horizontalMargin(context)),
          color: Colors.transparent,
          child: Column(
            children: const <Widget>[
              SizedBox(
                height: 24,
              ),
              PurchaseIntroduction(),
              SizedBox(
                height: 48,
              ),
              PurchaseSubscriptionButton(),
              SizedBox(
                height: 24,
              ),
              PurchaseIntroductionFooter(),
              SizedBox(
                height: 32,
              ),
              PurchaseRestoreButton(),
              SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
