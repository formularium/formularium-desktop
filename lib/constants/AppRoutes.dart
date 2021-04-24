import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:formularium_desktop/core/InitRouterPage.dart';
import 'package:formularium_desktop/core/LoginPage.dart';
import 'package:formularium_desktop/core/RouteNotFoundPage.dart';
import 'package:formularium_desktop/core/onboarding/1_InstanceConfig.dart';
import 'package:formularium_desktop/pages/HomePage.dart';

class AppRoutes {
  static final routeNotFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        debugPrint("Route not found.");

        return RouteNotFoundPage();
      });

  static final dashboardRoute = AppRoute(
    '/dashboard',
    Handler(
      handlerFunc: (context, parameters) => HomePage(),
    ),
  );



  static final initRoute = AppRoute(
    '/',
    Handler(
      handlerFunc: (context, parameters) => InitRouterPage(),
    ),
  );

  // oauth login view
  static final loginRoute = AppRoute(
    '/login',
    Handler(
      handlerFunc: (context, parameters) => LoginPage(),
    ),
  );


  //setup instance
  static final setupInstanceConfig = AppRoute(
    '/setup/instanceConfig',
    Handler(
      handlerFunc: (context, parameters) => SetupInstanceConfig(),
    ),
  );


  static final List<AppRoute> routes = [
    initRoute,
    dashboardRoute,
    loginRoute,
    setupInstanceConfig
  ];
}