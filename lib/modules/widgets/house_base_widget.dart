import 'package:flutter/material.dart';

class HouseBase extends StatelessWidget {
  const HouseBase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 20,
      decoration: const BoxDecoration(
        color: Colors.black38,
      ),
    );
  }
}
