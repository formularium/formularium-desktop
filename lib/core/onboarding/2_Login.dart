import 'package:flutter/material.dart';
import 'package:formularium_desktop/constants/AppRoutes.dart';
import 'package:formularium_desktop/models/AppRouter.dart';
import 'package:formularium_desktop/services/OauthService.dart';
import 'package:formularium_desktop/services/PreferencesService.dart';

import '../../main.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Login",
        home: Scaffold(
            appBar: AppBar(
              title: Text('Login to formularium'),
            ),
            body: Center(
                child: ElevatedButton(onPressed:  () => oauthLogin(context), child: Text("Login"))
            )
        ));
  }

  void oauthLogin(context) async {
    OauthService oa = await OauthService.setup(getIt<PreferencesService>().instanceSettings);
    await oa.authorize();
    var status = getIt<PreferencesService>().instanceStatus;
    status.isLoggedIn =true;
    getIt<PreferencesService>().instanceStatus = status;
    AppRouter.router.navigateTo(
      context,
      AppRoutes.initRoute.route,
    );
  }
}