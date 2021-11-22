import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Hero(
      tag: 'logoHero',
      child: Icon(
        Icons.smart_toy,
        color: Colors.cyan,
        size: 100,
      ),
    );
  }
}
