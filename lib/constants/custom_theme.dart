import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// inspired by https://github.com/RegNex/ProjectMgtTool_Flutter_Desktop/blob/master/lib/custom_theme.dart
/// light theme
ThemeData customLightTheme(
  BuildContext context,
) {
  return ThemeData(
      scaffoldBackgroundColor: Color.fromRGBO(240, 240, 240, 1),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      errorColor: Colors.red,
      platform: defaultTargetPlatform,
      primaryColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Color.fromRGBO(119, 12, 159, 1),
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(4.0),
            ),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color.fromRGBO(240, 240, 240, 1)),
      unselectedWidgetColor: Colors.grey,
      brightness: Brightness.light,
      fontFamily: GoogleFonts.lato().fontFamily,
      cardColor: Color.fromRGBO(255, 255, 255, 1),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(0),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Color.fromRGBO(240, 240, 240, 0.4),
        filled: true,
        alignLabelWithHint: true,
        hintStyle: Theme.of(context).textTheme.bodyText1,
        contentPadding: EdgeInsets.all(15.0),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 1)),
            borderRadius: BorderRadius.all(Radius.circular(0))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3)),
            borderRadius: BorderRadius.all(Radius.circular(0))),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(0))),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.withOpacity(.5)),
            borderRadius: BorderRadius.all(Radius.circular(0))),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(0))),
        labelStyle: Theme.of(context).textTheme.bodyText2,
        errorStyle:
            Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.red),
      ),
      iconTheme: IconThemeData(color: Colors.black),
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: Colors.black.withOpacity(.5),
      ),
      textTheme: Typography.material2018(platform: defaultTargetPlatform)
          .white
          .copyWith(
            bodyText1: TextStyle(color: Colors.black, fontSize: 16),
            bodyText2: TextStyle(color: Colors.black, fontSize: 14),
            caption: TextStyle(color: Colors.black, fontSize: 12),
            headline1: TextStyle(color: Colors.black, fontSize: 96),
            headline2: TextStyle(color: Colors.black, fontSize: 60),
            headline3: TextStyle(color: Colors.black, fontSize: 48),
            headline4: TextStyle(color: Colors.black, fontSize: 34),
            headline5: TextStyle(color: Colors.black, fontSize: 24),
            headline6: TextStyle(color: Colors.black, fontSize: 20),
            subtitle1: TextStyle(color: Colors.black, fontSize: 16),
            subtitle2: TextStyle(color: Colors.black, fontSize: 14),
            overline: TextStyle(color: Colors.black, fontSize: 10),
            button: TextStyle(color: Colors.black, fontSize: 16),
          ),
      dividerColor: Colors.grey);
}
