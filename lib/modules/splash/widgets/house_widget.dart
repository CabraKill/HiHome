import 'package:flutter/material.dart';

class House extends StatefulWidget {
  const House({Key? key}) : super(key: key);

  @override
  _HouseState createState() => _HouseState();
}

class _HouseState extends State<House> with TickerProviderStateMixin {
  bool state = true;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: GestureDetector(
          onTap: () => setState(() => state = !state),
          child: AnimatedSize(
            curve: Curves.easeOut,
            duration: Duration(milliseconds: 300),
            vsync: this,
            child: Container(
              margin: const EdgeInsets.all(8),
              width: state ? 100 : null,
              alignment: Alignment.center,
              color: Colors.red,
              child: Text("nome"),
            ),
          ),
        ),
      ),
    );
  }
}
