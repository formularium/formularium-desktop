import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:formularium_desktop/constants/GraphQL.dart';
import 'package:formularium_desktop/services/GraphQLService.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../main.dart';
import 'AppPage.dart';

// inspired by https://github.com/RegNex/ProjectMgtTool_Flutter_Desktop/
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: ValueNotifier(getIt<GraphQLService>().graphQLClient),
        child: appPageLayout(
            [
              Text(
                "Settings Page",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 6,
              ),
              Query(
                  options: QueryOptions(
                    document: gql(GQLQueries
                        .ME), // this is the query string you just created
                  ),
                  builder: (QueryResult result,
                      {VoidCallback refetch, FetchMore fetchMore}) {
                    if (result.hasException) {
                      return Text(result.exception.toString());
                    }

                    if (result.isLoading) {
                      return Text('Loading');
                    }
                    return Text(
                        'Hallo ' + result.data["me"]["firstName"]);
                  }),
              SizedBox(
                height: 10,
              ),
            ],
            context
        ));
  }
}


