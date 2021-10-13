import 'package:booqs_mobile/pages/home.dart';
import 'package:booqs_mobile/pages/notification/index.dart';
import 'package:booqs_mobile/pages/reminder/index.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/dictionary/bottom_navbar.dart';
import 'package:flutter/material.dart';

class UserMyPage extends StatefulWidget {
  const UserMyPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(userMyPage);
  }

  @override
  _UserMyPageState createState() => _UserMyPageState();
}

class _UserMyPageState extends State<UserMyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('マイページ'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[],
        ),
      ),
      bottomNavigationBar: const BottomNavbar(selectedIndex: 3),
    );
  }
}