
import 'package:flutter/material.dart';

enum TabItem { welcome, appointments,  account }

class TabItemData {
  const TabItemData({@required this.title, @required this.icon});

  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.welcome: TabItemData(title: 'Home', icon: Icons.home),
    TabItem.appointments: TabItemData(title: 'Appointments', icon: Icons.work),
    TabItem.account: TabItemData(title: 'Account', icon: Icons.person),
  };
}