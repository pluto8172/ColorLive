import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes
// ignore_for_file: unnecessary_brace_in_string_interps

//WARNING: This file is automatically generated. DO NOT EDIT, all your changes would be lost.

typedef LocaleChangeCallback = void Function(Locale locale);

class I18n implements WidgetsLocalizations {
  const I18n();

  static Locale _locale;
  static bool _shouldReload = false;

  static set locale(Locale newLocale) {
    _shouldReload = true;
    I18n._locale = newLocale;
  }

  static const GeneratedLocalizationsDelegate delegate =
      GeneratedLocalizationsDelegate();

  /// function to be invoked when changing the language
  static LocaleChangeCallback onLocaleChanged;

  static I18n of(BuildContext context) =>
      Localizations.of<I18n>(context, WidgetsLocalizations);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  /// "ColorLive"
  String get appname => "ColorLive";

  /// "Search for a movie,tv show,person"
  String get searchbartxt => "Search for a movie,tv show,person";

  /// "Home"
  String get home => "Home";

  /// "Discover"
  String get discover => "Discover";

  /// "Coming"
  String get coming => "Coming";

  /// "Account"
  String get account => "Account";

  /// "In Theaters"
  String get inTheaters => "In Theaters";

  /// "On TV"
  String get onTV => "On TV";

  /// "OverView"
  String get overView => "OverView";

  /// "Top Billed Cast"
  String get topBilledCast => "Top Billed Cast";

  /// "User Score"
  String get userScore => "User Score";

  /// "Play Trailer"
  String get playTrailer => "Play Trailer";

  /// "Main"
  String get main => "Main";

  /// "Videos"
  String get videos => "Videos";

  /// "Images"
  String get images => "Images";

  /// "Reviews"
  String get reviews => "Reviews";

  /// "Tags"
  String get tags => "Tags";

  /// "Recommendations"
  String get recommendations => "Recommendations";

  /// "Biography"
  String get biography => "Biography";

  /// "Known For"
  String get knownFor => "Known For";

  /// "Acting"
  String get acting => "Acting";

  /// "Movies"
  String get movies => "Movies";

  /// "TV Shows"
  String get tvShows => "TV Shows";

  /// "Personal Info"
  String get personalInfo => "Personal Info";

  /// "Gender"
  String get gender => "Gender";

  /// "Birthday"
  String get birthday => "Birthday";

  /// "Known Credits"
  String get knownCredits => "Known Credits";

  /// "Place of Birth"
  String get placeOfBirth => "Place of Birth";

  /// "official Site"
  String get officialSite => "official Site";

  /// "Also Known As"
  String get alsoKnownAs => "Also Known As";

  /// "Sort By"
  String get sortBy => "Sort By";

  /// "Filter"
  String get filter => "Filter";

  /// "Watchlist"
  String get watchlist => "Watchlist";

  /// "Lists"
  String get lists => "Lists";

  /// "Favorites"
  String get favorites => "Favorites";

  /// "Ratings&Reviews"
  String get ratingsReviews => "Ratings&Reviews";

  /// "Popular"
  String get popular => "Popular";

  /// "More"
  String get more => "More";

  /// "Featured Crew"
  String get featuredCrew => "Featured Crew";

  /// "Creator"
  String get creator => "Creator";

  /// "Current Season"
  String get currentSeason => "Current Season";

  /// "View All Seasons"
  String get viewAllSeasons => "View All Seasons";

  /// "Season Detail"
  String get seasonDetail => "Season Detail";

  /// "Season Cast"
  String get seasonCast => "Season Cast";

  /// "Episodes"
  String get episodes => "Episodes";

  /// "Guest Stars"
  String get guestStars => "Guest Stars";

  /// "No guest star have been added"
  String get guestStarsEmpty => "No guest star have been added";

  /// "Crew"
  String get crew => "Crew";

  /// "No crew have been added"
  String get crewEmpty => "No crew have been added";

  /// "Episode Images"
  String get episodeImages => "Episode Images";

  /// "No episode image have been added"
  String get episodeImagesEmpty => "No episode image have been added";

  /// "Facts"
  String get facts => "Facts";

  /// "Network"
  String get network => "Network";

  /// "Status"
  String get status => "Status";

  /// "Type"
  String get type => "Type";

  /// "Original Language"
  String get originalLanguage => "Original Language";

  /// "Runtime"
  String get runtime => "Runtime";

  /// "Genders"
  String get genders => "Genders";

  /// "Release Information"
  String get releaseInformation => "Release Information";

  /// "Budget"
  String get budget => "Budget";

  /// "Revenue"
  String get revenue => "Revenue";

  /// "Company"
  String get company => "Company";

  /// "Play"
  String get play => "Play";
}

class _I18n_en_US extends I18n {
  const _I18n_en_US();

  @override
  TextDirection get textDirection => TextDirection.ltr;
}

class _I18n_zh_CN extends I18n {
  const _I18n_zh_CN();

  /// "电影"
  @override
  String get appname => "多彩";

  /// "搜索电影、电视剧、演员"
  @override
  String get searchbartxt => "搜索电影、电视剧、演员";

  /// "主页"
  @override
  String get home => "主页";

  /// "发现"
  @override
  String get discover => "发现";

