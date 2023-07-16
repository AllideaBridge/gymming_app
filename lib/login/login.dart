import 'package:flutter/material.dart';
import 'package:gymming_app/login/component/google_login_button.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Social Login"),
        ),
        body: const Column(
            children: [GoogleLoginButton()]
        )
    );
  }
}