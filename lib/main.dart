import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formularium_desktop/services/GraphQLService.dart';
import 'package:formularium_desktop/services/PreferencesService.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'constants/AppRoutes.dart';
import 'models/AppRouter.dart';

final getIt = GetIt.instance;



Future setupGetIt() async {
  var prefinstance = await PreferencesService.getInstance();
  getIt.registerSingleton<PreferencesService>(prefinstance);

  var gqlistace = await GraphQLService.getInstance();
  getIt.registerSingleton<GraphQLService>(gqlistace);

}

void main() async{
  await initHiveForFlutter();
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