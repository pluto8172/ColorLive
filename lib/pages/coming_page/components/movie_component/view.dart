import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:colorlive/actions/Adapt.dart';
import 'package:colorlive/actions/imageurl.dart';
import 'package:colorlive/customwidgets/keepalive_widget.dart';
import 'package:colorlive/models/enums/genres.dart';
import 'package:colorlive/models/enums/imagesize.dart';
import 'package:colorlive/models/videolist.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(MovieListState state, Dispatch dispatch, ViewService viewService) {
  Random random = new Random(DateTime.now().millisecondsSinceEpoch);
  Widget _buildGenreChip(int id) {
    return Container(
      margin: EdgeInsets.only(right: Adapt.px(10)), //右边距 10
      padding: EdgeInsets.all(Adapt.px(8)), //所有的内边距 8
      child: Text(
        Genres.genres[id],
        style: TextStyle(fontSize: Adapt.px(24)),
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(Adapt.px(20))),
    );
  }

  // 一个item布局，这个是为了在没有网络的情况下展示
  Widget _buildShimmerCell() {
    return SizedBox(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[100],
        child: Container(
          padding: EdgeInsets.all(Adapt.px(20)),
          child: Row( //行布局
            crossAxisAlignment: CrossAxisAlignment.start, //靠右对齐
            children: <Widget>[
              Container(
                  width: Adapt.px(120), //宽120
                  height: Adapt.px(180),//高 180
                  color: Colors.grey[200]),
              SizedBox( //中间的间隔 20
                width: Adapt.px(20),
              ),
              Column(  //纵向布局
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container( //电影标题 350-30
                    width: Adapt.px(350), 
                    height: Adapt.px(30),
                    color: Colors.grey[200],
                  ),
                  SizedBox( //间隔 5
                    height: 5,
                  ),
                  Container( // 上映时间
                    width: Adapt.px(150),
                    height: Adapt.px(24),
                    color: Colors.grey[200],
                  ),
                  SizedBox(
                    height: Adapt.px(8),
                  ),
                  SizedBox(
                    height: Adapt.px(8),
                  ),
                  Container( // 标签
                    width: Adapt.screenW() - Adapt.px(300),
                    height: Adapt.px(24),
                    color: Colors.grey[200],
                  ),
                  SizedBox(
                    height: Adapt.px(8),
                  ),
                  Container(//介绍
                    width: Adapt.screenW() - Adapt.px(300),
                    height: Adapt.px(24),
                    color: Colors.grey[200],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // 电影列表的 item 布局
  Widget _buildMovieCell(VideoListResult d) {
    return InkWell( //可以点击
      onTap: () => dispatch(MovieListActionCreator.cellTapped(d.id)),
      child: Column( //纵向布局
        key: ValueKey<int>(d.id),
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(Adapt.px(20)), //盒子的内边距20
            child: Row( //横向布局
              children: <Widget>[
                Container( //电影图片 120 -180
                  width: Adapt.px(120),
                  height: Adapt.px(180),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(
                          random.nextInt(255),
                          random.nextInt(255),
                          random.nextInt(255),
                          random.nextDouble()),
                      image: DecorationImage( //电影图片
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(ImageUrl.getUrl(d.poster_path, ImageSize.w300)))),
                ),
                SizedBox( //间隔
                  width: Adapt.px(20),
                ),
                Column( //纵向布局
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container( // 电影标题
                      width: Adapt.px(500),
                      child: Text(
                        d?.title ?? '',
                        style: TextStyle(
                            fontSize: Adapt.px(30),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text("Release on: " + d?.release_date ?? '-', //上映时间
                        style: TextStyle(color: Colors.grey[700], fontSize: Adapt.px(24))),
                    SizedBox(
                      height: Adapt.px(8),
                    ),
                    Row( // 标签
                      children: d.genre_ids.take(3).map(_buildGenreChip).toList(),
                    ),
                    SizedBox(
                      height: Adapt.px(8),
                    ),
                    Container( //介绍
                      width: Adapt.screenW() - Adapt.px(200),
                      child: Text(
                        d.overview ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  return keepAliveWrapper(AnimatedSwitcher(
      duration: Duration(milliseconds: 600), //给你600毫秒的相应时间，超过了就显示占位图（四个空item）
      child: ListView(
        key: ValueKey(state.moviecoming),
        controller: state.movieController,
        cacheExtent: Adapt.px(180),
        children: state.moviecoming.results.map(_buildMovieCell).toList()
          ..add(Offstage(
            offstage: state.moviecoming.page == state.moviecoming.total_pages && state.moviecoming.results.length > 0,
            child: Column(
              children: <Widget>[
                _buildShimmerCell(),
                _buildShimmerCell(),
                _buildShimmerCell(),
                _buildShimmerCell(),
              ],
            ),
          )),
      )));
}
