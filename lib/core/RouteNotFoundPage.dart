import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formularium_desktop/constants/AppRoutes.dart';
import 'package:formularium_desktop/models/AppRouter.dart';

class RouteNotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Route not found"),
            TextButton(
              onPressed: () => AppRouter.router.navigateTo(
                context,
                AppRoutes.dashboardRoute.route,
                replace: true,
                clearStack: true,
                transition: TransitionType.none,
              ),
              child: const Text("Go Home"),
            )
          ],
        ),
      ),
    );
  }
}