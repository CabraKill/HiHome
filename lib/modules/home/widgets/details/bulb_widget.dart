import 'package:flutter/material.dart';

class BulbWidget extends StatelessWidget {
  final double yPosition;
  final double xPosition;

  const BulbWidget({
    Key? key,
    required this.yPosition,
    required this.xPosition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: yPosition, //- 115,
      left: xPosition, //- 9,
      child: Icon(Icons.lightbulb),
    );
  }
}
