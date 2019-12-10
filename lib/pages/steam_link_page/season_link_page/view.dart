import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:colorlive/actions/Adapt.dart';
import 'package:colorlive/actions/imageurl.dart';
import 'package:colorlive/customwidgets/sliverappbar_delegate.dart';
import 'package:colorlive/models/enums/imagesize.dart';
import 'package:colorlive/models/episodemodel.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(SeasonLinkPageState state, Dispatch dispatch, ViewService viewService) {
  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: Adapt.px(400),
      pinned: true,
      centerTitle: true,

      flexibleSpace: Stack(fit: StackFit.expand, children: [
        Container(
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.only(left: Adapt.px(60), bottom: Adapt.px(20)),
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(ImageUrl.getUrl(state.detial.backdrop_path, ImageSize.w300)))),
          child: SlideTransition(
              position: Tween<Offset>(begin: Offset.zero, end: Offset(1.6, 0))
                  .animate(state.animationController),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Adapt.px(35)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: Colors.white.withOpacity(.1),
                    alignment: Alignment.centerLeft,
                    width: Adapt.px(250),
                    height: Adapt.px(70),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: Adapt.px(70),
                          width: Adapt.px(70),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Icon(Icons.play_arrow),
                        ),
                        SizedBox(width: Adapt.px(20)),
                        Text(
                          'Play Latest',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              )),
        ),
      ]),
    );
  }

  Widget _buildHeader() {
    return SliverToBoxAdapter(
      key: ValueKey('header'),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Adapt.px(30), vertical: Adapt.px(50)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(state.detial.genres.map((f) => f.name).join(' , ')),
            SizedBox(height: Adapt.px(5)),
            Text(
              state.detial.name,
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: Adapt.px(55)),
            ),
            SizedBox(height: Adapt.px(30)),
            Container(
              height: Adapt.px(160),
              decoration: BoxDecoration(
                  color: Color(0xFFF6F5FA),
                  borderRadius: BorderRadius.circular(Adapt.px(15))),
              padding: EdgeInsets.all(Adapt.px(25)),
              child: Row(
                children: <Widget>[
                  Container(
                    width: Adapt.px(110),
                    height: Adapt.px(110),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Adapt.px(15)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(ImageUrl.getUrl(
                                state.detial.poster_path, ImageSize.w200)))),
                  ),
                  SizedBox(width: Adapt.px(25)),
                  SizedBox(
                    width: Adapt.screenW() - Adapt.px(265),
                    child: Text(
                      state.detial.overview,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: Adapt.px(28)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabbar() {
    final _season = state.detial.seasons.reversed.toList();
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
          maxHeight: Adapt.px(100),
          minHeight: Adapt.px(100),
          child: Container(
              color: Colors.white,
              child: TabBar(
                isScrollable: true,
                controller: state.tabController,
                labelColor: Colors.black,
                indicatorColor: Colors.transparent,
                unselectedLabelColor: Colors.grey,
                labelStyle: TextStyle(
                    fontSize: Adapt.px(35), fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(
                    fontSize: Adapt.px(35), fontWeight: FontWeight.bold),
                tabs: _season.map((f) {
                  return Tab(text: f.name);
                }).toList(),
                //onTap: (index) => dispatch(SeasonLinkPageActionCreator.getSeasonDetial(_season[index])),
              ))),
    );
  }

  Widget _buildEpisodeCell(Episode d) {
    return GestureDetector(
      onTap: () => dispatch(SeasonLinkPageActionCreator.onEpisodeCellTapped(d)),
      child: Container(
        padding: EdgeInsets.only(bottom: Adapt.px(30)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: Adapt.px(220),
              height: Adapt.px(130),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Adapt.px(10)),
                  color: Colors.grey[100],
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                          ImageUrl.getUrl(d.still_path, ImageSize.w300)))),
            ),
            SizedBox(width: Adapt.px(20)),
            Container(
                width: Adapt.screenW() - Adapt.px(300),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text.rich(
                      TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: '${d.episode_number}. ',
                            style: TextStyle(fontSize: Adapt.px(28))),
                        TextSpan(
                            text: '${d.name}',
                            style: TextStyle(
                                fontSize: Adapt.px(28),
                                fontWeight: FontWeight.w800)),
                      ]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: Adapt.px(5)),
                    Text(
                      '${d.overview}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerCell() {
    final _color = Colors.grey[300];
    final _rightWdith = Adapt.screenW() - Adapt.px(300);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: Adapt.px(220),
          height: Adapt.px(130),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Adapt.px(10)),
            color: _color,
          ),
        ),
        SizedBox(width: Adapt.px(20)),
        Container(
            width: Adapt.screenW() - Adapt.px(300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    color: _color, width: Adapt.px(200), height: Adapt.px(30)),
                SizedBox(height: Adapt.px(10)),
                Container(
                    color: _color, width: _rightWdith, height: Adapt.px(20)),
                SizedBox(height: Adapt.px(10)),
                Container(
                    color: _color, width: _rightWdith, height: Adapt.px(20)),
                SizedBox(height: Adapt.px(10)),
                Container(
                    color: _color, width: Adapt.px(400), height: Adapt.px(20)),
              ],
            ))
      ],
    );
  }

  Widget _buildShimmerTabview() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
          child: Column(
            children: <Widget>[
              _buildShimmerCell(),
              SizedBox(height: Adapt.px(30)),
              _buildShimmerCell(),
              SizedBox(height: Adapt.px(30)),
              _buildShimmerCell(),
              SizedBox(height: Adapt.px(30)),
              _buildShimmerCell()
            ],
          )),
    );
  }

  Widget _buildTabView() {
    return TabBarView(
      controller: state.tabController,
      children: state.detial.seasons.reversed.map((f) {
        return f.episodes != null
            ? MediaQuery.removePadding(
                context: viewService.context,
                removeTop: true,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
                  children: f.episodes?.map(_buildEpisodeCell)?.toList() ?? [],
                ))
            : _buildShimmerTabview();
      }).toList(),
    );
  }

  return Scaffold(
    backgroundColor: Colors.white,
    body: NestedScrollView(
      controller: state.scrollController,
      headerSliverBuilder: (context, bool) {
        return [
          _buildAppBar(),
          _buildHeader(),
          _buildTabbar(),
        ];
      },
      body: _buildTabView(),
    ),
  );
}
