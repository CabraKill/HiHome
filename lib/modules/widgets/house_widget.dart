import 'package:flutter/material.dart';

class House extends StatefulWidget {
  final String name;
  final Function()? onTap;
  const House({Key? key, required this.name, this.onTap}) : super(key: key);

  @override
  _HouseState createState() => _HouseState();
}

class _HouseState extends State<House> with TickerProviderStateMixin {
  bool done = false;

  @override
  void initState() {
    super.initState();
    initLoading();
  }

  void initLoading() async {
    await Future.delayed(Duration(milliseconds: 1300));
    setState(() {
      done = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: InkWell(
          onTap: widget.onTap,
          child: AnimatedSize(
            curve: Curves.easeOut,
            duration: Duration(milliseconds: 300),
            vsync: this,
            child: SizedBox(
              width: done ? null : 0,
              height: done ? null : 0,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).accentColor)),
                  alignment: Alignment.center,
                  child: Text(
                    widget.name,
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
