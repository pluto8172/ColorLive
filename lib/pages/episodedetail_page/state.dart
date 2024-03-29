import 'dart:ui';

import 'package:colorlive/globalbasestate/state.dart';
import 'package:colorlive/models/episodemodel.dart';
import 'package:fish_redux/fish_redux.dart';

class EpisodeDetailPageState
    implements GlobalBaseState, Cloneable<EpisodeDetailPageState> {
  Episode episode;
  int tvid;

  @override
  EpisodeDetailPageState clone() {
    return EpisodeDetailPageState()
      ..tvid = tvid
      ..episode = episode;
  }

  @override
  Color themeColor;

  @override
  Locale locale;

}

EpisodeDetailPageState initState(Map<String, dynamic> args) {
  EpisodeDetailPageState state = EpisodeDetailPageState();
  state.episode = args['episode'];
  state.tvid = args['tvid'];
  return state;
}
