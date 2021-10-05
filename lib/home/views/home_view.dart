//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_matching_cards/home/views/sub_views/animated.dart';
import 'package:flutter_matching_cards/home/views/sub_views/matching_card.dart';
import 'package:flutter_matching_cards/models/match_card.dart';
import 'package:flutter_matching_cards/models/piece.dart';
import 'package:flutter_matching_cards/repositories/people_repository.dart';
import 'package:flutter_matching_cards/services/people_provider.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> cardList = [];
  PeopleRepository api = PeopleRepository();
  // List<MatchCard> cards = new List();

  void _removeCard(index) {
    setState(() {
      cardList.removeAt(index);
      // cards.removeAt(index);
    });
  }

  void _addCard(MatchCard newCard) {
    setState(() {
      // cards.insert(0, newCard);
    });
  }

  @override
  void initState() {
    super.initState();

    context.read<PeopleRepository>().fetchPeopleFromAPI().then((values) {
      setState(() {
        cardList = _getMatchCard(values);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find yours"),
      ),
      body: Center(
        child: Stack(alignment: Alignment.center, children: cardList),
      ),
    );
  }

  List<Widget> _getMatchCard(List<Person> people) {
    List<Widget> cardList = new List();

    for (int i = 0; i < people.length; i++) {
      cardList.add(
        MatchingCard(
            person: people[i],
            index: people.length - i,
            onRemoveCard: () {
              _removeCard(i);
            }),
      );
    }

    return cardList;
  }
}
