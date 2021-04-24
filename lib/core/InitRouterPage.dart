
import 'package:flutter/material.dart';
import 'package:formularium_desktop/constants/AppRoutes.dart';
import 'package:formularium_desktop/models/AppRouter.dart';
import 'package:formularium_desktop/models/InstanceStatus.dart';
import 'package:formularium_desktop/services/PreferencesService.dart';

import '../main.dart';

class InitRouterPage extends StatelessWidget {

  Future _routeToStart(BuildContext context) async {
    InstanceStatus status;
    // if there is no instance status object => create it
    if(getIt<PreferencesService>().instanceStatus == null ){
      status = InstanceStatus();
      status.isLoggedIn = false;
      status.isConfigured = false;
      status.hasPGPKey = false;
      getIt<PreferencesService>().instanceStatus = status;
    } else{
      status = getIt<PreferencesService>().instanceStatus;
    }


    // check user onboarding status
    if(status.isConfigured == false) {
      AppRouter.router.navigateTo(
        context,
        AppRoutes.setupInstanceConfig.route,
      );
    }else if(getIt<PreferencesService>().instanceStatus.isLoggedIn){

    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => this._routeToStart(context));
    return MaterialApp(
        title: "Formularium",
        home: Scaffold(
            appBar: AppBar(
              title: Text('Formularium'),
            ),
          body:  Center(
              child:
                CircularProgressIndicator(
                  semanticsLabel: 'Linear progress indicator',
                ),
            ),
        ));
  }
}