import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final switchSelectionViewModelProvider = ChangeNotifierProvider((ref) {
  return SwitchSelectionViewModel();
  });

class SwitchSelectionViewModel extends ChangeNotifier{
  String applicantType = "";

  String getApplicantType() => applicantType;

  void setApplicantType(String value) {
    applicantType = value;
    notifyListeners();
    log(value);
  }

}