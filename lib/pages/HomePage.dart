import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formularium_desktop/constants/AppRoutes.dart';
import 'package:formularium_desktop/models/AppRouter.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Home Page",
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              "Fluro routing examples",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () => AppRouter.router.navigateTo(
                context,
                AppRoutes.loginRoute.route,
              ),
              child: const Text("Contact List"),
            )
          ],
        ),
      ),
    );
  }
}