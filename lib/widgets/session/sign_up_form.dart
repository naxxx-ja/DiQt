import 'dart:convert';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/services/device_info.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:booqs_mobile/widgets/session/form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    _nameController.dispose();
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  // Note: Remember to dispose of the TextEditingController when it’s no longer needed. This ensures that you discard any resources used by the object.
  // ref: https://docs.flutter.dev/cookbook/forms/text-field-changes

  @override
  Widget build(BuildContext context) {
    // 送信
    Future _submit() async {
      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      if (!_formKey.currentState!.validate()) {
        // ローディングを消去
        EasyLoading.dismiss();
        return;
      }

      // デバイスの識別IDなどを取得する
      final deviceInfo = DeviceInfoService();
      String platform = deviceInfo.getPlatform();
      String deviceIdentifier = await deviceInfo.getIndentifier();
      String deviceName = await deviceInfo.getName();
      // リクエスト
      var url = Uri.parse(
          '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/users');
      var res = await http.post(url, body: {
        'name': _nameController.text,
        'email': _idController.text,
        'password': _passwordController.text,
        'device_identifier': deviceIdentifier,
        'device_name': deviceName,
        'platform': platform,
      });
      // レスポンスに対する処理
      if (res.statusCode == 200) {
        Map resMap = json.decode(res.body);
        User user = User.fromJson(resMap['user']);
        await UserSetup.signIn(user);
        final snackBar = SnackBar(content: Text('${resMap['message']}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        UserMyPage.push(context);
      } else {
        _passwordController.text = '';
        const snackBar = SnackBar(
            content: Text('登録できませんでした。指定メールアドレスのユーザーはすでに存在しているか、パスワードが短すぎます。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      EasyLoading.dismiss();
    }

    Widget _submitButton() {
      return InkWell(
        onTap: () {
          _submit();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: const Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xfffbb448), Color(0xfff7892b)])),
          child: const Text(
            '登録する',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SessionFormField(
              label: "ユーザー名", controller: _nameController, isPassword: false),
          SessionFormField(
              label: "メールアドレス", controller: _idController, isPassword: false),
          SessionFormField(
              label: "パスワード（６文字以上）",
              controller: _passwordController,
              isPassword: true),
          const SizedBox(height: 20),
          _submitButton(),
        ],
      ),
    );
  }
}