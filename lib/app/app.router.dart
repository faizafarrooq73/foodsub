// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i15;
import 'package:flutter/material.dart';
import 'package:food_sub/ui/views/booknow/booknow_view.dart' as _i9;
import 'package:food_sub/ui/views/chat/allchats/allchats_view.dart' as _i10;
import 'package:food_sub/ui/views/chat/chating/chating_view.dart' as _i11;
import 'package:food_sub/ui/views/customerspecials/promotion/addpromotions/addpromotions_view.dart'
    as _i14;
import 'package:food_sub/ui/views/customerspecials/promotion/showpromotions/showpromotions_view.dart'
    as _i13;
import 'package:food_sub/ui/views/customerspecials/showdeals/showdeals_view.dart'
    as _i12;
import 'package:food_sub/ui/views/home/home_view.dart' as _i2;
import 'package:food_sub/ui/views/loginsignup/loginsignup_view.dart' as _i4;
import 'package:food_sub/ui/views/menuselection/menuselection_view.dart' as _i8;
import 'package:food_sub/ui/views/provider/provider_view.dart' as _i5;
import 'package:food_sub/ui/views/rider/rider_view.dart' as _i6;
import 'package:food_sub/ui/views/riderprovider/riderprovider_view.dart' as _i7;
import 'package:food_sub/ui/views/startup/startup_view.dart' as _i3;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i16;

class Routes {
  static const homeView = '/home-view';

  static const startupView = '/startup-view';

  static const loginsignupView = '/loginsignup-view';

  static const providerView = '/provider-view';

  static const riderView = '/rider-view';

  static const riderproviderView = '/riderprovider-view';

  static const menuselectionView = '/menuselection-view';

  static const booknowView = '/booknow-view';

  static const allchatsView = '/allchats-view';

  static const chatingView = '/chating-view';

  static const showdealsView = '/showdeals-view';

  static const showpromotionsView = '/showpromotions-view';

  static const addpromotionsView = '/addpromotions-view';

  static const all = <String>{
    homeView,
    startupView,
    loginsignupView,
    providerView,
    riderView,
    riderproviderView,
    menuselectionView,
    booknowView,
    allchatsView,
    chatingView,
    showdealsView,
    showpromotionsView,
    addpromotionsView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.startupView,
      page: _i3.StartupView,
    ),
    _i1.RouteDef(
      Routes.loginsignupView,
      page: _i4.LoginsignupView,
    ),
    _i1.RouteDef(
      Routes.providerView,
      page: _i5.ProviderView,
    ),
    _i1.RouteDef(
      Routes.riderView,
      page: _i6.RiderView,
    ),
    _i1.RouteDef(
      Routes.riderproviderView,
      page: _i7.RiderproviderView,
    ),
    _i1.RouteDef(
      Routes.menuselectionView,
      page: _i8.MenuselectionView,
    ),
    _i1.RouteDef(
      Routes.booknowView,
      page: _i9.BooknowView,
    ),
    _i1.RouteDef(
      Routes.allchatsView,
      page: _i10.AllchatsView,
    ),
    _i1.RouteDef(
      Routes.chatingView,
      page: _i11.ChatingView,
    ),
    _i1.RouteDef(
      Routes.showdealsView,
      page: _i12.ShowdealsView,
    ),
    _i1.RouteDef(
      Routes.showpromotionsView,
      page: _i13.ShowpromotionsView,
    ),
    _i1.RouteDef(
      Routes.addpromotionsView,
      page: _i14.AddpromotionsView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.StartupView: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.StartupView(),
        settings: data,
      );
    },
    _i4.LoginsignupView: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.LoginsignupView(),
        settings: data,
      );
    },
    _i5.ProviderView: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.ProviderView(),
        settings: data,
      );
    },
    _i6.RiderView: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.RiderView(),
        settings: data,
      );
    },
    _i7.RiderproviderView: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.RiderproviderView(),
        settings: data,
      );
    },
    _i8.MenuselectionView: (data) {
      final args = data.getArgs<MenuselectionViewArguments>(nullOk: false);
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i8.MenuselectionView(key: args.key, number: args.number),
        settings: data,
      );
    },
    _i9.BooknowView: (data) {
      final args = data.getArgs<BooknowViewArguments>(nullOk: false);
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.BooknowView(
            key: args.key, acess: args.acess, appbarshow: args.appbarshow),
        settings: data,
      );
    },
    _i10.AllchatsView: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.AllchatsView(),
        settings: data,
      );
    },
    _i11.ChatingView: (data) {
      final args = data.getArgs<ChatingViewArguments>(nullOk: false);
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i11.ChatingView(key: args.key, id: args.id, did: args.did),
        settings: data,
      );
    },
    _i12.ShowdealsView: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i12.ShowdealsView(),
        settings: data,
      );
    },
    _i13.ShowpromotionsView: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i13.ShowpromotionsView(),
        settings: data,
      );
    },
    _i14.AddpromotionsView: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i14.AddpromotionsView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class MenuselectionViewArguments {
  const MenuselectionViewArguments({
    this.key,
    required this.number,
  });

  final _i15.Key? key;

  final String number;

  @override
  String toString() {
    return '{"key": "$key", "number": "$number"}';
  }

  @override
  bool operator ==(covariant MenuselectionViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.number == number;
  }

  @override
  int get hashCode {
    return key.hashCode ^ number.hashCode;
  }
}

