import 'package:flutter/material.dart';

class HouseWidget extends StatefulWidget {
  final String name;
  final Function()? onTap;
  const HouseWidget({Key? key, required this.name, this.onTap})
      : super(key: key);

  @override
  _HouseWidgetState createState() => _HouseWidgetState();
}

class _HouseWidgetState extends State<HouseWidget>
    with TickerProviderStateMixin {
  bool done = false;

  @override
  void initState() {
    super.initState();
    initLoading();
  }

  void initLoading() async {
    await Future.delayed(Duration(milliseconds: 1300));
    if (mounted)
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
            child: SizedBox(
              width: done ? null : 0,
              height: done ? null : 0,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.secondary)),
                  alignment: Alignment.center,
                  child: Text(
                    widget.name,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
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
