import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:colorlive/actions/Adapt.dart';
import 'package:colorlive/actions/imageurl.dart';
import 'package:colorlive/models/enums/imagesize.dart';
import 'package:colorlive/models/videolist.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    TVCellsState state, Dispatch dispatch, ViewService viewService) {
  Widget _bulidcell(VideoListResult d) {
    return GestureDetector(
      onTap: () => dispatch(TVCellsActionCreator.onCellTapped(
          d.id, d.backdrop_path, d.name, d.poster_path)),
      child: Container(
        child: Stack(
          children: <Widget>[
            CachedNetworkImage(
              fadeInDuration: Duration.zero,
              fadeOutDuration: Duration.zero,
              width: Adapt.screenW(),
              height: Adapt.screenW() * 9 / 16,
              fit: BoxFit.cover,
              imageUrl: ImageUrl.getUrl(
                  d.backdrop_path ?? '/p60VSQL7usdxztIGokJPpHmKWdU.jpg',
                  ImageSize.w500),
              placeholder: (ctx, str) {
                return Container(
                  width: Adapt.screenW(),
                  height: Adapt.screenW() * 9 / 16,
                  color: Colors.grey,
                );
              },
            ),
            Container(
              padding: EdgeInsets.all(Adapt.px(20)),
              width: Adapt.screenW(),
              height: Adapt.screenW() * 9 / 16,
              alignment: Alignment.bottomLeft,
              child: Text(
                d.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Adapt.px(40),
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 2.0,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerCell() {
    return SizedBox(
      width: Adapt.screenW(),
      height: Adapt.screenW() * 9 / 16,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.white,
        child: Container(
          color: Colors.grey[300],
        ),
      ),
    );
  }

  Widget _buildMian() {
    if (state.tv.results.length > 0)
      return Column(
        key: ValueKey(state.tv),
        children: state.tv.results.take(3).map(_bulidcell).toList(),
      );
    else
      return Column(
        key: ValueKey(state.tv),
        children: <Widget>[
          _buildShimmerCell(),
          _buildShimmerCell(),
          _buildShimmerCell()
        ],
      );
  }

  return AnimatedSwitcher(
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      duration: Duration(milliseconds: 600),
      child: _buildMian());
}
