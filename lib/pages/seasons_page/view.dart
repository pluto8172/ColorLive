import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:colorlive/actions/Adapt.dart';
import 'package:colorlive/actions/imageurl.dart';
import 'package:colorlive/generated/i18n.dart';
import 'package:colorlive/models/enums/imagesize.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    SeasonsPageState state, Dispatch dispatch, ViewService viewService) {
  
  Random random=Random(DateTime.now().millisecondsSinceEpoch);

  Widget _buildCell(int index) {
    var d = state.seasons[index];
    var curve = CurvedAnimation(
      parent: state.animationController,
      curve: Interval(
        index * (1.0 / state.seasons.length),
        (index + 1) * (1.0 / state.seasons.length),
        curve: Curves.ease,
      ),
    );
    return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset.zero).animate(curve),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curve),
          child: Padding(
            padding: EdgeInsets.only(bottom: Adapt.px(20)),
            child: GestureDetector(
              onTap: () => dispatch(SeasonsPageActionCreator.onCellTapped(
                  state.tvid, d.season_number, d.name, d.poster_path)),
              child: Card(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: Adapt.px(225),
                      height: Adapt.px(380),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(random.nextInt(255), random.nextInt(255), random.nextInt(255), random.nextDouble()),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(d.poster_path==null?ImageUrl.emptyimage: ImageUrl.getUrl(
                                  d.poster_path, ImageSize.w300)))),
                    ),
                    SizedBox(
                      width: Adapt.px(20),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: Adapt.px(20),
                        ),
                        Container(
                          width: Adapt.screenW() - Adapt.px(320),
                          child: Text(
                            d.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Adapt.px(30)),
                          ),
                        ),
                        SizedBox(
                          height: Adapt.px(5),
                        ),
                        Text('Air Date: ${d.air_date}'),
                        SizedBox(
                          height: Adapt.px(5),
                        ),
                        Text('Episode Count: ${d.episode_count}'),
                        SizedBox(
                          height: Adapt.px(10),
                        ),
                        Container(
                          width: Adapt.screenW() - Adapt.px(320),
                          child: Text(
                            d.overview == null || d.overview == ''
                                ? 'No overview have been added'
                                : d.overview,
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                            //style: TextStyle(height: 1.2),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  return Scaffold(
    appBar: AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        'All Seasons',
        style: TextStyle(color: Colors.black),
      ),
    ),
    body: Padding(
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(20)),
      child: ListView.builder(
        itemCount: state.seasons.length,
        itemBuilder: (ctx, index) {
          return _buildCell(index);
        },
      ),
    ),
  );
}
