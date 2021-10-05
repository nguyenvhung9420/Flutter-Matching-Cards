//@dart=2.9

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_matching_cards/models/person.dart';
import 'package:flutter_matching_cards/services/people_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class PeopleRepository extends ChangeNotifier {
  final PeopleAPIProvider _provider = PeopleAPIProvider();
  List<Person> people = [];
  List<Person> likedPeople = [];
  List<Person> passedPeople = [];

  // Future<void> fetchPeopleFromAPI() async {
  //   final response = await _provider.getPeople(limit: 10);
  //   List<Person> toReturn = List<Person>.from(
  //       response['data'].map((model) => Person.fromJson(model)));
  //   people = toReturn + people;
  //   notifyListeners();
  // }

  void savePerson(Person person, bool liked) {
    if (liked) {
      likedPeople.add(person);
    } else {
      passedPeople.add(person);
    }
    notifyListeners();
  }

  Future<List<Person>> fetchPeopleFromAPI() async {
    final response = await _provider.getPeople(limit: 10);
    List<Person> toReturn = List<Person>.from(
        response['data'].map((model) => Person.fromJson(model)));
    notifyListeners();
    return toReturn;
  }

  void removeAPerson(int atIndex) {
    people.removeAt(atIndex);
    notifyListeners();
  }
}
