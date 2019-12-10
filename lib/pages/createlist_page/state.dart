import 'dart:ui';

import 'package:colorlive/globalbasestate/state.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class CreateListPageState
    implements GlobalBaseState, Cloneable<CreateListPageState> {

  String name;
  String backGroundUrl;
  String description;
  TextEditingController nameTextController;
  TextEditingController backGroundTextController;
  TextEditingController descriptionTextController;
  @override
  CreateListPageState clone() {
    return CreateListPageState()
      ..name = name
      ..backGroundUrl = backGroundUrl
      ..description = description
      //..user = user
      ..backGroundTextController = backGroundTextController
      ..nameTextController = nameTextController
      ..descriptionTextController = descriptionTextController;
  }

  @override
  Locale locale;

  @override
  Color themeColor;


}

CreateListPageState initState(Map<String, dynamic> args) {
  CreateListPageState state = CreateListPageState();
  /*DocumentSnapshot _listData = args != null ? args['list'] : null;
  state.listData = _listData;
  state.name = _listData != null ? _listData.documentID : '';
  state.backGroundUrl = _listData != null ? _listData['backGroundUrl'] : '';
  state.description = _listData != null ? _listData['description'] : '';*/
  return state;
}
