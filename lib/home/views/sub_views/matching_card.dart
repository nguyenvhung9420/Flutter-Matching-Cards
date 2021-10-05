//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_matching_cards/controllers/people_repository.dart';
import 'package:flutter_matching_cards/home/views/sub_views/animated_draggable_card.dart';
import 'package:flutter_matching_cards/models/match_card.dart';
import 'package:flutter_matching_cards/models/person.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class MatchingCard extends StatefulWidget {
  MatchCard each;
  Function() onRemoveCard;
  int index;
  Person person;
  MatchingCard({Key key, this.each, this.onRemoveCard, this.index, this.person})
      : super(key: key);

  @override
  _MatchingCardState createState() => _MatchingCardState();
}

class _MatchingCardState extends State<MatchingCard> {
  AnimationController _controller;
  DragUpdateDetails _details;
  double width;

  @override
  void initState() {}

  void showToastWhenLiked(Person person) {
    Fluttertoast.showToast(
      msg: "You liked ${person.firstName}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM_LEFT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.pinkAccent,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    MatchCard each = widget.each;
    int index = widget.index;
    Person person = widget.person;
    double height =
        (MediaQuery.of(context).size.width + 30 - (widget.index * 10)) * 1.0;
    double width =
        (MediaQuery.of(context).size.width - 16 - (widget.index * 10)) * 1.0;
    return DraggableCard(
      index: index,
      onRemoveCard: () {
        context.read<PeopleRepository>().savePerson(person, true);
        widget.onRemoveCard();
        showToastWhenLiked(person);
      },
      child: Material(
        elevation: 7.0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Image.network(
                        person.picture,
                        width: width,
                        height: width,
                        fit: BoxFit.fill,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              person.firstName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .fontSize,
                              ),
                            ),
                            Text(
                              person.lastName.toString(),
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .fontSize,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            context
                                .read<PeopleRepository>()
                                .savePerson(person, true);
                            widget.onRemoveCard();
                            showToastWhenLiked(person);
                          },
                          icon: Icon(Ionicons.heart, size: 18),
                          label: Text("Like"),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            context
                                .read<PeopleRepository>()
                                .savePerson(person, false);
                            widget.onRemoveCard();
                          },
                          icon: Icon(Ionicons.archive, size: 18),
                          label: Text("Pass"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              height: height,
              width: width),
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
