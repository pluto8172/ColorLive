import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:colorlive/generated/i18n.dart';
import 'package:colorlive/models/enums/media_type.dart';
import 'package:colorlive/models/videolist.dart';

class MoreMediaPageState implements Cloneable<MoreMediaPageState> {

MediaType mediaType;
VideoListModel videoList;
ScrollController scrollController;
AnimationController animationController;

  @override
  MoreMediaPageState clone() {
    return MoreMediaPageState()
    ..videoList=videoList
    ..scrollController=scrollController
    ..mediaType=mediaType
    ..animationController=animationController;
  }
}

MoreMediaPageState initState(Map<String, dynamic> args) {
  MoreMediaPageState state=MoreMediaPageState();
  state.videoList=args['list']??VideoListModel.fromParams(results: []);
  state.mediaType=args['type']??MediaType.movie;
  return state;
}
