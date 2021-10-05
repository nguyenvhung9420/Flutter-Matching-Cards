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
        this.cardList = _getMatchCard(values);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // cardList = _getMatchCard(context.watch<PeopleRepository>().people);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(alignment: Alignment.center, children: cardList),

        //   context.watch<PeopleRepository>().people.length > 4
        //       ? List.generate(4, (int i) {
        //           MatchCard each = MatchCard(255, 0, 0, 0);
        //           return MatchingCard(
        //               index: 4 - i,
        //               each: each,
        //               onRemoveCard: () {
        //                 // _removeCard(i);
        //                 context.read<PeopleRepository>().removeAPerson(4 - i);
        //                 // print("remaining cards = " +
        //                 //     context
        //                 //         .watch<PeopleRepository>()
        //                 //         .people
        //                 //         .length
        //                 //         .toString());
        //               });
        //         })
        //       : [Container()],
        // )

        // FutureBuilder<void>(
        //   future: api.fetchPeopleFromAPI(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.done) {
        //       return Stack(
        //         alignment: Alignment.center,
        //         children: cardList,
        //       );
        //     } else if (snapshot.hasError) {
        //       return Text("Error occurs: " + snapshot.error.toString());
        //     } else {
        //       return Text("Loading...");
        //     }
        //   },
      ),
    );
  }

  List<Widget> _getMatchCard(List<Person> cards) {
    List<Widget> cardList = new List();

    for (int i = 0; i < cards.length; i++) {
      cardList.add(
        MatchingCard(
            index: cards.length - i,
            onRemoveCard: () {
              _removeCard(i);
              print("remaining cards = " + cardList.length.toString());
            }),
      );
    }

    return cardList;
  }
}
