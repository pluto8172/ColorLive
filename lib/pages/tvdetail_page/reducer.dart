import 'package:fish_redux/fish_redux.dart';
import 'package:colorlive/models/base_api_model/account_state.dart';
import 'package:colorlive/models/creditsmodel.dart';
import 'package:colorlive/models/firebase/firebase_accountstate.dart';
import 'package:colorlive/models/imagemodel.dart';
import 'package:colorlive/models/keyword.dart';
import 'package:colorlive/models/review.dart';
import 'package:colorlive/models/tvdetail.dart';
import 'package:colorlive/models/videolist.dart';
import 'package:colorlive/models/videomodel.dart';
import 'package:palette_generator/palette_generator.dart';

import 'action.dart';
import 'state.dart';

Reducer<TVDetailPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<TVDetailPageState>>{
      TVDetailPageAction.action: _onAction,
      TVDetailPageAction.init: _onInit,
      TVDetailPageAction.setbgcolor: _onSetColor,
      TVDetailPageAction.setCredits: _onCredits,
      TVDetailPageAction.setImages: _onSetImages,
      TVDetailPageAction.setReviews: _onSetReviews,
      TVDetailPageAction.setRecommendation: _onSetRecommendations,
      TVDetailPageAction.setKeyWords: _onSetKeyWords,
      TVDetailPageAction.setVideos: _onSetVideos,
      TVDetailPageAction.setAccountState: _onSetAccountState
    },
  );
}

TVDetailPageState _onAction(TVDetailPageState state, Action action) {
  final TVDetailPageState newState = state.clone();
  return newState;
}

TVDetailPageState _onInit(TVDetailPageState state, Action action) {
  TVDetailModel model = action.payload ?? new TVDetailModel.fromParams();
  final TVDetailPageState newState = state.clone();
  newState.tvDetailModel = model;
  newState.backdropPic = model.backdrop_path;
  newState.posterPic = model.poster_path;
  newState.name = model.name;
  return newState;
}

TVDetailPageState _onSetColor(TVDetailPageState state, Action action) {
  PaletteGenerator c = action.payload;
  final TVDetailPageState newState = state.clone();
  newState.palette = c;
  return newState;
}

TVDetailPageState _onCredits(TVDetailPageState state, Action action) {
  CreditsModel c = action.payload;
  final TVDetailPageState newState = state.clone();
  newState.creditsModel = c;
  return newState;
}

TVDetailPageState _onSetImages(TVDetailPageState state, Action action) {
  ImageModel c = action.payload;
  final TVDetailPageState newState = state.clone();
  newState.imagesmodel = c;
  return newState;
}

TVDetailPageState _onSetReviews(TVDetailPageState state, Action action) {
  ReviewModel c = action.payload;
  final TVDetailPageState newState = state.clone();
  newState.reviewModel = c;
  return newState;
}

TVDetailPageState _onSetRecommendations(
    TVDetailPageState state, Action action) {
  VideoListModel c = action.payload;
  final TVDetailPageState newState = state.clone();
  newState.recommendations = c;
  return newState;
}

TVDetailPageState _onSetKeyWords(TVDetailPageState state, Action action) {
  KeyWordModel c = action.payload ??
      new KeyWordModel.fromParams(keywords: List<KeyWordData>());
  final TVDetailPageState newState = state.clone();
  newState.keywords = c;
  return newState;
}

TVDetailPageState _onSetVideos(TVDetailPageState state, Action action) {
  VideoModel c = action.payload;
  final TVDetailPageState newState = state.clone();
  newState.videomodel = c;
  return newState;
}

TVDetailPageState _onSetAccountState(TVDetailPageState state, Action action) {
  AccountState c = action.payload;
  final TVDetailPageState newState = state.clone();
  newState.accountState = c;
  return newState;
}
