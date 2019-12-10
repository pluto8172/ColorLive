import 'dart:ui';

import 'package:colorlive/actions/Adapt.dart';
import 'package:colorlive/globalbasestate/state.dart';
import 'package:colorlive/models/combinedcredits.dart';
import 'package:colorlive/models/peopledetail.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';

class PeopleDetailPageState
    implements GlobalBaseState, Cloneable<PeopleDetailPageState> {
  PeopleDetailModel peopleDetailModel;
  CombinedCreditsModel creditsModel;
  List<CastData> knowForCast;
  int peopleid;
  double biographyHeight;
  bool isBiographyOpen;
  bool showmovie;
  String profilePath;
  String profileName;
  String character;
  ScrollPhysics pageScrollPhysics;
  @override
  PeopleDetailPageState clone() {
    return PeopleDetailPageState()
      ..peopleDetailModel = peopleDetailModel
      ..peopleid = peopleid
      ..profilePath = profilePath
      ..profileName = profileName
      ..creditsModel = creditsModel
      ..isBiographyOpen = isBiographyOpen
      ..biographyHeight = biographyHeight
      ..showmovie = showmovie
      ..knowForCast = knowForCast
      ..pageScrollPhysics = pageScrollPhysics;
  }

  @override
  Color themeColor;

  @override
  Locale locale;

  /*@override
  FirebaseUser user;*/
}

PeopleDetailPageState initState(Map<String, dynamic> args) {
  var state = PeopleDetailPageState();
  state.peopleDetailModel =
      PeopleDetailModel.fromParams(also_known_as: List<String>());
  state.creditsModel = CombinedCreditsModel.fromParams(
      cast: List<CastData>(), crew: List<CrewData>());
  state.biographyHeight = Adapt.px(200.0);
  state.isBiographyOpen = false;
  state.showmovie = true;
  state.pageScrollPhysics = new ScrollPhysics();
  state.knowForCast = [];
  state.peopleid = args['peopleid'];
  state.profilePath = args['profilePath'];
  state.profileName = args['profileName'];
  state.character = args['character'];
  return state;
}
