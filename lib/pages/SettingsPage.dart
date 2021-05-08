import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:formularium_desktop/components/admin/EncryptionKeyApproval.dart';
import 'package:formularium_desktop/constants/GraphQL.dart';
import 'package:formularium_desktop/services/GraphQLService.dart';
import 'package:formularium_desktop/services/PGPService.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../main.dart';
import 'AppPage.dart';

// inspired by https://github.com/RegNex/ProjectMgtTool_Flutter_Desktop/
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: ValueNotifier(getIt<GraphQLService>().graphQLClient),
        child: appPageLayout([
          encryptionKeyApproval(context),
        ], context));
  }
}
