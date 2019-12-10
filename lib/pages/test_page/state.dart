import 'dart:ui';

import 'package:colorlive/globalbasestate/state.dart';
import 'package:fish_redux/fish_redux.dart';

class TestPageState implements GlobalBaseState, Cloneable<TestPageState> {
  //Stream<QuerySnapshot> testData;

  @override
  TestPageState clone() {
    return TestPageState()
      //..testData = testData
      ..themeColor = themeColor
      ..locale = locale;
  }

  @override
  Locale locale;

  @override
  Color themeColor;

 /* @override
  FirebaseUser user;*/
}

TestPageState initState(Map<String, dynamic> args) {
  return TestPageState();
}
