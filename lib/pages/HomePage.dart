import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formularium_desktop/constants/AppRoutes.dart';
import 'package:formularium_desktop/constants/GraphQL.dart';
import 'package:formularium_desktop/models/AppRouter.dart';
import 'package:formularium_desktop/services/GraphQLService.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../main.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: ValueNotifier(getIt<GraphQLService>().graphQLClient),
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Home Page",
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
                    // Just like in apollo refetch() could be used to manually trigger a refetch
                    // while fetchMore() can be used for pagination purpose
                    builder: (QueryResult result,
                        {VoidCallback refetch, FetchMore fetchMore}) {
                      if (result.hasException) {
                        return Text(result.exception.toString());
                      }

                      if (result.isLoading) {
                        return Text('Loading');
                      }
                      return Text('Hallo ' + result.data["me"]["firstName"]);
                    }),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ));
  }
}
