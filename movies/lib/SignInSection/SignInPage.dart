import 'dart:ui';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:movies/Colors/Colors.dart';
import 'package:movies/SignUpSection/SignUpPage.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // late TextEditingController _mailController;

  @override
  void initState() {
    super.initState();
    // _mailController = TextEditingController();
  }

  @override
  void dispose() {
    // _mailController.dispose();
    super.dispose();
  }

  _backToPreviousPage() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            const FittedBox(
                child: Image(
                    image: AssetImage(
                        "assets/images/avatar_signin_background.jpg")),
                fit: BoxFit.fitWidth),
            Column(
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(top: 30, left: 20),
                    child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.white, size: 30),
                        onPressed: _backToPreviousPage)),
                const Padding(padding: EdgeInsets.only(top: 200)),
                Container(
                    child: const Text('Hi',
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.w500)),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 30)),
                const Padding(padding: EdgeInsets.only(top: 20)),
                Expanded(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: BackdropFilter(
                            filter:
                                ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      Colors.grey.shade200.withOpacity(0.35)),
                              child: const Center(child: SignInForm()),
                            ))))
              ],
            )
          ],
          fit: StackFit.expand,
        ));
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool isMailEntered = false;

  final ButtonStyle _continueStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      minimumSize: const Size(350, 50),
      maximumSize: const Size(350, 50),
      primary: ColorSelect.customBlue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ));

  final ButtonStyle _continueLogInStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20, color: ColorSelect.customBlue),
      minimumSize: const Size(350, 50),
      maximumSize: const Size(350, 50),
      primary: Colors.white70,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ));

  final TextStyle linkStyle =
      const TextStyle(fontSize: 16, color: ColorSelect.customYellow);

  _validateMail() {
    // Validate mail if there's a mail correct in sharedPreferences, open password field,
    // else open two textfields one with password and another with name and surname
  }

  openSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
        child: Column(children: [
          TextField(
            style: const TextStyle(
              color: Colors.black87,
              fontFamily: 'Montserrat',
              fontSize: 18,
            ),
            keyboardType: TextInputType.emailAddress,
            // controller: _mailController
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: ColorSelect.customBlue, width: 3.0)),
                contentPadding: const EdgeInsets.only(
                    left: 10, top: 5, right: 10, bottom: 5),
                hintText: "Email",
                hintStyle: const TextStyle(color: Colors.black54, fontSize: 18),
                filled: true,
                fillColor: Colors.white),
          ),
          const Padding(padding: EdgeInsets.only(top: 15)),
          ElevatedButton(
              style: _continueStyle,
              onPressed: _validateMail,
              child: const Text("Continue")),
          const Padding(padding: EdgeInsets.only(top: 10)),
          const Text(
            "or",
            style: TextStyle(fontSize: 18),
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          ElevatedButton.icon(
              icon: const Icon(
                Icons.facebook,
                size: 30,
              ),
              style: _continueLogInStyle,
              onPressed: _validateMail,
              label: const Text("Continue with Facebook",
                  style: TextStyle(color: ColorSelect.customBlue))),
          const Padding(padding: EdgeInsets.only(top: 10)),
          ElevatedButton.icon(
              icon: const Image(
                  image: AssetImage("assets/images/google_logo.png"),
                  width: 30,
                  height: 30),
              style: _continueLogInStyle,
              onPressed: _validateMail,
              label: const Text("Continue with Google",
                  style: TextStyle(color: ColorSelect.customBlue))),
          const Padding(padding: EdgeInsets.only(top: 10)),
          ElevatedButton.icon(
              icon: const Image(
                  image: AssetImage("assets/images/apple_icon.png"),
                  width: 30,
                  height: 30),
              style: _continueLogInStyle,
              onPressed: _validateMail,
              label: const Text("Continue with Apple",
                  style: TextStyle(color: ColorSelect.customBlue))),
          const Padding(padding: EdgeInsets.only(top: 10)),
          RichText(
              text: TextSpan(children: <TextSpan>[
            const TextSpan(text: "Don't have an account? "),
            TextSpan(
                text: "Sign up",
                style: linkStyle,
                recognizer: TapGestureRecognizer()..onTap = openSignUp)
          ])),
          const Padding(padding: EdgeInsets.only(top: 10)),
          RichText(
              text: TextSpan(children: <TextSpan>[
            TextSpan(
                text: "Forgot your password?",
                style: linkStyle,
                recognizer: TapGestureRecognizer()..onTap = openSignUp)
          ]))
        ]));
  }
}
