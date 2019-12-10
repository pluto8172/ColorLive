import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:colorlive/models/combinedcredits.dart';
import 'package:colorlive/pages/peopledetail_page/components/gallery_component/component.dart';
import 'package:colorlive/pages/peopledetail_page/components/gallery_component/state.dart';
import 'package:colorlive/pages/peopledetail_page/components/header_component/component.dart';
import 'package:colorlive/pages/peopledetail_page/components/header_component/state.dart';
import 'package:colorlive/pages/peopledetail_page/components/knownfor_component/component.dart';
import 'package:colorlive/pages/peopledetail_page/components/knownfor_component/state.dart';
import 'package:colorlive/pages/peopledetail_page/components/personalinfo_component/component.dart';
import 'package:colorlive/pages/peopledetail_page/components/personalinfo_component/state.dart';
import 'package:colorlive/pages/peopledetail_page/components/timeline_component/component.dart';
import 'package:colorlive/pages/peopledetail_page/components/timeline_component/state.dart';

import '../state.dart';
import 'reducer.dart';

class PeopleAdapter extends DynamicFlowAdapter<PeopleDetailPageState> {
  PeopleAdapter()
      : super(
          pool: <String, Component<Object>>{
            'header': HeaderComponent(),
            'knownfor': KnownForComponent(),
            'timeline': TimeLineComponent(),
            'personalinfo': PersonalInfoComponent(),
            'gallery': GalleryComponent(),
          },
          connector: _PeopleConnector(),
          reducer: buildReducer(),
        );
}

class _PeopleConnector extends ConnOp<PeopleDetailPageState, List<ItemBean>> {
  @override
  List<ItemBean> get(PeopleDetailPageState state) {
    List<ItemBean> items = <ItemBean>[];
    items.add(ItemBean(
        'header',
        HeaderState(
            peopleid: state.peopleid,
            biography: state.peopleDetailModel.biography,
            profileName: state.profileName,
            profilePath: state.profilePath,
            character: state.character,
            deathday: state.peopleDetailModel.deathday,
            birthday: state?.peopleDetailModel?.birthday)));
    items.add(ItemBean(
        'personalinfo',
        PersonalInfoState(
            peopleDetailModel: state.peopleDetailModel,
            creditcount: state.creditsModel.cast.length +
                state.creditsModel.crew.length)));
    items.add(ItemBean('knownfor', KnownForState(cast: state.knowForCast)));
    items.add(ItemBean(
        'gallery', GalleryState(images: state.peopleDetailModel.images)));
    items.add(ItemBean(
        'timeline',
        TimeLineState(
            creditsModel: state.creditsModel,
            department: state.peopleDetailModel.known_for_department,
            showmovie: state.showmovie,
            scrollPhysics:
                PageScrollPhysics(parent: state.pageScrollPhysics))));

    return items;
  }

  @override
  void set(PeopleDetailPageState state, List<ItemBean> items) {
    TimeLineState d = items[4].data;
    state.showmovie = d.showmovie;
  }

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
