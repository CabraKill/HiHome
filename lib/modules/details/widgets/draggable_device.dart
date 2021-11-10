import 'package:flutter/material.dart';
import 'package:hihome/data/models/device/device_point.dart';

class DraggableDevice extends StatelessWidget {
  const DraggableDevice({
    required this.iconData,
    required this.onDragEnd,
    Key? key,
  }) : super(key: key);

  final IconData iconData;
  final OnDeviceDragEnd onDragEnd;

  @override
  Widget build(BuildContext context) {
    return Draggable(
      child: Icon(iconData),
      feedback: Icon(iconData),
      childWhenDragging: Icon(
        iconData,
        color: Theme.of(context).colorScheme.secondary,
      ),
      onDragEnd: (data) {
        final dx = data.offset.dx;
        final dy = data.offset.dy;

        final relativeX = dx / MediaQuery.of(context).size.width;
        final relativeY = dy / MediaQuery.of(context).size.height;
        final devicePointModel = DevicePointModel(
          x: relativeX,
          y: relativeY,
        );
        //TODO: check this initial values
        // final device = DeviceModel(
        //   id: '0',
        //   name: '',
        //   state: '',
        //   point: devicePointModel,
        // );
        onDragEnd(devicePointModel);
      },
    );
  }
}

typedef OnDeviceDragEnd = void Function(DevicePointModel);
