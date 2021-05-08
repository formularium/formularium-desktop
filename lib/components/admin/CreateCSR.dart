import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:formularium_desktop/constants/GraphQL.dart';
import 'package:formularium_desktop/services/CertificateService.dart';
import 'package:formularium_desktop/services/GraphQLService.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../main.dart';

class CreateTeam extends StatefulWidget {
  @override
  CreateTeamState createState() {
    return CreateTeamState();
  }
}

class CreateTeamState extends State<CreateTeam> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  String name;
  String organisation;
  String city;
  String country;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Stack(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      onChanged: (val) => name = val,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Team Name',
                      ),
                      // assign the the multi validator to the TextFormField validator
                    )),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      onChanged: (val) => organisation = val,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Organisation Name',
                      ),
                      // assign the the multi validator to the TextFormField validator
                    )),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      onChanged: (val) => city = val,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'City',
                      ),
                      // assign the the multi validator to the TextFormField validator
                    )),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      onChanged: (val) => country = val,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Country',
                      ),
                      // assign the the multi validator to the TextFormField validator
                    )),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: ElevatedButton(
                        onPressed: () => generateCSR(context),
                        child: Text("Generate CSR")))
              ],
            ),
          ),
        ],
      ),
    );
  }

  void generateCSR(context) async {
    CertificateService certs = await CertificateService.generateKeypair();
    QueryResult result = await getIt<GraphQLService>().graphQLClient.mutate(
            MutationOptions(document: gql(GQLQueries.CREATE_TEAM), variables: {
          "key": certs.encryptedPrivateKey,
          "name": name,
        }));

    Map<String, String> dn = {
      "CN": result.data["createTeam"]["team"]["domain"],
      "O": organisation,
      "OU": name,
      "L": city,
      "C": country,
    };

    certs.getCSR(dn);

    QueryResult result2 = await getIt<GraphQLService>().graphQLClient.mutate(
            MutationOptions(
                document: gql(GQLQueries.ADD_CSR_TO_TEAM),
                variables: {
              "publicKey": certs.publicKey,
              "teamId": result.data["createTeam"]["team"]["id"],
              "csr": certs.csr
            }));
    print(result2);
  }
}
