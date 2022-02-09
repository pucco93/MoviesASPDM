import 'dart:ui';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movies/colors/colors_theme.dart';
import 'package:movies/easter_eggs/terms_policy.dart';
import 'package:movies/home_section/homepage.dart';
import 'package:movies/models/interfaces/user.dart';
import 'package:movies/utilities/utilities.dart';
import 'package:movies/welcome_section/sign_in_section/sign_in_page.dart';
import 'package:movies/models/providers/provider_account.dart';
import 'package:movies/models/type_adapters/logged_user.dart';
import 'package:provider/provider.dart';

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
                Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).orientation == Orientation.landscape ? 0 : 200)),
                Container(
                    child: const Text('Sign up',
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.w500, color: Colors.white)),
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
  bool _isSignUp = false;
  bool _passwordIncorrect = false;
  final _mailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

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

  _signIn() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignInPage()),
    );
  }

  _redirectToHome() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  _signUp(ProviderAccount accountProvider) {
    setState(() {
      _passwordIncorrect = false;
    });
    if (_passwordController.text == _repeatPasswordController.text) {
      final Box<LoggedUser> _userBox = Hive.box<LoggedUser>("userBox");
      LoggedUser user = LoggedUser(0, _nameController.text,
          _mailController.text, _passwordController.text, "", true);
      _userBox.put("loggedUser", user);
      User account = User(_nameController.text, _mailController.text,
          _passwordController.text, "");
      accountProvider.updateLogStatus(true);
      accountProvider.updateUser(account);
      _redirectToHome();
    } else {
      setState(() {
        _passwordIncorrect = true;
      });
    }
  }

  _validateMail(ProviderAccount accountProvider) {
    final Box<LoggedUser> _userBox = Hive.box<LoggedUser>("userBox");
    if (_userBox.get("loggedUser") != null) {
      LoggedUser tempUser = Utilities.mapLoggedUser(_userBox.get("loggedUser"));
      if (tempUser.email == _mailController.text) {
        setState(() {
          _isSignUp = true;
        });
      } else {
        _signUp(accountProvider);
      }
    } else {
      _signUp(accountProvider);
    }
  }

  _openFakePolicy() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const TermsPolicy()));
  }

  @override
  void dispose() {
    setState(() {
      _passwordIncorrect = true;
    });
    // final Box<LoggedUser> _userBox = Hive.box<LoggedUser>("userBox");
    // _userBox.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderAccount>(
        builder: (context, accountProvider, child) {
      return SingleChildScrollView(child: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
          child: Column(children: [
            TextField(
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 18,
              ),
              keyboardType: TextInputType.emailAddress,
              controller: _mailController,
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
                  hintStyle:
                      const TextStyle(color: Colors.black54, fontSize: 18),
                  filled: true,
                  fillColor: Colors.white),
            ),
            const Padding(padding: EdgeInsets.only(top: 15)),
            Visibility(
                visible: !_isSignUp,
                child: TextField(
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                  ),
                  keyboardType: TextInputType.text,
                  controller: _nameController,
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
                      hintStyle:
                          const TextStyle(color: Colors.black54, fontSize: 18),
                      filled: true,
                      fillColor: Colors.white),
                )),
            Visibility(
                visible: !_isSignUp,
                child: const Padding(padding: EdgeInsets.only(top: 15))),
            Visibility(
                visible: !_isSignUp,
                child: TextField(
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  controller: _passwordController,
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
                      hintStyle:
                          const TextStyle(color: Colors.black54, fontSize: 18),
                      filled: true,
                      fillColor: Colors.white),
                )),
            Visibility(
                visible: !_isSignUp,
                child: const Padding(padding: EdgeInsets.only(top: 15))),
            Visibility(
                visible: !_isSignUp,
                child: TextField(
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  controller: _repeatPasswordController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: ColorSelect.customBlue, width: 3.0)),
                      contentPadding: const EdgeInsets.only(
                          left: 10, top: 5, right: 10, bottom: 5),
                      hintText: "Repeat password",
                      hintStyle:
                          const TextStyle(color: Colors.black54, fontSize: 18),
                      filled: true,
                      fillColor: Colors.white),
                )),
            Visibility(
                visible: !_isSignUp,
                child: const Padding(padding: EdgeInsets.only(top: 15))),
            Visibility(
                visible: !_isSignUp,
                child: RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text:
                          'By selecting "Agree and continue" below,\n I agree to ',
                      style: textStyle),
                  TextSpan(
                      text: "Terms of Service and Privacy Policy",
                      style: linkStyle,
                      recognizer: TapGestureRecognizer()
                        ..onTap = _openFakePolicy)
                ]))),
            Visibility(
                visible: !_isSignUp,
                child: const Padding(padding: EdgeInsets.only(top: 15))),
            Visibility(
                visible: !_isSignUp,
                child: ElevatedButton(
                    style: _continueStyle,
                    onPressed: () => _validateMail(accountProvider),
                    child: const Text("Agreee and continue"))),
            Visibility(
                visible: !_isSignUp,
                child: const Padding(padding: EdgeInsets.only(top: 20))),
            Visibility(
                visible: _isSignUp,
                child: Column(children: [
                  const Text(
                      "Looks like you've already signed up in the past, please try to sign in.",
                      style: TextStyle(fontSize: 16)),
                  const Padding(padding: EdgeInsets.only(top: 15)),
                  ElevatedButton(
                      style: _continueStyle,
                      onPressed: _signIn,
                      child: const Text("Sign in")),
                  const Padding(padding: EdgeInsets.only(top: 20))
                ])),
            Visibility(
                child: const Text(
                    "Passwords are not matching, please try writing them again."),
                visible: _passwordIncorrect),
          ])));
    });
  }
}
