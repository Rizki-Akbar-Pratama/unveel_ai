import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../shared/configs/route_config.dart';
import '../../shared/extensions/app_route_parsing.dart';

abstract class AppRouteInfo {
  GlobalKey<NavigatorState> get navigatorKey;
  GoRouter get route;
}

class AppRouteInfoImpl implements AppRouteInfo {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  late final GoRouter _router = GoRouter(
    initialLocation: AppRoute.home.path,
    debugLogDiagnostics: kDebugMode,
    routerNeglect: true,
    navigatorKey: _navigatorKey,
    routes: [
      AppRoute.home.router(
        routes: [
          AppRoute.ftlHome.router(
            routes: [
              AppRoute.ftlLive.router(),
            ],
          ),
          AppRoute.saLive.router(),
          AppRoute.stfLive.router(),
          AppRoute.pfLive.router(),
          AppRoute.stlLive.router(),
        ],
      ),
    ],
  );

  @override
  GlobalKey<NavigatorState> get navigatorKey {
    return _navigatorKey;
  }

  @override
  GoRouter get route {
    return _router;
  }
}
