//@dart=2.9

import 'dart:async';
import 'package:flutter_matching_cards/models/piece.dart';
import 'package:flutter_matching_cards/services/people_provider.dart';

class PeopleRepository {
  final PeopleAPIProvider _provider = PeopleAPIProvider();

  Future<List<Person>> fetchPeople() async {
    final response = await _provider.getPeople(limit: 10);
    List<Person> toReturn = List<Person>.from(
        response['data'].map((model) => Person.fromJson(model)));
    return toReturn;
  }
}
