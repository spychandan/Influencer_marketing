import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final loginPageViewModelProvider = ChangeNotifierProvider((ref) {
  return LoginPageViewModel();
});

class LoginPageViewModel extends ChangeNotifier {
  String phoneNumber = '';
  String applicantEmail = '';
  String applicantName = '';

  void setPhoneNumber(String val) {
    phoneNumber = val;
    notifyListeners();
  }

  void setEmailAddress(String val) {
    applicantEmail = val;
    notifyListeners();
  }

  void setName(String val) {
    applicantName = val;
    notifyListeners();
  }
}
