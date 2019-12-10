import 'dart:math';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:colorlive/actions/Adapt.dart';
import 'package:colorlive/actions/imageurl.dart';
import 'package:colorlive/customwidgets/keepalive_widget.dart';
import 'package:colorlive/generated/i18n.dart';
import 'package:colorlive/models/enums/genres.dart';
import 'package:colorlive/models/enums/imagesize.dart';
import 'package:colorlive/models/videolist.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ComingPageState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    final _lightTheme = ThemeData.light().copyWith(
        backgroundColor: Colors.white,
        tabBarTheme: TabBarTheme(
            labelColor: Colors.black, unselectedLabelColor: Colors.grey));
    final _darkTheme = ThemeData.dark().copyWith(
        backgroundColor: Color(0xFF303030),
        tabBarTheme: TabBarTheme(
            labelColor: Colors.white, unselectedLabelColor: Colors.grey));
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    final ThemeData _theme = _mediaQuery.platformBrightness == Brightness.light
        ? _lightTheme
        : _darkTheme;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            brightness: _theme.brightness,
            title: Container(
                child: TabBar(
              onTap: (i) {
                if (i == 0)
                  dispatch(ComingPageActionCreator.onFilterChanged(true));
                else
                  dispatch(ComingPageActionCreator.onFilterChanged(false));
              },
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: _theme.tabBarTheme.labelColor,
              labelColor: _theme.tabBarTheme.labelColor,
              unselectedLabelColor: _theme.tabBarTheme.unselectedLabelColor,
              labelStyle: TextStyle(
                  fontSize: Adapt.px(35), fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(color: Colors.grey),
              tabs: <Widget>[
                Tab(
                  text: I18n.of(viewService.context).movies,
                ),
                Tab(
                  text: I18n.of(viewService.context).tvShows,
                )
              ],
            )),
            backgroundColor: _theme.backgroundColor,
            elevation: 0.0,
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              viewService.buildComponent('movielist'),
              viewService.buildComponent('tvlist'),
            ],
          )),
    );
  });
}
