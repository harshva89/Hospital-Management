
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/home/account_page.dart';
import 'package:time_tracker_flutter_course/app/home/cupertino_home.dart';
import 'package:time_tracker_flutter_course/app/home/jobs/jobs_page.dart';
import 'package:time_tracker_flutter_course/app/home/tab_item.dart';
import 'package:time_tracker_flutter_course/app/home/welcome.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.welcome;

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.welcome: (_) => Welcome(),
      TabItem.appointments: (_) => JobsPage(),
      TabItem.account: (_) => AccountPage(),
    };
  }

  void _select(TabItem tabItem) {
    setState(() => _currentTab = tabItem);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoHomeScaffold(
      currentTab: _currentTab,
      onSelectTab: _select,
      widgetBuilders: widgetBuilders,
    );
  }

}
