import 'package:colorlive/globalbasestate/state.dart';
import 'package:colorlive/models/base_api_model/user_list.dart';
import 'package:colorlive/models/base_api_model/user_list_detail.dart';
import 'package:colorlive/models/enums/list_sort_type.dart';
import 'package:colorlive/models/sortcondition.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class ListDetailPageState
    implements GlobalBaseState, Cloneable<ListDetailPageState> {
  String listId;
  UserList listDetailModel;
  UserListDetailModel listItems;
  ScrollController scrollController;
  List<SortCondition> sortBy;
  String sortType;

  @override
  ListDetailPageState clone() {
    return ListDetailPageState()
      ..listDetailModel = listDetailModel
      ..listId = listId
      ..sortBy = sortBy
      ..sortType = sortType
      ..listItems = listItems
      ..scrollController = scrollController;
  }

  @override
  Locale locale;

  @override
  Color themeColor;
}

ListDetailPageState initState(Map<String, dynamic> args) {
  ListDetailPageState state = ListDetailPageState();
  state.listDetailModel = args['list'];
  state.sortBy = <SortCondition>[
    SortCondition(
        isSelected: true,
        name: 'Original Order',
        value: ListSortType.originalOrderAsc),
    SortCondition(
        isSelected: false, name: 'Rating', value: ListSortType.voteAverageDesc),
    SortCondition(
        isSelected: false,
        name: 'Release Date',
        value: ListSortType.releaseDateDesc),
    SortCondition(
        isSelected: false, name: 'Title', value: ListSortType.titleAsc),
  ];
  state.sortType = ListSortType.originalOrderAsc;
  return state;
}
