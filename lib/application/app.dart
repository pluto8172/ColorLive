import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart' hide Action;

import 'package:fish_redux/fish_redux.dart';
import 'package:colorlive/pages/account_page/page.dart';
import 'package:colorlive/pages/coming_page/page.dart';
import 'package:colorlive/pages/createlist_page/page.dart';
import 'package:colorlive/pages/discover_page/page.dart';
import 'package:colorlive/pages/episodedetail_page/page.dart';
import 'package:colorlive/pages/favorites_page/page.dart';
import 'package:colorlive/pages/gallery_page/page.dart';
import 'package:colorlive/pages/home_page/page.dart';
import 'package:colorlive/pages/listdetail_page/page.dart';
import 'package:colorlive/pages/login_page/page.dart';
import 'package:colorlive/pages/main_page/page.dart';
import 'package:colorlive/pages/moviedetail_page/page.dart';
import 'package:colorlive/pages/mylists_page/page.dart';
import 'package:colorlive/pages/peopledetail_page/page.dart';
import 'package:colorlive/pages/register_page/page.dart';
import 'package:colorlive/pages/seasondetail_page/page.dart';
import 'package:colorlive/pages/seasons_page/page.dart';
import 'package:colorlive/pages/steam_link_page/addlink_page/page.dart';
import 'package:colorlive/pages/steam_link_page/allstreamlink_page/page.dart';
import 'package:colorlive/pages/steam_link_page/livestream_page/page.dart';
import 'package:colorlive/pages/steam_link_page/season_link_page/page.dart';
import 'package:colorlive/pages/steam_link_page/steamlinks_page/page.dart';
import 'package:colorlive/pages/steam_link_page/tvshow_livestream_page/page.dart';
import 'package:colorlive/pages/test_page/page.dart';
import 'package:colorlive/pages/tvdetail_page/page.dart';
import 'package:colorlive/pages/watchlist_page/page.dart';
import 'package:colorlive/pages/watchlistdetail_page/page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../actions/timeline.dart';
import '../generated/i18n.dart';
import '../globalbasestate/state.dart';
import '../globalbasestate/store.dart';
import '../pages/moremedia_page/page.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:colorlive/pages/detail_page/page.dart' as detail;

Future _init() async {
  if (Platform.isAndroid)
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler()
            .requestPermissions([PermissionGroup.contacts]);
  /*SharedPreferences prefs = await SharedPreferences.getInstance();
  var session = prefs.getString('loginsession');
  String accessToken = prefs.getString('accessTokenV4');
  if (session == null) {
    await ApiHelper.createGuestSession();
  } else {
    ApiHelper.session = session;
  }
  if (accessToken != null) ApiHelper.accessTokenV4 = accessToken;*/
  //setLocaleInfo('zh', TimelineInfoCN());
  //setLocaleInfo('en', TimelineInfoEN());
}

Future<Widget> createApp() async {
  final AbstractRoutes routes = PageRoutes(
    pages: <String, Page<Object, dynamic>>{
      'mainpage': MainPage(),
      'homePage': HomePage(),
      'discoverPage': DiscoverPage(),
      'comingPage': ComingPage(),
      'accountPage': AccountPage(),
      'loginpage': LoginPage(),
      'moviedetailpage': MovieDetailPage(),
      'tvdetailpage': TVDetailPage(),
      'peopledetailpage': PeopleDetailPage(),
      'seasondetailpage': SeasonDetailPage(),
      'episodedetailpage': EpisodeDetailPage(),
      'MoreMediaPage': MoreMediaPage(),
      'SeasonsPage': SeasonsPage(),
      'MyListsPage': MyListsPage(),
      'ListDetailPage': ListDetailPage(),
      'FavoritesPage': FavoritesPage(),
      'WatchlistPage': WatchlistPage(),
      'WatchlistDetailPage': WatchlistDetailPage(),
      'detailpage': detail.MovieDetailPage(),
      'GalleryPage': GalleryPage(),
      'streamLinksPage': StreamLinksPage(),
      'addLinkPage': AddLinkPage(),
      'registerPage': RegisterPage(),
      'createListPage': CreateListPage(),
      'allStreamLinkPage': AllStreamLinkPage(),
      'liveStreamPage': LiveStreamPage(),
      'tvShowLiveStreamPage': TvShowLiveStreamPage(),
      'seasonLinkPage': SeasonLinkPage(),
      'testPage': TestPage(),
    },
    visitor: (String path, Page<Object, dynamic> page) {
      if (page.isTypeof<GlobalBaseState>()) {
        page.connectExtraStore<GlobalState>(GlobalStore.store,
            (Object pagestate, GlobalState appState) {
          final GlobalBaseState p = pagestate;
          if (p.themeColor != appState.themeColor ||
              p.locale != appState.locale ||
              p.user != appState.user) {
            if (pagestate is Cloneable) {
              final Object copy = pagestate.clone();
              final GlobalBaseState newState = copy;
              newState.themeColor = appState.themeColor;
              newState.locale = appState.locale;
              newState.user = appState.user;
              //I18n.onLocaleChanged(appState.locale);
              return newState;
            }
          }
          return pagestate;
        });
      }
      page.enhancer.append(
        /// View AOP
        viewMiddleware: <ViewMiddleware<dynamic>>[
          safetyView<dynamic>(),
        ],

        /// Adapter AOP
        adapterMiddleware: <AdapterMiddleware<dynamic>>[
          safetyAdapter<dynamic>()
        ],

        /// Effect AOP
        effectMiddleware: [
          _pageAnalyticsMiddleware<dynamic>(),
        ],

        /// Store AOP
        middleware: <Middleware<dynamic>>[
          logMiddleware<dynamic>(tag: page.runtimeType.toString()),
        ],
      );
    },
  );
  final ThemeData _lightTheme = ThemeData.light();
  final ThemeData _darkTheme = ThemeData.dark();
  await _init();

  void onLocaleChanged(Locale l) {
    I18n.locale = l;
  }

  I18n.onLocaleChanged = onLocaleChanged;
  return MaterialApp(
    title: 'ColorLive',
    debugShowCheckedModeBanner: false,
    theme: _lightTheme,
    darkTheme: _darkTheme,
    localizationsDelegates: [
      I18n.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: I18n.delegate.supportedLocales,
    localeResolutionCallback: I18n.delegate.resolution(fallback: new Locale("zh", "CN")),
    home: routes.buildPage('mainpage', {
      'pages': [
        routes.buildPage('homePage', null),
        routes.buildPage('discoverPage', null),
        routes.buildPage('comingPage', null),
        routes.buildPage('accountPage', null)
      ]
    }),
    onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute<Object>(builder: (BuildContext context) {
        return routes.buildPage(settings.name, settings.arguments);
      });
    },
  );
}

EffectMiddleware<T> _pageAnalyticsMiddleware<T>({String tag = 'redux'}) {
  return (AbstractLogic<dynamic> logic, Store<T> store) {
    return (Effect<dynamic> effect) {
      return (Action action, Context<dynamic> ctx) {
        if (logic is Page<dynamic, dynamic> && action.type is Lifecycle) {
          print('${logic.runtimeType} ${action.type.toString()} ');
        }
        return effect?.call(action, ctx);
      };
    };
  };
}
