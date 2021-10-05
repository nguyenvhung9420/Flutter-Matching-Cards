// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_matching_cards/controllers/bottom_tab_repository.dart';
import 'package:flutter_matching_cards/home/views/home_view.dart';
import 'package:flutter_matching_cards/saved_people/saved_people_view.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class EntryScreen extends StatefulWidget {
  EntryScreen({Key key}) : super(key: key);

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  onTapped(int index) {
    setState(() {
      context.read<BottomTabRepository>().changeTabIndex(index);
    });
  }

  List<Widget> tabs = [
    MyHomePage(),
    SavedPeopleView(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int currentTabIndex = context.watch<BottomTabRepository>().tabIndex;

    return Scaffold(
      body: IndexedStack(
        index: currentTabIndex,
        children: tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black.withOpacity(0.5),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: currentTabIndex,
        onTap: onTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Ionicons.heart_outline),
            activeIcon: Icon(Ionicons.heart),
            label: "Cards",
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.people_outline),
            activeIcon: Icon(Ionicons.people),
            label: "Passed",
          ),
        ],
      ),
    );
  }
}
