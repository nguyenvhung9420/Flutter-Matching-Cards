//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_matching_cards/home/views/home_view.dart';
import 'package:flutter_matching_cards/repositories/people_repository.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PeopleRepository()),
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Card Stack'),
      // home: PhysicsCardDragDemo(),
    );
  }
}
