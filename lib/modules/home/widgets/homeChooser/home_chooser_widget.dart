import 'package:flutter/material.dart';
import 'package:hihome/domain/models/section.dart';
import 'package:hihome/modules/widgets/house_widget.dart';

class SectionChooser extends StatelessWidget {
  final SectionOnTap ontap;
  final List<SectionEntity> sections;
  const SectionChooser({
    required this.sections,
    required this.ontap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: sections
                    .map(
                      (section) => Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: SectionPreview(
                            name: section.name,
                            onTap: () => ontap(section),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            // const HouseBase()
          ],
        ),
      ),
    );
  }
}

typedef SectionOnTap = void Function(SectionEntity section);
