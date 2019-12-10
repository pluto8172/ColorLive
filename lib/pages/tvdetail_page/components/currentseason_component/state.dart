import 'package:fish_redux/fish_redux.dart';
import 'package:colorlive/models/tvdetail.dart';
import 'package:colorlive/pages/tvdetail_page/state.dart';

class CurrentSeasonState implements Cloneable<CurrentSeasonState> {
  
  int tvid;
  String name;
  Season nowseason;
  AirData nextToAirData;
  AirData lastToAirData;
  List<Season> seasons;

  @override
  CurrentSeasonState clone() {
    return CurrentSeasonState();
  }
}


class CurrentSeasonConnector extends ConnOp<TVDetailPageState,CurrentSeasonState>{
  @override
  CurrentSeasonState get(TVDetailPageState state) {
    CurrentSeasonState substate=new CurrentSeasonState();
    substate.nowseason=state.tvDetailModel.seasons?.last;
    substate.nextToAirData= state.tvDetailModel?.next_episode_to_air;
    substate.lastToAirData=state.tvDetailModel?.last_episode_to_air;
    substate.name=state.tvDetailModel.name;
    substate.tvid=state.tvDetailModel.id;
    substate.seasons=state.tvDetailModel.seasons;
    return substate;
  }
}