class BooknowViewArguments {
  const BooknowViewArguments({
    this.key,
    required this.acess,
    this.appbarshow = true,
  });

  final _i15.Key? key;

  final String acess;

  final bool appbarshow;

  @override
  String toString() {
    return '{"key": "$key", "acess": "$acess", "appbarshow": "$appbarshow"}';
  }

  @override
  bool operator ==(covariant BooknowViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.acess == acess &&
        other.appbarshow == appbarshow;
  }

  @override
  int get hashCode {
    return key.hashCode ^ acess.hashCode ^ appbarshow.hashCode;
  }
}

class ChatingViewArguments {
  const ChatingViewArguments({
    this.key,
    required this.id,
    required this.did,
  });

  final _i15.Key? key;

  final String id;

  final String did;

  @override
  String toString() {
    return '{"key": "$key", "id": "$id", "did": "$did"}';
  }

  @override
  bool operator ==(covariant ChatingViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.id == id && other.did == did;
  }

  @override
  int get hashCode {
    return key.hashCode ^ id.hashCode ^ did.hashCode;
  }
}

extension NavigatorStateExtension on _i16.NavigationService {
  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginsignupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginsignupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProviderView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.providerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRiderView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.riderView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRiderproviderView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.riderproviderView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMenuselectionView({
    _i15.Key? key,
    required String number,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.menuselectionView,
        arguments: MenuselectionViewArguments(key: key, number: number),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBooknowView({
    _i15.Key? key,
    required String acess,
    bool appbarshow = true,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.booknowView,
        arguments: BooknowViewArguments(
            key: key, acess: acess, appbarshow: appbarshow),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAllchatsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.allchatsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChatingView({
    _i15.Key? key,
    required String id,
    required String did,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.chatingView,
        arguments: ChatingViewArguments(key: key, id: id, did: did),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToShowdealsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.showdealsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToShowpromotionsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.showpromotionsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddpromotionsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.addpromotionsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginsignupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginsignupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProviderView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.providerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRiderView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.riderView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRiderproviderView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.riderproviderView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMenuselectionView({
    _i15.Key? key,
    required String number,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.menuselectionView,
        arguments: MenuselectionViewArguments(key: key, number: number),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBooknowView({
    _i15.Key? key,
    required String acess,
    bool appbarshow = true,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.booknowView,
        arguments: BooknowViewArguments(
            key: key, acess: acess, appbarshow: appbarshow),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAllchatsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.allchatsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChatingView({
    _i15.Key? key,
    required String id,
    required String did,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.chatingView,
        arguments: ChatingViewArguments(key: key, id: id, did: did),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithShowdealsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.showdealsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithShowpromotionsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.showpromotionsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddpromotionsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.addpromotionsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
