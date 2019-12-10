import 'dart:ui';

import 'package:colorlive/globalbasestate/state.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class AccountPageState implements GlobalBaseState, Cloneable<AccountPageState> {
  String name;
  String avatar;
  bool islogin;
  int acountIdV3;
  String acountIdV4;
  AnimationController animationController;
  int themeIndex;
  @override
  AccountPageState clone() {
    return AccountPageState()
      ..name = name
      ..avatar = avatar
      ..islogin = islogin
      ..animationController = animationController
      ..acountIdV3 = acountIdV3
      ..acountIdV4 = acountIdV4
      ..themeIndex = themeIndex
      ..locale = locale
      ..themeColor = themeColor;
  }

  @override
  Locale locale;

  @override
  Color themeColor;
}

AccountPageState initState(Map<String, dynamic> args) {
  return AccountPageState()
    ..name = ''
    ..islogin = false
    ..themeIndex = 2;
}
