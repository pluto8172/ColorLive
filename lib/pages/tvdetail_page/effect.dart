import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/widgets.dart' hide Action;
import 'package:colorlive/actions/Adapt.dart';
import 'package:colorlive/actions/apihelper.dart';
import 'package:colorlive/actions/base_api.dart';
import 'package:colorlive/actions/imageurl.dart';
import 'package:colorlive/customwidgets/custom_stfstate.dart';
import 'package:colorlive/customwidgets/gallery_photoview_wrapper.dart';
import 'package:colorlive/globalbasestate/store.dart';
import 'package:colorlive/models/enums/imagesize.dart';
import 'package:colorlive/models/enums/media_type.dart';
import 'package:colorlive/models/firebase/firebase_accountstate.dart';
import 'package:colorlive/models/imagemodel.dart';
import 'package:palette_generator/palette_generator.dart';
import 'action.dart';
import 'state.dart';

Effect<TVDetailPageState> buildEffect() {
  return combineEffects(<Object, Effect<TVDetailPageState>>{
    TVDetailPageAction.action: _onAction,
    TVDetailPageAction.recommendationTapped: _onRecommendationTapped,
    TVDetailPageAction.castCellTapped: _onCastCellTapped,
    TVDetailPageAction.openMenu: _openMenu,
    TVDetailPageAction.showSnackBar: _showSnackBar,
    TVDetailPageAction.onImageCellTapped: _onImageCellTapped,
    TVDetailPageAction.plyaTapped: _onPlayTapped,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<TVDetailPageState> ctx) {}

Future _onInit(Action action, Context<TVDetailPageState> ctx) async {
  try {
    final ticker = ctx.stfState as CustomstfState;
    ctx.state.animationController = AnimationController(
        vsync: ticker, duration: Duration(milliseconds: 1000));
    /*var paletteGenerator = await PaletteGenerator.fromImageProvider(
          CachedNetworkImageProvider(ImageUrl.getUrl(ctx.state.posterPic, ImageSize.w300)));
      ctx.dispatch(TVDetailPageActionCreator.onsetColor(paletteGenerator));*/
    var r = await ApiHelper.getTVDetail(ctx.state.tvid,
        appendtoresponse:
            'keywords,recommendations,credits,external_ids,content_ratings');
    if (r != null) {
      ctx.dispatch(TVDetailPageActionCreator.onInit(r));
      ctx.state.animationController.forward();
    }
    var l = await ApiHelper.getTVReviews(ctx.state.tvid);
    if (l != null) ctx.dispatch(TVDetailPageActionCreator.onSetReviews(l));

    var k = await ApiHelper.getTVImages(ctx.state.tvid);
    if (k != null) ctx.dispatch(TVDetailPageActionCreator.onSetImages(k));
    var f = await ApiHelper.getTVVideo(ctx.state.tvid);
    if (f != null) ctx.dispatch(TVDetailPageActionCreator.onSetVideos(f));

    final _user = GlobalStore.store.getState().user;
    if (_user != null) {
      var accountstate = await BaseApi.getAccountState(
          _user.uid, ctx.state.tvid, MediaType.tv);
      if (accountstate != null)
        ctx.dispatch(TVDetailPageActionCreator.onSetAccountState(accountstate));
    }
  } on Exception catch (e) {}
}

void _onPlayTapped(Action action, Context<TVDetailPageState> ctx) async {
  await Navigator.of(ctx.context).pushNamed('seasonLinkPage', arguments: {
    'tvid': ctx.state.tvid,
    'detail': ctx.state.tvDetailModel,
  });
}

Future _onRecommendationTapped(
    Action action, Context<TVDetailPageState> ctx) async {
  await Navigator.of(ctx.context).pushNamed('tvdetailpage',
      arguments: {'tvid': action.payload[0], 'bgpic': action.payload[1]});
}

Future _onCastCellTapped(Action action, Context<TVDetailPageState> ctx) async {
  await Navigator.of(ctx.context).pushNamed('peopledetailpage', arguments: {
    'peopleid': action.payload[0],
    'profilePath': action.payload[1],
    'profileName': action.payload[2]
  });
}

void _openMenu(Action action, Context<TVDetailPageState> ctx) {
  showModalBottomSheet(
      context: ctx.context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ctx.buildComponent('menu');
      });
}

void _showSnackBar(Action action, Context<TVDetailPageState> ctx) {
  ctx.state.scaffoldkey.currentState.showSnackBar(SnackBar(
    content: Text(action.payload ?? ''),
  ));
}

Future _onImageCellTapped(Action action, Context<TVDetailPageState> ctx) async {
  final int _index = action.payload[0];
  final List<ImageData> _images = action.payload[1];
  await Navigator.of(ctx.context).push(PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return new FadeTransition(
            opacity: animation,
            child: GalleryPhotoViewWrapper(
              imageSize: ImageSize.w400,
              galleryItems: _images,
              initialIndex: _index,
            ));
      }));
}
