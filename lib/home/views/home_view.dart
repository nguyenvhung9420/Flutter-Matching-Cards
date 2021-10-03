//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_matching_cards/home/views/sub_views/animated.dart';
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

  void _removeCard(index) {
    setState(() {
      cardList.removeAt(index);
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
    List<MatchCard> cards = new List();
    cards.add(MatchCard(255, 0, 0, 0));
    cards.add(MatchCard(255, 0, 0, 40));
    cards.add(MatchCard(0, 255, 0, 80));
    cards.add(MatchCard(0, 0, 255, 120));

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

class MatchingCard extends StatefulWidget {
  MatchCard each;
  Function() onRemoveCard;
  int index;
  MatchingCard({Key key, this.each, this.onRemoveCard, this.index})
      : super(key: key);

  @override
  _MatchingCardState createState() => _MatchingCardState();
}

class _MatchingCardState extends State<MatchingCard> {
  AnimationController _controller;
  DragUpdateDetails _details;
  double width;

  @override
  void initState() {
    width = (240 - (widget.index * 10)) * 1.0;
  }

  @override
  Widget build(BuildContext context) {
    MatchCard each = widget.each;
    int index = widget.index;
    return DraggableCard(
      matchCard: each,
      index: index,
      onRemoveCard: () {
        widget.onRemoveCard();
      },
      child: Material(
        elevation: 7.0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: FlutterLogo(size: width),
        ),
      ),
    );

    // Positioned(
    //   top: each.margin,
    //   child:

    // Draggable(
    //   onDragUpdate: (DragUpdateDetails details) {
    //     setState(() => this._details = details);
    //     // if (this._details.delta.dx > 10.0) {
    //     if (this._details.delta.dx > 2.0) {
    //       widget.onRemoveCard();
    //       setState(() {
    //         this.width = this.width - (index * 10);
    //       });
    //     }
    //   },
    //   onDragEnd: (DraggableDetails details) {},
    //   childWhenDragging: Container(
    //     child: Text(
    //       "dx = " +
    //           (this._details == null ? "" : this._details.delta.toString()),
    //     ),
    //   ),
    //   feedback: AnimatedContainer(
    //     duration: const Duration(seconds: 1),
    //     curve: Curves.bounceInOut,
    //     width: this.width,
    //     height: 300,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(10),
    //       color: Color.fromARGB(
    //         255,
    //         each.redColor,
    //         each.greenColor,
    //         each.blueColor,
    //       ).withOpacity(0.7),
    //     ),
    //     alignment: Alignment.center,
    //     child: Text(index.toString()),
    //   ),
    //   child: AnimatedContainer(
    //     duration: const Duration(seconds: 1),
    //     curve: Curves.bounceInOut,
    //     width: this.width,
    //     height: 300,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(10),
    //       color: Color.fromARGB(
    //               255, each.redColor, each.greenColor, each.blueColor)
    //           .withOpacity(0.7),
    //     ),
    //     alignment: Alignment.center,
    //     child: Text(index.toString()),
    //   ),
    // ),
    // );
  }
}
