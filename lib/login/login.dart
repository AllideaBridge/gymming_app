import 'package:flutter/material.dart';

import 'component/google_login_button.dart';
import 'component/kakao_login_button.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Social Login"),
      ),
      body: Center(
          child: Column(children: [
        GoogleLoginButton(),
        KakaoLoginButton(),
      ])),
    );
  }
}
