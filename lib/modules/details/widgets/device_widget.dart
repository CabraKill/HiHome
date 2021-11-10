import 'package:flutter/material.dart';
import 'package:hihome/domain/models/device.dart';

class DeviceWidget extends StatelessWidget {
  const DeviceWidget({
    Key? key,
    required this.device,
    required this.offset,
    this.onTap,
  }) : super(key: key);

  final DeviceEntity device;
  final Offset offset;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final topPadding =
        absoluteHeightValue(context, device.point?.y); //- offset.dy;
    final leftPadding = absoluteWidthValue(context, device.point?.x);
    return Positioned(
      top: topPadding,
      left: leftPadding,
      child: InkWell(
        onTap: onTap,
        child: Draggable(
          feedback: Container(),
          child: const Icon(
            Icons.lightbulb,
            size: 100,
          ),
          onDragEnd: (details) {
            device.point?.x = details.offset.dx;
            device.point?.y = details.offset.dy -
                MediaQuery.of(context).padding.top -
                offset.dy;
          },
        ),
      ),
    );
  }

  double absoluteHeightValue(BuildContext context, double? relative) =>
      (relative ?? 0) * MediaQuery.of(context).size.height;

  double absoluteWidthValue(BuildContext context, double? relative) =>
      (relative ?? 0) * MediaQuery.of(context).size.width;
}
