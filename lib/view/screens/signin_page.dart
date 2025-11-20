import 'package:flutter/material.dart';
import 'package:note_app/view/widgets/custom_button.dart';
import 'package:note_app/view/widgets/custom_signin_form.dart';
import 'package:note_app/view/widgets/custom_text_form.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: CustomSigninForm(),
      ),
    );
  }
}
