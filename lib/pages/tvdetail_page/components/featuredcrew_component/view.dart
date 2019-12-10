import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:colorlive/actions/Adapt.dart';
import 'package:colorlive/generated/i18n.dart';
import 'package:colorlive/models/tvdetail.dart';

import 'state.dart';

Widget buildView(
    FeatureCrewState state, Dispatch dispatch, ViewService viewService) {
  Widget _buildCreatorCell(CreatedBy d) {
    return Container(
      width: Adapt.px(350),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(d.name,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: Adapt.px(28)),),
          Text(I18n.of(viewService.context).creator,style: TextStyle(color: Colors.black87,fontSize: Adapt.px(24)))
        ],
      ),
    );
  }
  Widget _buildBody() {
    if (state.createdBy.length > 0)
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(Adapt.px(30)),
              child: Text(I18n.of(viewService.context).featuredCrew,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Adapt.px(40),
                      fontWeight: FontWeight.w800)),
            ),
            Padding(
              padding: EdgeInsets.only(left: Adapt.px(30)),
              child: Wrap(
                runSpacing: Adapt.px(30),
                children: state.createdBy.map(_buildCreatorCell).toList(),
              ),
            )
          ],
        ),
      );
    else
      return Container();
  }

  return _buildBody();
}
