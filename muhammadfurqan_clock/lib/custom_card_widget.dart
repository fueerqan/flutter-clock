import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;

  CustomCardWidget({@required this.child, this.margin, this.padding});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        margin: margin ?? const EdgeInsets.all(0),
        padding: padding ?? const EdgeInsets.all(0),
        child: child,
      ),
    );
  }
}
