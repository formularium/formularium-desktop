import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formularium_desktop/constants/GraphQL.dart';
import 'package:formularium_desktop/services/GraphQLService.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:flutter_icons/flutter_icons.dart';
import '../main.dart';

// inspired by https://github.com/RegNex/ProjectMgtTool_Flutter_Desktop/
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: ValueNotifier(getIt<GraphQLService>().graphQLClient),
        child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Row(
              children: [
                Container(
                  color: Theme.of(context).cardColor,
                  width: MediaQuery.of(context).size.width > 800 ? 200 : 80,
                  padding: EdgeInsets.all(12),
                  child: Column(
                    children: [
                      ListTile(
                        title: MediaQuery.of(context).size.width > 800
                            ? Text(
                                'Formularium',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(fontWeight: FontWeight.bold),
                              )
                            : Text(
                                "📝",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                textAlign: TextAlign.center,
                              ),
                      ),
                      SizedBox(height: 25),
                      MenuOptionsWidget(
                        voidCallback: () {},
                        isSelected: true,
                        icon: MaterialCommunityIcons.view_dashboard_outline,
                        label: 'Dashboard',
                      ),
                      MenuOptionsWidget(
                        voidCallback: () {},
                        isSelected: false,
                        icon: AntDesign.form,
                        label: 'Forms',
                      ),
                      MenuOptionsWidget(
                        voidCallback: () {},
                        isSelected: false,
                        icon: Octicons.settings,
                        label: 'Settings',
                      ),
                      Spacer(),
                      SizedBox(height: 25)
                    ],
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width > 800
                        ? MediaQuery.of(context).size.width - 200
                        : MediaQuery.of(context).size.width - 80,
                    padding: EdgeInsets.all(24),
                    child: Center(
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
                                return Text(
                                    'Hallo ' + result.data["me"]["firstName"]);
                              }),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ))
              ],
            )));
  }
}

class MenuOptionsWidget extends StatefulWidget {
  final IconData icon;
  final String label;
  final Function voidCallback;
  final bool isSelected;

  const MenuOptionsWidget(
      {Key key,
      @required this.icon,
      @required this.label,
      @required this.voidCallback,
      this.isSelected = false})
      : super(key: key);
  @override
  _MenuOptionsWidgetState createState() => _MenuOptionsWidgetState();
}

class _MenuOptionsWidgetState extends State<MenuOptionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: ListTile(
            onTap: widget.voidCallback,
            leading: Icon(
              widget.icon,
              color: widget.isSelected
                  ? Color.fromRGBO(119, 12, 159, 1)
                  : Color.fromRGBO(137, 137, 137, 1),
            ),
            title: MediaQuery.of(context).size.width > 800
                ? Text(
                    widget.label,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: widget.isSelected
                            ? Color.fromRGBO(119, 12, 159, 1)
                            : Color.fromRGBO(137, 137, 137, 1)),
                  )
                : null,
          ),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
