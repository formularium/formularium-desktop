import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:formularium_desktop/components/admin/CreateCSR.dart';
import 'package:formularium_desktop/components/admin/EncryptionKeyApproval.dart';
import 'package:formularium_desktop/constants/GraphQL.dart';
import 'package:formularium_desktop/services/GraphQLService.dart';
import 'package:formularium_desktop/services/PGPService.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:openpgp/model/bridge.pb.dart';
import "package:x509csr/x509csr.dart";

import "package:pointycastle/export.dart";
import 'package:asn1lib/asn1lib.dart';
import '../main.dart';
import 'AppPage.dart';

// inspired by https://github.com/RegNex/ProjectMgtTool_Flutter_Desktop/
class TeamsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: ValueNotifier(getIt<GraphQLService>().graphQLClient),
        child: appPageLayout([
          Container(
              width: 800,
              child: Card(
                  elevation: 0,
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('Team 1',
                            style: Theme.of(context).textTheme.headline3),
                      ),
                      Divider(),
                      ListTile(
                        title: Text('Members',
                            style: Theme.of(context).textTheme.headline6),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                        child: Row(
                          children: [
                            Wrap(
                                spacing: 10.0, // spacing between adjacent chips
                                runSpacing: 10.0, // spacing between lines
                                children: [
                                  InputChip(
                                    avatar: CircleAvatar(
                                      child: Text('AB'),
                                      backgroundColor: Colors.deepPurple,
                                      foregroundColor: Colors.white,
                                    ),
                                    label: Text('Choice 2'),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    deleteIcon: Icon(IconData(0xe635,
                                        fontFamily: 'MaterialIcons')),
                                    deleteButtonTooltipMessage:
                                        "Remove user from team",
                                    onDeleted: () {},
                                  ),
                                  InputChip(
                                    avatar: CircleAvatar(
                                      child: Text('CD'),
                                    ),
                                    label: Text('Choice 2'),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    deleteIcon: Icon(IconData(0xe635,
                                        fontFamily: 'MaterialIcons')),
                                    onDeleted: () {},
                                  ),
                                  InputChip(
                                    avatar: CircleAvatar(
                                      child: Text('AC'),
                                    ),
                                    label: Text('Choice 2'),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    deleteIcon: Icon(IconData(0xe635,
                                        fontFamily: 'MaterialIcons')),
                                    onDeleted: () {},
                                  ),
                                ])
                          ],
                        ),
                      ),
                      ListTile(
                        title: Text('Certificate',
                            style: Theme.of(context).textTheme.headline6),
                      ),
                    ],
                  ))),
          RaisedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CreateTeam();
                  });
            },
            child: Text("Create Team"),
          ),
        ], context));
  }
}
