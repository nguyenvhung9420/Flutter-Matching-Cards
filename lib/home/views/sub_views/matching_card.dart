//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_matching_cards/home/views/sub_views/animated.dart';
import 'package:flutter_matching_cards/models/match_card.dart';
import 'package:flutter_matching_cards/models/piece.dart';
import 'package:flutter_matching_cards/repositories/people_repository.dart';
import 'package:flutter_matching_cards/services/people_provider.dart';

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
    // width = 240;
  }

  @override
  Widget build(BuildContext context) {
    MatchCard each = widget.each;
    int index = widget.index;
    return DraggableCard(
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
