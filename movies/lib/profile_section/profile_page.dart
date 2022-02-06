import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movies/utilities/device_info.dart';
import 'package:movies/utilities/utilities.dart';
import 'package:movies/models/interfaces/user.dart';
import 'package:movies/models/providers/provider_account.dart';
import 'package:movies/models/type_adapters/logged_user.dart';
import 'package:movies/welcome_section/sign_in_section/sign_in_page.dart';
import 'package:provider/provider.dart';
import 'package:movies/colors/colors_theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {  
  DeviceInfo deviceInfo = DeviceInfo();
  bool _isIPhoneNotch = false;

  Future<void> _getDeviceInfo() async {
    _isIPhoneNotch = await deviceInfo.isIPhoneNotch();
  }

  final ButtonStyle _loginButton = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      primary: ColorSelect.customBlue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ));

  void _logout(ProviderAccount accountProvider) {
    final Box<LoggedUser> _userBox = Hive.box<LoggedUser>("userBox");
    dynamic tempUser = Utilities.mapLoggedUser(_userBox.get("loggedUser"));
    LoggedUser user = LoggedUser(tempUser.id, tempUser.name, tempUser.email,
        tempUser.password, tempUser.imageUrl, false);
    _userBox.put("loggedUser", user);
    User userProvider = User("", "", "", "");
    accountProvider.updateUser(userProvider);
    accountProvider.updateLogStatus(false);
  }

  @override
  void initState() {
    _getDeviceInfo();
    super.initState();
  }

  @override
  void dispose() {
    // final Box<LoggedUser> _userBox = Hive.box<LoggedUser>("userBox");
    // _userBox.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _openSignIn() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const SignInPage()));
    }

    return Consumer<ProviderAccount>(
        builder: (context, accountProvider, child) {
      return SingleChildScrollView(
          child: Column(children: [
        Padding(padding: EdgeInsets.only(top: _isIPhoneNotch ? 125 : 95)),
        Align(
          alignment: Alignment.topCenter,
          child: accountProvider.imageUrl == ""
              ? const CircleAvatar(
                  radius: 90,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                )
              : CircleAvatar(
                  radius: 90,
                  child: FadeInImage(
                    height: 200,
                    width: 200,
                    alignment: Alignment.topCenter,
                    image: accountProvider.imageUrl != ""
                        ? accountProvider.imageUrl as ImageProvider
                        : 'assets/images/profile.png' as ImageProvider,
                    placeholder: 'assets/images/profile.png' as ImageProvider,
                    fit: BoxFit.cover,
                  )),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Center(
                child: Text(
              accountProvider.name == ""
                  ? "Log in to show your account infos and to use the favourites section"
                  : "Thanks ${accountProvider.name} for being with us, hope you enjoy this app",
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ))),
        Center(
            child: ClipRRect(
                child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: accountProvider.name == "" ? 0 : 15,
                        vertical: accountProvider.name == "" ? 0 : 10),
                    color: ColorSelect.customSalmon,
                    child: Text(accountProvider.name,
                        style: const TextStyle(fontSize: 28))),
                borderRadius: BorderRadius.circular(10.0))),
        Padding(
            padding: accountProvider.name == ""
                ? const EdgeInsets.symmetric(horizontal: 15, vertical: 10)
                : const EdgeInsets.only(top: 20)),
        Center(
            child: ClipRRect(
                child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: accountProvider.name == "" ? 0 : 15,
                        vertical: accountProvider.name == "" ? 0 : 10),
                    color: ColorSelect.customSalmon,
                    child: Text(accountProvider.mail,
                        style: const TextStyle(fontSize: 26))),
                borderRadius: BorderRadius.circular(10.0))),
        Padding(
            padding: accountProvider.name == ""
                ? const EdgeInsets.symmetric(horizontal: 15, vertical: 10)
                : const EdgeInsets.only(top: 20)),
        Center(
            child: ClipRRect(
                child: Container(
                    color: ColorSelect.customSalmon,
                    child: Text(accountProvider.linkedBySocial,
                        style: const TextStyle(fontSize: 22))),
                borderRadius: BorderRadius.circular(10.0))),
        Padding(
            padding: accountProvider.name == ""
                ? const EdgeInsets.all(0)
                : const EdgeInsets.only(top: 20)),
        accountProvider.isLogged
            ? TextButton(
                child: const Text("Sign out", style: TextStyle(fontSize: 22)),
                onPressed: () => _logout(accountProvider),
              )
            : ElevatedButton(
                child: const Text("Sign in", style: TextStyle(fontSize: 22)),
                style: _loginButton,
                onPressed: _openSignIn,
              )
      ]));
    });
  }
}
