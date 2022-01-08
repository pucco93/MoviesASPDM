import 'dart:ui';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:movies/Colors/Colors.dart';
import 'package:movies/EasterEggs/TermsPolicy.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                    child: const Text('Sign up',
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
                              child: const Center(child: SignUpForm()),
                            ))))
              ],
            )
          ],
          fit: StackFit.expand,
        ));
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool isMailEntered = false;

  final ButtonStyle _continueStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      minimumSize: const Size(350, 50),
      maximumSize: const Size(350, 50),
      primary: ColorSelect.customBlue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ));

  final TextStyle linkStyle =
      const TextStyle(fontSize: 14, color: ColorSelect.customYellow);
  final TextStyle textStyle = const TextStyle(fontSize: 14);

  _validateMail() {
    // Validate mail if there's a mail correct in sharedPreferences, open password field,
    // else open two textfields one with password and another with name and surname
  }

  _openFakePolicy() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const TermsPolicy()));
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
              fontSize: 18,
            ),
            keyboardType: TextInputType.emailAddress,
            // controller: _mailController
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        color: ColorSelect.customBlue, width: 3.0)),
                contentPadding: const EdgeInsets.only(
                    left: 10, top: 5, right: 10, bottom: 5),
                hintText: "Email",
                hintStyle: const TextStyle(color: Colors.black54, fontSize: 18),
                filled: true,
                fillColor: Colors.white),
          ),
          const Padding(padding: EdgeInsets.only(top: 15)),
          TextField(
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 18,
            ),
            keyboardType: TextInputType.text,
            // controller: _mailController
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        color: ColorSelect.customBlue, width: 3.0)),
                contentPadding: const EdgeInsets.only(
                    left: 10, top: 5, right: 10, bottom: 5),
                hintText: "Name",
                hintStyle: const TextStyle(color: Colors.black54, fontSize: 18),
                filled: true,
                fillColor: Colors.white),
          ),
          const Padding(padding: EdgeInsets.only(top: 15)),
          TextField(
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 18,
            ),
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            // controller: _mailController
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        color: ColorSelect.customBlue, width: 3.0)),
                contentPadding: const EdgeInsets.only(
                    left: 10, top: 5, right: 10, bottom: 5),
                hintText: "Password",
                hintStyle: const TextStyle(color: Colors.black54, fontSize: 18),
                filled: true,
                fillColor: Colors.white),
          ),
          const Padding(padding: EdgeInsets.only(top: 15)),
          RichText(
              text: TextSpan(children: <TextSpan>[
            TextSpan(
                text: 'By selecting "Agree and continue" below,\n I agree to ',
                style: textStyle),
            TextSpan(
                text: "Terms of Service and Privacy Policy",
                style: linkStyle,
                recognizer: TapGestureRecognizer()..onTap = _openFakePolicy)
          ])),
          const Padding(padding: EdgeInsets.only(top: 15)),
          ElevatedButton(
              style: _continueStyle,
              onPressed: _validateMail,
              child: const Text("Agreee and continue")),
          const Padding(padding: EdgeInsets.only(top: 20)),
        ]));
  }
}