  /// "预播"
  @override
  String get coming => "预播";

  /// "账号"
  @override
  String get account => "账号";

  /// "上映中"
  @override
  String get inTheaters => "上映中";

  /// "放送中"
  @override
  String get onTV => "放送中";

  /// "概要"
  @override
  String get overView => "概要";

  /// "主要演员"
  @override
  String get topBilledCast => "主要演员";

  /// "用户评分"
  @override
  String get userScore => "用户评分";

  /// "播放预告"
  @override
  String get playTrailer => "播放预告";

  /// "主要"
  @override
  String get main => "主要";

  /// "视频"
  @override
  String get videos => "视频";

  /// "图片"
  @override
  String get images => "图片";

  /// "评论"
  @override
  String get reviews => "评论";

  /// "标签"
  @override
  String get tags => "标签";

  /// "推荐"
  @override
  String get recommendations => "推荐";

  /// "经历"
  @override
  String get biography => "经历";

  /// "被认识"
  @override
  String get knownFor => "被认识";

  /// "Acting"
  @override
  String get acting => "Acting";

  /// "电影"
  @override
  String get movies => "电影";

  /// "电视剧"
  @override
  String get tvShows => "电视剧";

  /// "个人信息"
  @override
  String get personalInfo => "个人信息";

  /// "性别"
  @override
  String get gender => "性别";

  /// "生日"
  @override
  String get birthday => "生日";

  /// "作品"
  @override
  String get knownCredits => "作品";

  /// "出生地"
  @override
  String get placeOfBirth => "出生地";

  /// "个人主页"
  @override
  String get officialSite => "个人主页";

  /// "被称为"
  @override
  String get alsoKnownAs => "被称为";

  /// "排序"
  @override
  String get sortBy => "排序";

  /// "过滤"
  @override
  String get filter => "过滤";

  /// "待看清单"
  @override
  String get watchlist => "待看清单";

  /// "收藏表"
  @override
  String get lists => "收藏表";

  /// "我的最爱"
  @override
  String get favorites => "我的最爱";

  /// "评分"
  @override
  String get ratingsReviews => "评分";

  /// "热门"
  @override
  String get popular => "热门";

  /// "更多"
  @override
  String get more => "更多";

  /// "主创人员"
  @override
  String get featuredCrew => "主创人员";

  /// "创作者"
  @override
  String get creator => "创作者";

  /// "当前季"
  @override
  String get currentSeason => "当前季";

  /// "所有剧集"
  @override
  String get viewAllSeasons => "所有剧集";

  /// "剧集详情"
  @override
  String get seasonDetail => "剧集详情";

  /// "零时演员"
  @override
  String get seasonCast => "零时演员";

  /// "情节"
  @override
  String get episodes => "情节";

  /// "客串演员"
  @override
  String get guestStars => "客串演员";

  /// "暂无演员"
  @override
  String get guestStarsEmpty => "暂无演员";

  /// "群众演员"
  @override
  String get crew => "群众演员";

  /// "暂无群演"
  @override
  String get crewEmpty => "暂无群演";

  /// "插曲"
  @override
  String get episodeImages => "插曲";

  /// "暂无插曲"
  @override
  String get episodeImagesEmpty => "暂无插曲";

  /// "事实"
  @override
  String get facts => "事实";

  /// "网络"
  @override
  String get network => "网络";

  /// "状态"
  @override
  String get status => "状态";

  /// "类型"
  @override
  String get type => "类型";

  /// "语言"
  @override
  String get originalLanguage => "语言";

  /// "启动"
  @override
  String get runtime => "启动";

  /// "性别"
  @override
  String get genders => "性别";

  /// "版权信息"
  @override
  String get releaseInformation => "版权信息";

  /// "预算"
  @override
  String get budget => "预算";

  /// "收入"
  @override
  String get revenue => "收入";

  /// "公司"
  @override
  String get company => "公司";

  /// "播放"
  @override
  String get play => "播放";

  @override
  TextDirection get textDirection => TextDirection.ltr;
}



class GeneratedLocalizationsDelegate
    extends LocalizationsDelegate<WidgetsLocalizations> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale("en", "US"),
      Locale("zh", "CN"),
    ];
  }

  LocaleResolutionCallback resolution({Locale fallback}) {
    return (Locale locale, Iterable<Locale> supported) {
      if (isSupported(locale)) {
        return locale;
      }
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    };
  }

  @override
  Future<WidgetsLocalizations> load(Locale locale) {
    I18n._locale ??= locale;
    I18n._shouldReload = false;
    final String lang = I18n._locale != null ? I18n._locale.toString() : "";
    final String languageCode =
        I18n._locale != null ? I18n._locale.languageCode : "";
    if ("en_US" == lang) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_en_US());
    } else if ("zh_CN" == lang) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_zh_CN());
    } else if ("en" == languageCode) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_en_US());
    } else if ("zh" == languageCode) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_zh_CN());
    }

    return SynchronousFuture<WidgetsLocalizations>(const I18n());
  }

  @override
  bool isSupported(Locale locale) {
    for (var i = 0; i < supportedLocales.length && locale != null; i++) {
      final l = supportedLocales[i];
      if (l.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => I18n._shouldReload;
}
