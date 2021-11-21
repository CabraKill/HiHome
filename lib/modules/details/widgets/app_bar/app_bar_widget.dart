import 'package:flutter/material.dart';
import 'package:hihome/modules/details/details_controller.dart';
import 'package:hihome/modules/details/models/zoom_type.dart';

class DetailsAppBarWidget {
  AppBar appBar(DetailsController controller) => AppBar(
        title: Text('Board - ${controller.sectionEntity.name}'),
        actions: [
          IconButton(
            onPressed: controller.updateDeviceList,
            icon: const Icon(Icons.update),
          ),
          IconButton(
            onPressed: controller.chooseControllMode,
            icon: Icon(
              Icons.play_arrow,
              color: controller.isControllModeOn ? Colors.cyan : null,
            ),
          ),
          IconButton(
            onPressed: controller.switchEditMode,
            icon: Icon(
              Icons.edit,
              color: controller.isEditModeOn ? Colors.cyan : null,
            ),
          ),
          IconButton(
            onPressed: controller.switchAnalysisMode,
            icon: Icon(
              Icons.analytics,
              color: controller.isAnalysisModeOn ? Colors.cyan : null,
            ),
          ),
          IconButton(
            onPressed: controller.nextZoom,
            icon: Icon(
              controller.deviceZoom.iconData,
            ),
          ),
          IconButton(
            onPressed: controller.switchTitleMode,
            icon: Icon(
              Icons.title,
              color: controller.isTitleModeOn ? Colors.cyan : null,
            ),
          )
        ],
      );
}
