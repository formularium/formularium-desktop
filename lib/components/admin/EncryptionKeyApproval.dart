import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:formularium_desktop/constants/GraphQL.dart';
import 'package:formularium_desktop/services/GraphQLService.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../main.dart';

Container encryptionKeyApproval(context) {
  return Container(
      color: Theme.of(context).cardColor,
      padding: EdgeInsets.all(12),
      child: Column(children: [
        Text(
          "Key Approval Requests",
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(
          height: 6,
        ),
        Query(
            options: QueryOptions(
              document: gql(GQLQueries
                  .ALL_INACTIVE_ENCRYPTION_KEYS), // this is the query string you just created
            ),
            builder: (QueryResult result,
                {VoidCallback refetch, FetchMore fetchMore}) {
              if (result.hasException) {
                return Text(result.exception.toString());
              }

              if (result.isLoading) {
                return Text('Loading');
              }
              return DataTable(columns: [
                DataColumn(label: Text("Name")),
                DataColumn(label: Text("Fingerprint")),
                DataColumn(label: Text("Approve")),
                DataColumn(label: Text("Reject")),
              ], rows: [
                for (var n in result.data["allInactiveEncryptionKeys"]["edges"])
                  DataRow(cells: [
                    DataCell(Text(n["node"]["user"]["firstName"] +
                        " " +
                        n["node"]["user"]["lastName"])),
                    DataCell(Text(n["node"]["fingerprint"])),
                    DataCell(IconButton(
                        icon: Icon(
                          AntDesign.check,
                          color: Colors.green,
                          size: 24.0,
                          semanticLabel: 'Approve Key',
                        ),
                        tooltip: 'Approve Key',
                        onPressed: () async {
                          await getIt<GraphQLService>().graphQLClient.mutate(
                              MutationOptions(
                                  document: gql(GQLQueries.APPROVE_USER_KEY),
                                  variables: {"publicKeyId": n["node"]["id"]}));
                          print(n["node"]["id"]);
                          refetch();
                        })),
                    DataCell(IconButton(
                        icon: Icon(
                          AntDesign.delete,
                          color: Colors.red,
                          size: 24.0,
                          semanticLabel: 'Reject Key',
                        ),
                        tooltip: 'Reject Key',
                        onPressed: () async {
                          await getIt<GraphQLService>().graphQLClient.mutate(
                              MutationOptions(
                                  document: gql(GQLQueries.REMOVE_KEY),
                                  variables: {"publicKeyId": n["node"]["id"]}));
                          print(n["node"]["id"]);
                          refetch();
                        })),
                  ])
              ]);
            }),
        SizedBox(
          height: 10,
        ),
      ]));
}
