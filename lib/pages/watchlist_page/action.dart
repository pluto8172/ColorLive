import 'package:colorlive/models/base_api_model/user_media.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum WatchlistPageAction {
  action,
  setTVShow,
  widthChanged,
  swiperChanged,
  swiperCellTapped,
  setMovie,
}

class WatchlistPageActionCreator {
  static Action onAction() {
    return const Action(WatchlistPageAction.action);
  }

  static Action setTVShow(UserMediaModel d) {
    return Action(WatchlistPageAction.setTVShow, payload: d);
  }

  static Action widthChanged(bool d) {
    return Action(WatchlistPageAction.widthChanged, payload: d);
  }

  static Action swiperChanged(UserMedia d) {
    return Action(WatchlistPageAction.swiperChanged, payload: d);
  }

  static Action swiperCellTapped() {
    return const Action(WatchlistPageAction.swiperCellTapped);
  }

  static Action setMovie(UserMediaModel d) {
    return Action(WatchlistPageAction.setMovie, payload: d);
  }
}
