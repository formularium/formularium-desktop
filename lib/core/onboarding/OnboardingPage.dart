

import 'package:flutter/material.dart';

MaterialApp onboardingCardLayout(children, screenTitle, appbarTitle) {
  return MaterialApp(
      title: screenTitle,
      home: Scaffold(
          appBar: AppBar(
            title: Text(appbarTitle),
          ),
          body:Center(child: Container(
              width: 500,
              child: Card(
                  child: Column(mainAxisSize: MainAxisSize.min,
                      children: children
                      )
              )
          )
          )
      )
  );
}