import 'package:flutter/material.dart';

class SectionPreview extends StatefulWidget {
  final String name;
  final GestureTapCallback? onTap;
  const SectionPreview({
    Key? key,
    required this.name,
    this.onTap,
  }) : super(key: key);

  @override
  _SectionPreviewState createState() => _SectionPreviewState();
}

class _SectionPreviewState extends State<SectionPreview> {
  bool done = false;

  @override
  void initState() {
    super.initState();
    initLoading();
  }

  void initLoading() async {
    await Future.delayed(const Duration(milliseconds: 0));
    if (mounted) setState(() => done = true);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: InkWell(
          onTap: widget.onTap,
          child: AnimatedSize(
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
            child: SizedBox(
              width: done ? null : 0,
              height: done ? null : 0,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    widget.name,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
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
