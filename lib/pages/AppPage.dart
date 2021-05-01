import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:formularium_desktop/constants/AppRoutes.dart';
import 'package:formularium_desktop/models/AppRouter.dart';

Scaffold appPageLayout(children, context) {
  return Scaffold(
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
                  voidCallback: () {
                    AppRouter.router.navigateTo(
                      context,
                      AppRoutes.dashboardRoute.route,
                      transition: TransitionType.none
                    );
                  },
                  isSelected: ModalRoute.of(context).settings.name.startsWith(AppRoutes.dashboardRoute.route),
                  icon: MaterialCommunityIcons.view_dashboard_outline,
                  label: 'Dashboard',
                ),
                MenuOptionsWidget(
                  voidCallback: () {
                    AppRouter.router.navigateTo(
                        context,
                        AppRoutes.formListRoute.route,
                        transition: TransitionType.none
                    );
                  },
                  isSelected:  ModalRoute.of(context).settings.name.startsWith(AppRoutes.formListRoute.route),
                  icon: AntDesign.form,
                  label: 'Forms',
                ),
                MenuOptionsWidget(
                  voidCallback: () {
                    AppRouter.router.navigateTo(
                      context,
                      AppRoutes.settingsRoute.route,
                        transition: TransitionType.none
                    );
                  },
                  isSelected: ModalRoute.of(context).settings.name.startsWith(AppRoutes.settingsRoute.route),
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
                  children: children
                ),
              ))
        ],
      ));
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
        MouseRegion(
            cursor: SystemMouseCursors.click,
            child:
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
            )
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }
}