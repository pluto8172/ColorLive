import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:colorlive/actions/Adapt.dart';
import 'package:colorlive/actions/imageurl.dart';
import 'package:colorlive/models/enums/imagesize.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PeopleDetailPageState state, Dispatch dispatch, ViewService viewService) {
  var adapter = viewService.buildAdapter();
  return Scaffold(
    //backgroundColor: Colors.grey[100],
    body: Stack(
      alignment: Alignment.topRight,
      children: <Widget>[
        MediaQuery.removePadding(
          context: viewService.context,
          removeTop: true,
          child: ListView.builder(
            itemBuilder: adapter.itemBuilder,
            itemCount: adapter.itemCount,
            physics: state.pageScrollPhysics,
          ),
        ),
        SafeArea(
          child: Container(
            margin: EdgeInsets.only(right: Adapt.px(30)),
            width: Adapt.px(60),
            height: Adapt.px(60),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.black38),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () => Navigator.of(viewService.context).pop(),
              icon: Icon(Icons.close),
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
