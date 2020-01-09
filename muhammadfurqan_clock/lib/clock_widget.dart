import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './custom_card_widget.dart';

class ClockWidget extends StatelessWidget {
  final DateTime dateTime;
  final bool is24HourFormat;

  ClockWidget({@required this.dateTime, this.is24HourFormat = false});

  @override
  Widget build(BuildContext context) {
    final bigTextStyle = TextStyle(
        fontSize: MediaQuery.of(context).size.width / 10,
        fontFamily: "Stardos Stencil",
        fontWeight: FontWeight.bold);
    final normalTextStyle = TextStyle(
        fontSize: MediaQuery.of(context).size.width / 20,
        fontFamily: "Stardos Stencil",
        fontWeight: FontWeight.bold);
    final smallTextStyle = TextStyle(
        fontSize: MediaQuery.of(context).size.width / 30,
        fontFamily: "Stardos Stencil",
        fontWeight: FontWeight.bold);
    final day = DateFormat('E').format(dateTime);
    final hour = DateFormat((!is24HourFormat) ? 'hh' : 'HH').format(dateTime);
    final minute = DateFormat('mm').format(dateTime);

    var timeChildren = [
      CustomCardWidget(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        child: Text(
          hour,
          style: bigTextStyle,
        ),
      ),
      Text(":", style: bigTextStyle),
      CustomCardWidget(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        child: Text(
          minute,
          style: bigTextStyle,
        ),
      ),
    ];

    if (!is24HourFormat)
      timeChildren.add(CustomCardWidget(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        child: Text(
          DateFormat('a').format(dateTime),
          style: normalTextStyle,
        ),
      ));

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: timeChildren,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CustomCardWidget(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              child: Text(
                day,
                style: smallTextStyle,
              ),
            ),
            CustomCardWidget(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              child: Text(
                DateFormat.yMMMd().format(dateTime),
                style: smallTextStyle,
              ),
            ),
          ],
        )
      ],
    );
  }
}
