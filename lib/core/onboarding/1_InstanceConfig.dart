import 'dart:convert';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:formularium_desktop/constants/AppRoutes.dart';
import 'package:formularium_desktop/models/AppRouter.dart';
import 'package:formularium_desktop/models/InstanceSettings.dart';
import 'package:formularium_desktop/services/PreferencesService.dart';

import '../../main.dart';


class SetupInstanceConfig extends StatefulWidget {
  @override
  _SetupInstanceConfig createState() => _SetupInstanceConfig();
}

class _SetupInstanceConfig extends State<SetupInstanceConfig> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Formularium Setup: Instance Config",
        home: Scaffold(
          appBar: AppBar(
            title: Text('Instance Configuration'),
          ),
          body:  Center(
            child:
            ElevatedButton(
              onPressed: () => _openFileExplorer(),
              child: const Text("Open file picker"),
            ),
          ),
        ));
  }

  void _openFileExplorer() async {
    final typeGroup = XTypeGroup(label: 'formularium-configs', extensions: ['formularium']);
    final file = await openFile(acceptedTypeGroups: [typeGroup]);
    if(file != null){
      String config = await file.readAsString();
      getIt<PreferencesService>().instanceSettings = InstanceSettings.fromJson(json.decode(config));
      print('(TRACE) _SetupInstanceConfig:_openFileExplorer. $config');
      var status = getIt<PreferencesService>().instanceStatus;
      status.isConfigured =true;
      getIt<PreferencesService>().instanceStatus = status;
      AppRouter.router.navigateTo(
        context,
        AppRoutes.initRoute.route,
      );
    }
  }
}