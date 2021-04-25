import 'package:flutter/material.dart';
import 'package:formularium_desktop/constants/AppRoutes.dart';
import 'package:formularium_desktop/models/AppRouter.dart';
import 'package:formularium_desktop/services/GraphQLService.dart';
import 'package:formularium_desktop/services/OauthService.dart';
import 'package:formularium_desktop/services/PreferencesService.dart';

import '../../main.dart';
import 'OnboardingPage.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() {
    return _LoginPage();
  }
}


class _LoginPage extends State<LoginPage>  {

  String title;
  String loginHint;
  @override
  Widget build(BuildContext context) {
    this.title = getIt<PreferencesService>().instanceSettings.instance.name;
    this.loginHint = getIt<PreferencesService>().instanceSettings.instance.loginHint;

    return onboardingCardLayout(<Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
          child:  ListTile(
            title: Text(this.title),
            subtitle: Text(this.loginHint),
          )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: ElevatedButton(onPressed:  () => oauthLogin(context), child: Text("Login"))
        )
    ],
        "Login", "Login to $title");
  }

  void oauthLogin(context) async {
    OauthService oa = await OauthService.setup(getIt<PreferencesService>().instanceSettings);
    await oa.authorize();
    await getIt<GraphQLService>().reloadSettings();
    var status = getIt<PreferencesService>().instanceStatus;
    status.isLoggedIn =true;
    getIt<PreferencesService>().instanceStatus = status;
    AppRouter.router.navigateTo(
      context,
      AppRoutes.initRoute.route,
    );
  }
}