import 'package:fish_redux/fish_redux.dart';
import 'package:colorlive/models/episodemodel.dart';
import 'package:colorlive/models/tvdetail.dart';

//TODO replace with your own action
enum SeasonLinkPageAction {
  action,
  getSeasonDetial,
  updateSeason,
  episodeCellTapped
}

class SeasonLinkPageActionCreator {
  static Action onAction() {
    return const Action(SeasonLinkPageAction.action);
  }

  static Action getSeasonDetial(Season d) {
    return Action(SeasonLinkPageAction.getSeasonDetial, payload: d);
  }

  static Action updateSeason(TVDetailModel d) {
    return Action(SeasonLinkPageAction.updateSeason, payload: d);
  }

  static Action onEpisodeCellTapped(Episode d) {
    return Action(SeasonLinkPageAction.episodeCellTapped, payload: d);
  }
}
