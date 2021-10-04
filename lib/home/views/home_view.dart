//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_matching_cards/home/views/sub_views/animated.dart';
import 'package:flutter_matching_cards/home/views/sub_views/matching_card.dart';
import 'package:flutter_matching_cards/models/match_card.dart';
import 'package:flutter_matching_cards/models/piece.dart';
import 'package:flutter_matching_cards/repositories/people_repository.dart';
import 'package:flutter_matching_cards/services/people_provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> cardList;
  PeopleRepository api = PeopleRepository();
  List<MatchCard> cards = new List();

  void _removeCard(index) {
    setState(() {
      cardList.removeAt(index);
    });
  }

  void _addCard(MatchCard newCard) {
    setState(() {
      cards.insert(0, newCard);
    });
  }

  @override
  void initState() {
    super.initState();
    cardList = _getMatchCard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<List<Person>>(
          future: api.fetchPeople(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                alignment: Alignment.center,
                children: cardList,
              );
            } else if (snapshot.hasError) {
              return Text("Error occurs: " + snapshot.error.toString());
            } else {
              return Text("Loading...");
            }
          },
        ),
      ),
    );
  }

  List<Widget> _getMatchCard() {
    _addCard(MatchCard(255, 0, 0, 0));
    _addCard(MatchCard(255, 0, 0, 40));
    _addCard(MatchCard(0, 255, 0, 80));
    _addCard(MatchCard(0, 0, 255, 120));

    List<Widget> cardList = new List();

    for (int i = 0; i < cards.length; i++) {
      cardList.add(
        MatchingCard(
            index: cards.length - i,
            each: cards[i],
            onRemoveCard: () {
              _removeCard(i);
            }),
      );
    }

    return cardList;
  }
}
