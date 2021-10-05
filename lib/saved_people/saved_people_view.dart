//@dart=2.9

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_matching_cards/models/piece.dart';
import 'package:flutter_matching_cards/repositories/people_repository.dart';
import 'package:flutter_matching_cards/services/people_provider.dart';
import 'package:provider/provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class SavedPeopleView extends StatefulWidget {
  SavedPeopleView({Key key}) : super(key: key);

  @override
  _SavedPeopleViewState createState() => _SavedPeopleViewState();
}

class _SavedPeopleViewState extends State<SavedPeopleView> {
  @override
  Widget build(BuildContext context) {
    List<Person> likeds = context.watch<PeopleRepository>().likedPeople;
    List<Person> passeds = context.watch<PeopleRepository>().passedPeople;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
              title: const Text("Saved people)"),
              bottom: const TabBar(tabs: [
                Tab(text: "Liked"),
                Tab(text: "Passed"),
              ])),
          body: TabBarView(
            children: [
              ListView.builder(
                itemCount: likeds.length,
                itemBuilder: (BuildContext context, int i) {
                  return ListTile(
                    title:
                        Text(likeds[i].lastName + ", " + likeds[i].firstName),
                  );
                },
              ),
              ListView.builder(
                itemCount: passeds.length,
                itemBuilder: (BuildContext context, int i) {
                  return ListTile(
                    title:
                        Text(passeds[i].lastName + ", " + passeds[i].firstName),
                  );
                },
              ),
            ],
          )),
    );
  }
}
