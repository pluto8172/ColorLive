import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:colorlive/models/enums/media_type.dart';
import 'package:colorlive/models/searchresult.dart';
import 'package:colorlive/models/sortcondition.dart';

class TrendingPageState implements Cloneable<TrendingPageState> {
  SearchResultModel trending;
  ScrollController controller;
  AnimationController animationController;
  AnimationController refreshController;
  List<SortCondition> mediaTypes;
  MediaType selectMediaType;
  bool isToday;

  @override
  TrendingPageState clone() {
    return TrendingPageState()
      ..trending = trending
      ..controller = controller
      ..animationController = animationController
      ..refreshController = refreshController
      ..mediaTypes = mediaTypes
      ..selectMediaType = selectMediaType
      ..isToday = isToday;
  }
}

TrendingPageState initState(Map<String, dynamic> args) {
  TrendingPageState state = TrendingPageState();
  state.trending = args['data'];
  state.isToday = true;
  state.selectMediaType = MediaType.all;
  state.mediaTypes = [
    SortCondition(isSelected: true, name: 'All', value: MediaType.all),
    SortCondition(isSelected: false, name: 'Movie', value: MediaType.movie),
    SortCondition(isSelected: false, name: 'TV Shows', value: MediaType.tv),
    SortCondition(isSelected: false, name: 'Person', value: MediaType.person),
  ];
  return state;
}
