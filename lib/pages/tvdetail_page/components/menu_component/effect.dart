import 'package:colorlive/actions/apihelper.dart';
import 'package:colorlive/actions/base_api.dart';
import 'package:colorlive/models/base_api_model/user_media.dart';
import 'package:colorlive/models/enums/media_type.dart';
import 'package:colorlive/pages/tvdetail_page/action.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<MenuState> buildEffect() {
  return combineEffects(<Object, Effect<MenuState>>{
    MenuAction.action: _onAction,
    MenuAction.setRating: _setRating,
    MenuAction.setFavorite: _setFavorite,
    MenuAction.setWatchlist: _setWatchlist
  });
}

void _onAction(Action action, Context<MenuState> ctx) {}

void _setFavorite(Action action, Context<MenuState> ctx) async {
  final bool _isFavorite = ctx.state.accountState.favorite;
  final user = null;
  if (user != null) {
    ctx.dispatch(MenuActionCreator.updateFavorite(!_isFavorite));
    if (_isFavorite)
      await BaseApi.deleteFavorite(user.uid, MediaType.tv, ctx.state.id);
    else
      await BaseApi.setFavorite(UserMedia.fromParams(
          uid: user.uid,
          name: ctx.state.name,
          photoUrl: ctx.state.detail.poster_path,
          overwatch: ctx.state.detail.overview,
          rated: ctx.state.detail.vote_average,
          ratedCount: ctx.state.detail.vote_count,
          releaseDate: ctx.state.detail.first_air_date,
          popular: ctx.state.detail.popularity,
          genre: ctx.state.detail.genres.map((f) => f.name).toList().join(','),
          mediaId: ctx.state.id,
          mediaType: 'tv'));
    await BaseApi.updateAccountState(ctx.state.accountState);
    ctx.broadcast(TVDetailPageActionCreator.showSnackBar(!_isFavorite
        ? 'has been mark as favorite'
        : 'has been removed from your favorites'));
  }
}

Future _setRating(Action action, Context<MenuState> ctx) async {
  final user = null;
  if (user != null) {
    ctx.dispatch(MenuActionCreator.updateRating(action.payload));
    BaseApi.updateAccountState(ctx.state.accountState);
    ctx.broadcast(
        TVDetailPageActionCreator.showSnackBar('your rating has been saved'));
  }
}

Future _setWatchlist(Action action, Context<MenuState> ctx) async {
  final bool _isWatchlist = ctx.state.accountState.watchlist;
  //final user = GlobalStore.store.getState().user;
  final user = null;
  if (user != null) {
    ctx.dispatch(MenuActionCreator.updateWatctlist(!_isWatchlist));
    if (_isWatchlist)
      await BaseApi.deleteWatchlist(user.uid, MediaType.tv, ctx.state.id);
    else
      await BaseApi.setWatchlist(UserMedia.fromParams(
          uid: user.uid,
          name: ctx.state.name,
          photoUrl: ctx.state.detail.poster_path,
          overwatch: ctx.state.detail.overview,
          rated: ctx.state.detail.vote_average,
          ratedCount: ctx.state.detail.vote_count,
          releaseDate: ctx.state.detail.first_air_date,
          popular: ctx.state.detail.popularity,
          genre: ctx.state.detail.genres.map((f) => f.name).toList().join(','),
          mediaId: ctx.state.id,
          mediaType: 'tv'));
    await BaseApi.updateAccountState(ctx.state.accountState);
    ctx.broadcast(TVDetailPageActionCreator.showSnackBar(!_isWatchlist
        ? 'has been add to your watchlist'
        : 'has been removed from your watchlist'));
  }
  final bool f = action.payload;
  ctx.dispatch(MenuActionCreator.updateWatctlist(f));
  var r = await ApiHelper.addToWatchlist(ctx.state.id, MediaType.movie, f);
  if (r)
    ctx.broadcast(TVDetailPageActionCreator.showSnackBar(f
        ? 'has been add to your watchlist'
        : 'has been removed from your watchlist'));
}
