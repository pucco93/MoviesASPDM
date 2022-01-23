import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movies/Colors/Colors.dart';

class TermsPolicy extends StatefulWidget {
  const TermsPolicy({Key? key}) : super(key: key);

  @override
  State<TermsPolicy> createState() => _TermsPolicyState();
}

class _TermsPolicyState extends State<TermsPolicy> {

  _backToPreviousPage() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

  const TextStyle textStyle =
      TextStyle(fontFamily: 'montserrat', fontSize: 16);
  const TextStyle titleStyle =
      TextStyle(fontFamily: 'montserrat', fontSize: 24);
  const TextStyle subTitleStyle =
      TextStyle(fontFamily: 'montserrat', fontSize: 20);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          onPressed: _backToPreviousPage,
          backgroundColor: ColorSelect.customMagenta,
          clipBehavior: Clip.hardEdge,
          child:
            const Padding(padding: EdgeInsets.only(left: 5), child: Icon(Icons.arrow_back_ios, color: Colors.white))
              
        ),
        body: Container(
            color: ColorSelect.customBlue,
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                children: const [
                  Text("TERMS AND POLICY", style: titleStyle),
                  Padding(padding: EdgeInsets.only(top: 60)),
                  Text("Read carefully before agreeing with something you find on the internet", style: subTitleStyle),
                  Padding(padding: EdgeInsets.only(top: 40)),
                  Text(
                      "By registering on this app, you agree to grant us a non-transferable option to be on the naughty list for the rest of your life. Should we wish to exercise this option, you agree to be put on Santa’s naughty list. We reserve the right to serve such notice, however, we can accept no liability for any loss or damage caused by such an act. If you a) do not believe in Christmas, b) are already on the naughty list, or c) do not wish to grant us such a license, please send an email to the address below to nullify this sub-clause and proceed with your download.",
                      style: textStyle),
                  Padding(padding: EdgeInsets.only(top: 40)),
                  Text(
                      "By registering on this app, you agree to grant us a non-transferable option to let us name your firstborn child. Should we wish to exercise this option, you agree to surrender control over choosing the name, and any claim you may have on it. We reserve the right to serve such notice, however, we can accept no liability for any loss or damage caused by such an act. If you a) do not believe you want a child, b) have had your firstborn child already or c) do not wish to grant us such a license, please send an email to the address below to nullify this sub-clause and proceed with your download.",
                      style: textStyle),
                  Padding(padding: EdgeInsets.only(top: 40)),
                  Text(
                      "By registering on this app, you agree to grant us a non-transferable option to not eat pizza for the next 12 months. Should we wish to exercise this option, you agree to refuse any type of pizza for the next 12 months. We reserve the right to serve such notice, however, we can accept no liability for any loss or damage caused by such an act. If you a) can’t be without pizza b) have already planned to eat pizza, or c) do not wish to grant us such a license, please send an email to the address below to nullify this sub-clause and proceed with your download.",
                      style: textStyle),
                  Padding(padding: EdgeInsets.only(top: 40)),
                ],
              ),
            ))));
  }
}
