import 'package:colorlive/globalbasestate/state.dart';
import 'package:colorlive/models/base_api_model/user_media.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class FavoritesPageState
    implements GlobalBaseState, Cloneable<FavoritesPageState> {
  UserMedia selectedMedia;
  Color backgroundColor;
  String backgroundUrl;
  String secbackgroundUrl;
  AnimationController animationController;
  PaletteGenerator paletteGenerator;
  UserMediaModel movies;
  UserMediaModel tvshows;
  bool isMovie;

  @override
  FavoritesPageState clone() {
    return FavoritesPageState()
      ..backgroundColor = backgroundColor
      ..secbackgroundUrl = secbackgroundUrl
      ..backgroundUrl = backgroundUrl
      ..selectedMedia = selectedMedia
      ..animationController = animationController
      ..paletteGenerator = paletteGenerator
      ..isMovie = isMovie
      ..movies = movies
      ..tvshows = tvshows;
  }

  @override
  Locale locale;

  @override
  Color themeColor;
}

FavoritesPageState initState(Map<String, dynamic> args) {
  FavoritesPageState state = FavoritesPageState();
  state.isMovie = true;
  state.backgroundColor = Colors.black;
  state.paletteGenerator = PaletteGenerator.fromColors([]);
  return state;
}
