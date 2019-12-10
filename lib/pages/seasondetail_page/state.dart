import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:colorlive/globalbasestate/state.dart';
import 'package:colorlive/models/episodemodel.dart';
import 'package:colorlive/models/seasondetail.dart';

import 'components/seasoncast_component/state.dart';

class SeasonDetailPageState
    implements GlobalBaseState, Cloneable<SeasonDetailPageState> {
  SeasonDetailModel seasonDetailModel;
  SeasonCastState seasonCastState;
  ScrollController scrollController;
  String name;
  String seasonpic;
  int tvid;
  int seasonNumber;

  @override
  SeasonDetailPageState clone() {
    return SeasonDetailPageState()
      ..seasonDetailModel = seasonDetailModel
      ..tvid = tvid
      ..seasonNumber = seasonNumber
      ..seasonCastState = seasonCastState
      ..name = name
      ..seasonpic = seasonpic
      ..scrollController;
  }

  @override
  Color themeColor;

  @override
  Locale locale;

  @override
  FirebaseUser user;
}

SeasonDetailPageState initState(Map<String, dynamic> args) {
  SeasonDetailPageState state = SeasonDetailPageState();
  state.tvid = args['tvid'];
  state.seasonNumber = args['seasonNumber'];
  state.name = args['name'];
  state.seasonpic = args['posterpic'];
  state.seasonDetailModel =
      SeasonDetailModel.fromParams(episodes: List<Episode>());
  state.seasonCastState = SeasonCastState();
  return state;
}
