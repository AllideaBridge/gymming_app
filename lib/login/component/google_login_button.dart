import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({super.key});

  void googleLogin() async{
    final GoogleSignIn googleSignIn = GoogleSignIn();

    GoogleSignInAccount? user = await googleSignIn.signIn();
    if (user != null) {
      print(user);
    } else {
      print ('false');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Google Social Login"),
        ),
        body: Center(
            child: ElevatedButton(
              onPressed: googleLogin,
              child: const Text("Google 아이디로 간편 로그인"),
            )
        )
    );
  }
}