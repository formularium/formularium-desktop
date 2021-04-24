import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formularium_desktop/services/PreferencesService.dart';
import 'package:get_it/get_it.dart';

import 'constants/AppRoutes.dart';
import 'models/AppRouter.dart';

final getIt = GetIt.instance;



Future setupGetIt() async {
  var instance = await PreferencesService.getInstance();
  getIt.registerSingleton<PreferencesService>(instance);
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    AppRouter appRouter = AppRouter(
      routes: AppRoutes.routes,
      notFoundHandler: AppRoutes.routeNotFoundHandler,
    );

    appRouter.setupRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formularium Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      onGenerateRoute: AppRouter.router.generator,
      debugShowCheckedModeBanner: false,
    );
  }
}