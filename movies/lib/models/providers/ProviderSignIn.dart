import 'package:flutter/material.dart';

class ProviderSignIn extends ChangeNotifier {
  bool _isMailEntered = false;
  bool _isResetPassword = false;
  bool _isInDB = false;

  bool get isMailEntered => _isMailEntered;
  bool get isResetPassword => _isResetPassword;
  bool get isInDB => _isInDB;

  updateResetPassword(bool status) {
    _isResetPassword = status;
    notifyListeners();
  }

  updateMailEntered(bool status) {
    _isMailEntered = status;
    notifyListeners();
  }

  updateIsInDB(bool newValue) {
    _isInDB = newValue;
    notifyListeners();
  }
}
