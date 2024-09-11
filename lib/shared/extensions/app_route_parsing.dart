import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/find_the_look/presentation/pages/ftl_home_page.dart';
import '../../features/find_the_look/presentation/pages/ftl_live_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/personality_finder/presentation/pages/pf_live_page.dart';
import '../../features/shop_the_look/presentation/pages/stl_live_page.dart';
import '../../features/skin_analysis/presentation/pages/sa_live_page.dart';
import '../../features/skin_tone_finder/presentation/pages/stf_live_page.dart';
import '../configs/route_config.dart';

extension AppRouteParsing on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.home:
        return '/';
      case AppRoute.ftlHome:
        return 'ftl_home';
      case AppRoute.ftlLive:
        return 'ftl_live';
      case AppRoute.saLive:
        return 'sa_live';
      case AppRoute.stfLive:
        return 'stf_live';
      case AppRoute.pfLive:
        return 'pf_live';
      case AppRoute.stlLive:
        return 'stl_live';
    }
  }

  Widget widget({
    Object? arguments,
  }) {
    switch (this) {
      case AppRoute.home:
        return const HomePage();
      case AppRoute.ftlHome:
        return const FTLHomePage();
      case AppRoute.ftlLive:
        FTLLivePageParams? params;
        if (arguments is FTLLivePageParams) {
          params = arguments;
        }

        return FTLLivePage(
          params: params,
        );
      case AppRoute.saLive:
        return const SALivePage();
      case AppRoute.stfLive:
        return const STFLivePage();
      case AppRoute.pfLive:
        return const PFLivePage();
      case AppRoute.stlLive:
        return const STLLivePage();
    }
  }

  GoRoute router({
    GlobalKey<NavigatorState>? parentNavigatorKey,
    List<RouteBase> routes = const [],
  }) {
    return GoRoute(
      path: path,
      name: name,
      routes: routes,
      parentNavigatorKey: parentNavigatorKey,
      builder: (context, state) {
        final extra = state.extra;

        return widget(
          arguments: extra,
        );
      },
    );
  }
}
