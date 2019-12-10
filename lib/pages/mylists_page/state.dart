import 'package:colorlive/globalbasestate/state.dart';
import 'package:colorlive/models/base_api_model/user_list.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class MyListsPageState implements GlobalBaseState, Cloneable<MyListsPageState> {
  String accountId;
  ScrollController scrollController;
  bool isEdit;
  AnimationController animationController;
  AnimationController cellAnimationController;
  GlobalKey<AnimatedListState> listkey;
  Future<UserListModel> listData;

  @override
  MyListsPageState clone() {
    return MyListsPageState()
      ..accountId = accountId
      ..scrollController = scrollController
      ..isEdit = isEdit
      ..animationController = animationController
      ..cellAnimationController = cellAnimationController
      ..listkey = listkey
      ..listData = listData;
  }

  @override
  Locale locale;

  @override
  Color themeColor;

 /* @override
  FirebaseUser user;*/
}

MyListsPageState initState(Map<String, dynamic> args) {
  MyListsPageState state = MyListsPageState();
  state.accountId = args['accountid'];
  state.isEdit = false;
  state.listkey = GlobalKey<AnimatedListState>();
  return state;
}
