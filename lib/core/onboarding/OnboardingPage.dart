import 'package:flutter/material.dart';

Scaffold onboardingCardLayout(children, screenTitle, appbarTitle) {
  return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(appbarTitle),
      ),
      body: Center(
          child: Container(
              width: 500,
              child: Card(
                  child: Column(
                      mainAxisSize: MainAxisSize.min, children: children)))));
}
