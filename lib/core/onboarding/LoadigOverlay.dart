import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadigOverlay extends StatelessWidget {
  LoadigOverlay({Key key, this.loadingTxt: 'Loading...'}) : super(key: key);

  final String loadingTxt;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
            child: Stack(children: <Widget>[
              Center(
                  child: Column(children: <Widget>[
                Container(
                  child: CircularProgressIndicator(
                    semanticsLabel: 'Linear progress indicator',
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Text(loadingTxt, style: TextStyle(fontSize: 18)),
                ),
              ]))
            ])
        )
    );
  }
}
