import 'package:flutter/material.dart';
import 'package:note_app/view/widgets/custom_button.dart';
import 'package:note_app/view/widgets/custom_text_form.dart';

import '../widgets/custom_login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: CustomForm(),
      ),
    );
  }
}
