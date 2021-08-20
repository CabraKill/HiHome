import 'package:flutter/material.dart';

class House extends StatefulWidget {
  final String name;
  final Function(void)? onTap;
  const House({Key? key, required this.name, this.onTap}) : super(key: key);

  @override
  _HouseState createState() => _HouseState();
}

class _HouseState extends State<House> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
      child: AnimatedSize(
        curve: Curves.easeOut,
        duration: Duration(milliseconds: 300),
        vsync: this,
        child: Container(
          margin: const EdgeInsets.all(8),
          alignment: Alignment.center,
          color: Colors.red,
          child: Text(widget.name),
        ),
      ),
    ));
  }
}
