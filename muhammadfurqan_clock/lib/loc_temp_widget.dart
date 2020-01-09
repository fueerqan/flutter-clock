import 'package:flutter/material.dart';

class LocTempWidget extends StatelessWidget {
  final String location;
  final String temp;

  LocTempWidget({this.location, this.temp});

  @override
  Widget build(BuildContext context) {
    final normalTextStyle = TextStyle(
        fontSize: MediaQuery.of(context).size.width / 20,
        fontFamily: "Stardos Stencil",
        fontWeight: FontWeight.bold);
    final smallTextStyle = TextStyle(
        fontSize: MediaQuery.of(context).size.width / 40,
        fontFamily: "Stardos Stencil",
        fontWeight: FontWeight.bold);

    return Container(
      margin: const EdgeInsets.all(5),
      alignment: Alignment.topRight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            temp,
            style: normalTextStyle,
          ),
          Text(
            location,
            style: smallTextStyle,
          )
        ],
      ),
    );
  }
}
