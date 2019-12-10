import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:intl/intl.dart';
import 'package:colorlive/actions/Adapt.dart';
import 'package:colorlive/actions/imageurl.dart';
import 'package:colorlive/actions/votecolorhelper.dart';
import 'package:colorlive/customwidgets/sliverappbar_delegate.dart';
import 'package:colorlive/generated/i18n.dart';
import 'package:colorlive/models/enums/imagesize.dart';
import 'package:colorlive/models/sortcondition.dart';
import 'package:colorlive/models/videolist.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    DiscoverPageState state, Dispatch dispatch, ViewService viewService) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
      .copyWith(statusBarBrightness: Brightness.light));
  String _changDatetime(String s1) {
    return s1 == null || s1?.isEmpty == true ? '1900-01-01' : s1;
  }

  Widget _buildShimmerCell() {
    return SizedBox(
        height: Adapt.px(400),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[200],
          highlightColor: Colors.grey[100],
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: Adapt.px(260),
                height: Adapt.px(400),
                color: Colors.grey[200],
              ),
              Container(
                padding: EdgeInsets.all(Adapt.px(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: Adapt.px(80),
                          height: Adapt.px(80),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius:
                                  BorderRadius.circular(Adapt.px(40))),
                        ),
                        SizedBox(
                          width: Adapt.px(10),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: Adapt.screenW() - Adapt.px(450),
                              height: Adapt.px(25),
                              color: Colors.grey[200],
                            ),
                            SizedBox(
                              height: Adapt.px(10),
                            ),
                            Container(
                              width: Adapt.px(120),
                              height: Adapt.px(20),
                              color: Colors.grey[200],
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: Adapt.px(20),
                    ),
                    Container(
                      width: Adapt.screenW() - Adapt.px(360),
                      height: Adapt.px(20),
                      color: Colors.grey[200],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: Adapt.px(10)),
                      width: Adapt.screenW() - Adapt.px(360),
                      height: Adapt.px(20),
                      color: Colors.grey[200],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: Adapt.px(10)),
                      width: Adapt.screenW() - Adapt.px(360),
                      height: Adapt.px(20),
                      color: Colors.grey[200],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: Adapt.px(10)),
                      width: Adapt.screenW() - Adapt.px(360),
                      height: Adapt.px(20),
                      color: Colors.grey[200],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: Adapt.px(10)),
                      width: Adapt.screenW() - Adapt.px(360),
                      height: Adapt.px(20),
                      color: Colors.grey[200],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  return Builder(builder: (context) {
    final _lightTheme =
        ThemeData.light().copyWith(backgroundColor: Colors.white);
    final _darkTheme =
        ThemeData.dark().copyWith(backgroundColor: Color(0xFF303030));
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    final ThemeData _theme = _mediaQuery.platformBrightness == Brightness.light
        ? _lightTheme
        : _darkTheme;
    Widget _buildListCell(VideoListResult d) {
      bool ismovie = state.filterState.isMovie;
      return GestureDetector(
        key: ValueKey<int>(d.id),
        child: Container(
          padding:
              EdgeInsets.fromLTRB(Adapt.px(20), 0, Adapt.px(20), Adapt.px(30)),
          child: Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: Adapt.px(260),
                  height: Adapt.px(400),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              ImageUrl.getUrl(d.poster_path, ImageSize.w300)))),
                ),
                Container(
                  padding: EdgeInsets.all(Adapt.px(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: Adapt.px(80),
                            height: Adapt.px(80),
                            child: Stack(
                              children: <Widget>[
                                Center(
                                  child: Container(
                                    width: Adapt.px(80),
                                    height: Adapt.px(80),
                                    decoration: BoxDecoration(
                                        color: Colors.blueGrey,
                                        borderRadius: BorderRadius.circular(
                                            Adapt.px(40))),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                      width: Adapt.px(60),
                                      height: Adapt.px(60),
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3.0,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                VoteColorHelper.getColor(
                                                    d.vote_average)),
                                        backgroundColor: Colors.grey,
                                        value: d.vote_average / 10.0,
                                      )),
                                ),
                                Center(
                                  child: Container(
                                      width: Adapt.px(60),
                                      height: Adapt.px(60),
                                      child: Center(
                                        child: Text(
                                          (d.vote_average * 10.0)
                                                  .floor()
                                                  .toString() +
                                              '%',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: Adapt.px(22),
                                              color: Colors.white),
                                        ),
                                      )),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: Adapt.px(10),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: Adapt.screenW() - Adapt.px(450),
                                child: Text(
                                  (ismovie ? d.title : d.name) ?? '',
                                  maxLines: 2,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: Adapt.px(26)),
                                ),
                              ),
                              Text(
                                DateFormat.yMMMd().format(DateTime.tryParse(
                                    (ismovie
                                        ? _changDatetime(d.release_date)
                                        : _changDatetime(d.first_air_date)))),
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: Adapt.px(20)),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: Adapt.px(20),
                      ),
                      Container(
                        width: Adapt.screenW() - Adapt.px(360),
                        child: Text(
                          d.overview ?? '',
                          softWrap: true,
                          maxLines: 7,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: () => dispatch(
            DiscoverPageActionCreator.onVideoCellTapped(d.id, d.poster_path)),
      );
    }

    Widget _buildConditionListWidget(items, void itemOnTap(sortCondition)) {
      return ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: items.length,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 1.0),
        itemBuilder: (BuildContext context, int index) {
          SortCondition goodsSortCondition = items[index];
          return GestureDetector(
            onTap: () {
              for (var value in items) {
                value.isSelected = false;
              }
              goodsSortCondition.isSelected = true;
              itemOnTap(goodsSortCondition);
            },
            child: Container(
              color: _theme.backgroundColor,
              height: 40,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Text(
                      goodsSortCondition.name,
                      style: TextStyle(
                        color: goodsSortCondition.isSelected
                            ? _theme.textTheme.body1.color
                            : Colors.grey,
                      ),
                    ),
                  ),
                  goodsSortCondition.isSelected
                      ? Icon(
                          Icons.check,
                          color: _theme.iconTheme.color,
                          size: 16,
                        )
                      : SizedBox(),
                  SizedBox(
                    width: 16,
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      key: state.scaffoldKey,
      endDrawer: Drawer(
        child: viewService.buildComponent('filter'),
      ),
      body: SafeArea(
        child: Stack(
          key: state.stackKey,
          children: <Widget>[
            CustomScrollView(
              controller: state.scrollController,
              slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: SliverAppBarDelegate(
                      minHeight: 40,
                      maxHeight: 40,
                      child: GZXDropDownHeader(
                        borderColor: _theme.backgroundColor,
                        color: _theme.backgroundColor,
                        items: [
                          GZXDropDownHeaderItem(state.filterTabNames[0]),
                          GZXDropDownHeaderItem(
                              I18n.of(viewService.context).filter,
                              iconData: Icons.filter_list,
                              iconSize: 13),
                        ],
                        style: TextStyle(
                          fontSize: Adapt.px(24),
                        ),
                        dropDownStyle: TextStyle(
                          fontSize: Adapt.px(24),
                        ),
                        iconDropDownColor: Colors.black,
                        stackKey: state.stackKey,
                        controller: state.dropdownMenuController,
                        onItemTap: (index) {
                          if (index == 1) {
                            state.scaffoldKey.currentState.openEndDrawer();
                            state.dropdownMenuController.hide();
                          }
                        },
                      )),
                ),
                SliverList(
                  delegate:
                      SliverChildBuilderDelegate((BuildContext cxt, int index) {
                    return _buildListCell(state.videoListModel.results[index]);
                  }, childCount: state.videoListModel.results.length),
                ),
                SliverToBoxAdapter(
                    child: Offstage(
                  offstage: state.isbusy,
                  child: Container(
                    margin: EdgeInsets.only(
                        top: Adapt.px(10),
                        bottom: Adapt.px(30),
                        left: Adapt.px(30),
                        right: Adapt.px(30)),
                    child: Column(
                      children: <Widget>[
                        _buildShimmerCell(),
                        SizedBox(
                          height: Adapt.px(30),
                        ),
                        _buildShimmerCell(),
                        SizedBox(
                          height: Adapt.px(30),
                        ),
                        _buildShimmerCell(),
                      ],
                    ),
                  ),
                ))
              ],
            ),
            GZXDropDownMenu(
              animationMilliseconds: 250,
              controller: state.dropdownMenuController,
              menus: [
                GZXDropdownMenuBuilder(
                  dropDownHeight: 40 * state.sortType.length.toDouble(),
                  dropDownWidget:
                      _buildConditionListWidget(state.sortType, (value) {
                    state.dropdownMenuController.hide();
                    int e = state.sortType.indexOf(value);
                    state.filterTabNames[0] = state.sortType[e].name;
                    dispatch(DiscoverPageActionCreator.onSortChanged(
                        state.sortType[e].value));
                    dispatch(DiscoverPageActionCreator.onRefreshData());
                  }),
                ),
                GZXDropdownMenuBuilder(
                  dropDownHeight: 0,
                  dropDownWidget: Container(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  });
}
