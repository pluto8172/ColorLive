import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:colorlive/actions/Adapt.dart';
import 'package:colorlive/actions/imageurl.dart';
import 'package:colorlive/customwidgets/backdrop.dart';
import 'package:colorlive/customwidgets/shimmercell.dart';
import 'package:colorlive/generated/i18n.dart';
import 'package:colorlive/models/enums/imagesize.dart';
import 'package:colorlive/models/enums/media_type.dart';
import 'package:colorlive/models/videolist.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    HomePageState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      final TextStyle _selectPopStyle = TextStyle(
        fontSize: Adapt.px(24),
        fontWeight: FontWeight.bold,
      );

      final TextStyle _unselectPopStyle =
          TextStyle(fontSize: Adapt.px(24), color: Colors.grey);
      final _lightTheme = ThemeData.light().copyWith(
          backgroundColor: Colors.white,
          bottomAppBarColor: Color.fromRGBO(45, 45, 48, 1),
          cardColor: Colors.white,
          cursorColor: Colors.grey[200]);
      final _darkTheme = ThemeData.dark().copyWith(
          backgroundColor: Color(0xFF303030),
          bottomAppBarColor: Color(0xFF101010),
          cardColor: Color(0xFF404040),
          cursorColor: Colors.transparent);
      final MediaQueryData _mediaQuery = MediaQuery.of(context);
      final ThemeData _theme =
          _mediaQuery.platformBrightness == Brightness.light
              ? _lightTheme
              : _darkTheme;

      //搜索框
      Widget _buildSearchBar() {
        return GestureDetector(
          onTap: () => dispatch(HomePageActionCreator.onSearchBarTapped()),
          child: Container(
              padding: EdgeInsets.only(left: Adapt.px(30), right: Adapt.px(30)),
              height: Adapt.px(70),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Adapt.px(40)),
                color: Color.fromRGBO(57, 57, 57, 1),
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: Adapt.px(20),
                  ),
                  Text(
                    I18n.of(viewService.context).searchbartxt,
                    style:
                        TextStyle(color: Colors.grey, fontSize: Adapt.px(28)),
                  )
                ],
              )),
        );
      }

      //标题拦
      Widget _buildHeaderTitle() {
        //选中的样式
        var _selectTextStyle = TextStyle(
            color: Colors.black,
            fontSize: Adapt.px(40),
            fontWeight: FontWeight.bold);
        //为选中的样式
        var _unselectTextStyle =
            TextStyle(color: Colors.grey, fontSize: Adapt.px(40));
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                InkWell(
                  onTap: () => dispatch(
                      HomePageActionCreator.onHeaderFilterChanged(true)),
                  child: Text(I18n.of(viewService.context).inTheaters,
                      style: state.showHeaderMovie
                          ? _selectTextStyle
                          : _unselectTextStyle),
                ),
                SizedBox(
                  width: Adapt.px(30),
                ),
                InkWell(
                  onTap: () => dispatch(
                      HomePageActionCreator.onHeaderFilterChanged(false)),
                  child: Text(
                    I18n.of(viewService.context).onTV,
                    style: state.showHeaderMovie
                        ? _unselectTextStyle
                        : _selectTextStyle,
                  ),
                )
              ],
            ));
      }

      //水平滚动
      Widget _buildHeaderListCell(VideoListResult f) {
        String name = f.title ?? f.name;
        return Padding(
            key: ValueKey('headercell' + f.id.toString()),
            padding: EdgeInsets.only(left: Adapt.px(30)),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () => dispatch(HomePageActionCreator.onCellTapped(
                      f.id,
                      f.backdrop_path,
                      name,
                      f.poster_path,
                      state.showHeaderMovie ? MediaType.movie : MediaType.tv)),
                  child: Container(
                    width: Adapt.px(200),
                    height: Adapt.px(280),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(57, 57, 57, 1),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(ImageUrl.getUrl(
                                f.poster_path, ImageSize.w300)))),
                  ),
                ),
                SizedBox(
                  height: Adapt.px(20),
                ),
                Container(
                  alignment: Alignment.center,
                  width: Adapt.px(200),
                  height: Adapt.px(70),
                  child: Text(name,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey, fontSize: Adapt.px(26))),
                ),
              ],
            ));
      }

      Widget _buildShimmerHeaderCell() {
        Color _baseColor = Color.fromRGBO(57, 57, 57, 1);
        Color _highLightColor = Color.fromRGBO(67, 67, 67, 1);
        return Shimmer.fromColors(
            baseColor: _baseColor,
            highlightColor: _highLightColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: Adapt.px(200),
                  height: Adapt.px(280),
                  color: _baseColor,
                ),
                SizedBox(
                  height: Adapt.px(20),
                ),
                Container(
                  width: Adapt.px(200),
                  height: Adapt.px(20),
                  color: _baseColor,
                ),
                SizedBox(
                  height: Adapt.px(8),
                ),
                Container(
                  width: Adapt.px(150),
                  height: Adapt.px(20),
                  color: _baseColor,
                ),
              ],
            ));
      }

      Widget _buildHeaderBody() {
        var _model = state.showHeaderMovie ? state.movie : state.tv;
        return Container(
          height: Adapt.px(400),
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 600),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            child: ListView(
                key: ValueKey(_model),
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: _model.results.length > 0
                    ? _model.results.map(_buildHeaderListCell).toList()
                    : <Widget>[
                        SizedBox(
                          width: Adapt.px(30),
                        ),
                        _buildShimmerHeaderCell(),
                        SizedBox(
                          width: Adapt.px(30),
                        ),
                        _buildShimmerHeaderCell(),
                        SizedBox(
                          width: Adapt.px(30),
                        ),
                        _buildShimmerHeaderCell(),
                      ]),
          ),
        );
      }

      Widget _buildSwiperCardCell(VideoListResult d) {
        return GestureDetector(
            key: ValueKey('card${d.id}'),
            onTap: () => dispatch(HomePageActionCreator.onCellTapped(
                d.id,
                d.backdrop_path,
                d.title ?? d.name,
                d.poster_path,
                state.showHeaderMovie ? MediaType.movie : MediaType.tv)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: new BoxDecoration(
                    color: _theme.cardColor,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: _theme.cursorColor,
                          offset: Offset(0, Adapt.px(20)),
                          blurRadius: Adapt.px(30),
                          spreadRadius: Adapt.px(1)),
                    ],
                  ),
                  margin: EdgeInsets.fromLTRB(
                      Adapt.px(30), Adapt.px(5), Adapt.px(30), Adapt.px(30)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: Adapt.px(120),
                        height: Adapt.px(170),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                    ImageUrl.getUrl(
                                        d.poster_path, ImageSize.w300)))),
                      ),
                      SizedBox(
                        width: Adapt.px(20),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: Adapt.px(20),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                width: Adapt.screenW() - Adapt.px(450),
                                child: Text(
                                  d.title ?? d.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      //color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontSize: Adapt.px(35)),
                                ),
                              ),
                              Container(
                                width: Adapt.px(160),
                                child: RatingBarIndicator(
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  unratedColor: Colors.grey[300],
                                  itemSize: Adapt.px(22),
                                  itemPadding:
                                      EdgeInsets.only(right: Adapt.px(8)),
                                  rating: d.vote_average / 2,
                                ),
                              ),
                              Text(
                                d.vote_average.toStringAsFixed(1),
                                style: TextStyle(
                                    fontSize: Adapt.px(22),
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                          SizedBox(
                            height: Adapt.px(20),
                          ),
                          Container(
                            width: Adapt.screenW() - Adapt.px(210),
                            child: Text(
                              d.overview,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  //color: Colors.grey,
                                  fontSize: Adapt.px(24)),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ));
      }

      Widget _buildSwiper() {
        var _model = state.showHeaderMovie ? state.movie : state.tv;
        Widget _child = _model.results.length > 0
            ? Swiper(
                key: ValueKey(_model),
                autoplay: true,
                duration: 1000,
                autoplayDelay: 10000,
                viewportFraction: 0.9999,
                itemCount: _model.results.length,
                itemBuilder: (ctx, index) {
                  var d = _model.results[index];
                  return _buildSwiperCardCell(d);
                },
              )
            : Container(
                margin: EdgeInsets.only(bottom: Adapt.px(55)),
                child: ShimmerCell(
                    Adapt.screenW() - Adapt.px(60), Adapt.px(170), 0),
              );
        return Container(
          height: Adapt.px(225),
          child: AnimatedSwitcher(
              duration: Duration(milliseconds: 600),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              child: _child),
        );
      }

      Widget _buildTitle(String title, void buttonTap(),
          {IconData d = Icons.more_vert}) {
        return Padding(
          padding: EdgeInsets.fromLTRB(Adapt.px(20), 0, Adapt.px(20), 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: Adapt.px(45),
                    fontWeight: FontWeight.w700),
              ),
              IconButton(
                padding: EdgeInsets.only(right: 0),
                alignment: Alignment.centerRight,
                icon: Icon(d),
                onPressed: () => buttonTap(),
              )
            ],
          ),
        );
      }

      Widget _buildFrontTitel(String title, Widget action,
          {EdgeInsetsGeometry padding =
              const EdgeInsets.symmetric(horizontal: 20)}) {
        return Padding(
          padding: padding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    //color: Colors.black,
                    fontSize: Adapt.px(35),
                    fontWeight: FontWeight.bold),
              ),
              action
            ],
          ),
        );
      }

      Widget _buildTrending() {
        double _size = (Adapt.screenW() - Adapt.px(70)) / 2;
        Widget _child = state.trending.results.length > 0
            ? StaggeredGridView.countBuilder(
                key: ValueKey('Trending'),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 4,
                staggeredTileBuilder: (int index) =>
                    new StaggeredTile.count(2, index == 0 ? 2 : 1),
                mainAxisSpacing: Adapt.px(5),
                crossAxisSpacing: Adapt.px(5),
                itemCount: 3,
                itemBuilder: (BuildContext contxt, int index) {
                  var d = state.trending.results[index];
                  return GestureDetector(
                      onTap: () => dispatch(HomePageActionCreator.onCellTapped(
                          d.id,
                          d.backdropPath,
                          d.title ?? d.name,
                          d.posterPath,
                          d.title != null ? MediaType.movie : MediaType.tv)),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Adapt.px(10)),
                        alignment: Alignment.bottomLeft,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                    ImageUrl.getUrl(
                                        d.backdropPath, ImageSize.w400)))),
                        child: Text(
                          d.title ?? d.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Adapt.px(30),
                              fontWeight: FontWeight.bold,
                              shadows: <Shadow>[Shadow(offset: Offset(1, 1))]),
                        ),
                      ));
                },
              )
            : Shimmer.fromColors(
                baseColor: Colors.grey[200],
                highlightColor: Colors.grey[100],
                child: Row(
                  children: <Widget>[
                    Container(
                      width: _size,
                      height: _size,
                      color: Colors.grey[200],
                    ),
                    SizedBox(
                      width: Adapt.px(10),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: _size,
                          height: (_size - Adapt.px(10)) / 2,
                          color: Colors.grey[200],
                        ),
                        SizedBox(
                          height: Adapt.px(10),
                        ),
                        Container(
                          width: _size,
                          height: (_size - Adapt.px(10)) / 2,
                          color: Colors.grey[200],
                        )
                      ],
                    )
                  ],
                ),
              );
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 600),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              child: _child,
            ));
      }

      Widget _buildShareCell(dynamic d) {
        return Padding(
          key: ValueKey(d),
          padding: EdgeInsets.only(left: Adapt.px(30)),
          child: GestureDetector(
            onTap: () => dispatch(HomePageActionCreator.onCellTapped(
                d.id,
                d.photourl,
                d.name,
                d.photourl,
                state.showShareMovie ? MediaType.movie : MediaType.tv)),
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(Adapt.px(15)),
                  child: CachedNetworkImage(
                    fadeOutDuration: Duration(milliseconds: 200),
                    fadeInDuration: Duration(milliseconds: 200),
                    width: Adapt.px(250),
                    height: Adapt.px(350),
                    fit: BoxFit.cover,
                    imageUrl: ImageUrl.getUrl(d.photourl, ImageSize.w400),
                    placeholder: (ctx, s) {
                      return Image.asset(
                        'images/CacheBG.jpg',
                        fit: BoxFit.cover,
                        width: Adapt.px(250),
                        height: Adapt.px(350),
                      );
                    },
                  ),
                ),
                Container(
                    //alignment: Alignment.bottomCenter,
                    width: Adapt.px(250),
                    padding: EdgeInsets.all(Adapt.px(10)),
                    child: Text(
                      d.name ?? '',
                      maxLines: 2,
                      //textAlign: TextAlign.center,
                      style: TextStyle(
                        //color: Colors.black,
                        fontSize: Adapt.px(28),
                        fontWeight: FontWeight.bold,
                      ),
                    ))
              ],
            ),
          ),
        );
      }

      Widget _buildShimmerCell() {
        return SizedBox(
          width: Adapt.px(250),
          height: Adapt.px(350),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[200],
            highlightColor: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: Adapt.px(250),
                  height: Adapt.px(350),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(Adapt.px(15)),
                  ),
                ),
                SizedBox(
                  height: Adapt.px(20),
                ),
                Container(
                  width: Adapt.px(200),
                  height: Adapt.px(30),
                  color: Colors.grey[200],
                )
              ],
            ),
          ),
        );
      }

      Widget _buildMoreCell() {
        return InkWell(
            onTap: () => dispatch(HomePageActionCreator.onShareMore()),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Adapt.px(20)),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(Adapt.px(15)),
                  ),
                  width: Adapt.px(250),
                  height: Adapt.px(350),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          I18n.of(viewService.context).more,
                          style: TextStyle(
                              color: Colors.black, fontSize: Adapt.px(35)),
                        ),
                        Icon(Icons.arrow_forward, size: Adapt.px(35))
                      ]),
                )
              ],
            ));
      }

      Widget _buildShareBody() {
        var model = state.showShareMovie
            ? (state.shareMovies?.data ?? [])
            : (state.shareTvshows?.data ?? []);
        return AnimatedSwitcher(
            duration: Duration(milliseconds: 600),
            child: Container(
              key: ValueKey(model),
              height: Adapt.px(450),
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: PageScrollPhysics(),
                shrinkWrap: true,
                children: model.length > 0
                    ? (model.map(_buildShareCell).toList()
                      ..add(_buildMoreCell()))
                    : <Widget>[
                        SizedBox(width: Adapt.px(20)),
                        _buildShimmerCell(),
                        SizedBox(width: Adapt.px(20)),
                        _buildShimmerCell(),
                        SizedBox(width: Adapt.px(20)),
                        _buildShimmerCell(),
                        SizedBox(width: Adapt.px(20)),
                        _buildShimmerCell()
                      ],
              ),
            ));
      }

      Widget _getStyle3() {
        return Scaffold(
          //上面的搜索框
          appBar: AppBar(
            backgroundColor: _theme.bottomAppBarColor,
            brightness: Brightness.dark,
            elevation: 0.0,
            automaticallyImplyLeading: false,
            title: _buildSearchBar(),
          ),
          backgroundColor: Colors.white,

          body:ListView(
            dragStartBehavior: DragStartBehavior.down,
            physics: ClampingScrollPhysics(),
            children: <Widget>[

              SizedBox(
                height: Adapt.px(30),
              ),
              _buildHeaderTitle(),
              SizedBox(
                height: Adapt.px(45),
              ),
              _buildHeaderBody(),

              _buildSwiper(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildFrontTitel(
                      'Trending',
                      GestureDetector(
                        onTap: () => dispatch(HomePageActionCreator.onTrendingMore()),
                        child: Text(
                          I18n.of(viewService.context).more,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: Adapt.px(30))),
                  SizedBox(height: Adapt.px(30)),
                  _buildTrending(),
                  SizedBox(height: Adapt.px(50)),
                  _buildFrontTitel(
                      'New Share',
                      GestureDetector(
                        onTap: () =>
                            dispatch(HomePageActionCreator.onShareMore()),
                        child: Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => dispatch(HomePageActionCreator
                                  .onShareFilterChanged(true)),
                              child: Text(
                                  I18n.of(viewService.context).movies,
                                  style: state.showShareMovie
                                      ? _selectPopStyle
                                      : _unselectPopStyle),
                            ),
                            SizedBox(
                              width: Adapt.px(20),
                            ),
                            GestureDetector(
                              onTap: () => dispatch(HomePageActionCreator
                                  .onShareFilterChanged(false)),
                              child: Text(
                                  I18n.of(viewService.context).tvShows,
                                  style: state.showShareMovie
                                      ? _unselectPopStyle
                                      : _selectPopStyle),
                            )
                          ],
                        ),
                      ),
                      padding:
                      EdgeInsets.symmetric(horizontal: Adapt.px(30))),
                  SizedBox(height: Adapt.px(30)),
                  _buildShareBody(),
                  SizedBox(height: Adapt.px(30)),
                  _buildFrontTitel(
                      I18n.of(viewService.context).popular,
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => dispatch(HomePageActionCreator
                                .onPopularFilterChanged(true)),
                            child: Text(
                                I18n.of(viewService.context).movies,
                                style: state.showPopMovie
                                    ? _selectPopStyle
                                    : _unselectPopStyle),
                          ),
                          SizedBox(
                            width: Adapt.px(20),
                          ),
                          GestureDetector(
                            onTap: () => dispatch(HomePageActionCreator
                                .onPopularFilterChanged(false)),
                            child: Text(
                                I18n.of(viewService.context).tvShows,
                                style: state.showPopMovie
                                    ? _unselectPopStyle
                                    : _selectPopStyle),
                          )
                        ],
                      ),
                      padding:
                      EdgeInsets.symmetric(horizontal: Adapt.px(30))),
                  SizedBox(
                    height: Adapt.px(30),
                  ),
                  viewService.buildComponent('popularposter'),
                ],
              ),
            ],
          )

         /* body: Column(
            children: <Widget>[

              SizedBox(
                height: Adapt.px(30),
              ),
              _buildHeaderTitle(),
              SizedBox(
                height: Adapt.px(45),
              ),
              _buildHeaderBody()
            ],
          ),

          body: BackDrop(

              frontBackGroundColor: _theme.backgroundColor,
              frontChild: Container(
                color: _theme.backgroundColor,
                child: ,
              ),
            )*/
        );
      }

      return _getStyle3();
    },
  );
}
