import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:colorlive/models/creditsmodel.dart';
import 'package:colorlive/models/imagemodel.dart';
import 'package:colorlive/models/keyword.dart';
import 'package:colorlive/models/media_accountstatemodel.dart';
import 'package:colorlive/models/moviedetail.dart';
import 'package:colorlive/models/review.dart';
import 'package:colorlive/models/videolist.dart';
import 'package:colorlive/models/videomodel.dart';
import 'package:palette_generator/palette_generator.dart';

//TODO replace with your own action
enum MovieDetailPageAction {
  action,
  init,
  setbgcolor,
  setVideos,
  setImages,
  setReviews,
  setAccountState,
  recommendationTapped,
  castCellTapped,
  openMenu,
  showSnackBar
}

class MovieDetailPageActionCreator {
  static Action onAction() {
    return const Action(MovieDetailPageAction.action);
  }

  static Action onInit(MovieDetailModel model) {
    return Action(MovieDetailPageAction.init, payload: model);
  }

  static Action onsetColor(PaletteGenerator c) {
   return Action(MovieDetailPageAction.setbgcolor, payload: c);
  }
  static Action onSetImages(ImageModel c) {
    return Action(MovieDetailPageAction.setImages, payload: c);
  }

  static Action onSetReviews(ReviewModel c) {
    return Action(MovieDetailPageAction.setReviews, payload: c);
  }
  static Action onSetVideos(VideoModel c) {
    return Action(MovieDetailPageAction.setVideos, payload: c);
  }
  static Action onRecommendationTapped(int movieid,String backpic) {
    return Action(MovieDetailPageAction.recommendationTapped, payload:[movieid,backpic]);
  }
  static Action onCastCellTapped(int peopleid,String profilePath,String profileName) {
    return Action(MovieDetailPageAction.castCellTapped, payload:[peopleid,profilePath,profileName]);
  }
  static Action onSetAccountState(MediaAccountStateModel model) {
    return Action(MovieDetailPageAction.setAccountState, payload:model);
  }
  static Action openMenu() {
    return Action(MovieDetailPageAction.openMenu);
  }
  static Action showSnackBar(String message) {
    return Action(MovieDetailPageAction.showSnackBar,payload: message);
  }
}
