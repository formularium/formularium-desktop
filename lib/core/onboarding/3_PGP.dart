import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:formularium_desktop/constants/AppRoutes.dart';
import 'package:formularium_desktop/constants/GraphQL.dart';
import 'package:formularium_desktop/models/AppRouter.dart';
import 'package:formularium_desktop/services/GraphQLService.dart';
import 'package:formularium_desktop/services/PGPService.dart';
import 'package:formularium_desktop/services/PreferencesService.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../main.dart';
import 'LoadigOverlay.dart';
import 'OnboardingPage.dart';

class PGPSetupPage extends StatefulWidget {
  @override
  _PGPSetupPage createState() {
    return _PGPSetupPage();
  }
}

class _PGPSetupPage extends State<PGPSetupPage> {
  String _spinner;
  final _formKey = GlobalKey<FormState>();
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);

  String password;
  @override
  Widget build(BuildContext context) {
    return onboardingCardLayout(<Widget>[
      Container(
          child: _spinner != null
              ? LoadigOverlay(loadingTxt: _spinner)
              : Form(
                  key: _formKey,
                  child: Stack(children: <Widget>[
                    Column(
                      children: getIt<PreferencesService>().instanceSettings.pgpPasswordRequired  ? <Widget>[
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 16),
                            child: const ListTile(
                              title: Text('Create your Encryption Key'),
                              subtitle: Text(
                                  'Please enter the password you want to use to unlock your encryption key.'),
                            )),

                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Password',
                              ),
                              onChanged: (val) => password = val,
                              // assign the the multi validator to the TextFormField validator
                              validator: this.passwordValidator,
                            )),

                        // using the match validator to confirm password
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Repeat Password',
                              ),
                              validator: (val) => MatchValidator(
                                      errorText: 'passwords do not match')
                                  .validateMatch(val, password),
                            )),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            child: ElevatedButton(
                                onPressed: () => generateKey(context),
                                child: Text("Generate Key")))
                      ] : [
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 16),
                            child: const ListTile(
                              title: Text('Create your Encryption Key'),
                              subtitle: Text(
                                  'No we need to create your encryption key. This can take a few seconds'),
                            )),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            child: ElevatedButton(
                                onPressed: () => generateKey(context),
                                child: Text("Generate Key")))
                      ],
                    ),
                  ])))
    ], "Login", 'Setup your Encryption Key');
  }

  void generateKey(context) async {
    if (_formKey.currentState.validate() || getIt<PreferencesService>().instanceSettings.pgpPasswordRequired == false) {
      setState(() {
        _spinner = "Fetching user information";
      });
      var user = await getIt<GraphQLService>()
          .graphQLClient
          .query(QueryOptions(document: gql(GQLQueries.ME)));
      setState(() {
        _spinner =
            "Generating Encryption Keys for " + user.data["me"]["firstName"];
      });
      PGPService pgpService = await PGPService.generateNewKey(
          user.data["me"]["firstName"] + " " + user.data["me"]["lastName"],
          user.data["me"]["email"],
          this.password);
      setState(() {
        _spinner = "Submitting Key";
      });

      await getIt<GraphQLService>().graphQLClient.mutate(MutationOptions(
          document: gql(GQLQueries.SUBMIT_KEY),
          variables: {"publicKey": pgpService.publicKey}));

      var status = getIt<PreferencesService>().instanceStatus;
      status.hasPGPKey = true;
      getIt<PreferencesService>().instanceStatus = status;
      AppRouter.router.navigateTo(
        context,
        AppRoutes.initRoute.route,
      );
    }
  }
}
