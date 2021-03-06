//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_matching_cards/app_entry.dart';
import 'package:flutter_matching_cards/controllers/bottom_tab_repository.dart';
import 'package:flutter_matching_cards/controllers/people_repository.dart';
import 'package:flutter_matching_cards/home/views/home_view.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PeopleRepository()),
        ChangeNotifierProvider(create: (context) => BottomTabRepository()),
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Matching Cards',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: EntryScreen(),
    );
  }
}
