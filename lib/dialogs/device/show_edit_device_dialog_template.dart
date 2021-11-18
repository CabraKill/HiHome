import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/data/models/device/device_type.dart';
import 'package:hihome/dialogs/device/show_remove_device_dialog.dart';

import 'dialog_result_type.dart';

Future<DialogDeviceResultType> showEditDeviceDialogTemplate({
  required String title,
  required String name,
  required String value,
  required DeviceType type,
  bool editMode = false,
}) async {
  final _formKey = GlobalKey<FormState>();
  final result = await Get.defaultDialog<DialogDeviceResultType?>(
    title: 'Add new device',
    content: SizedBox(
      width: Get.width * 0.5,
      height: Get.height * 0.6,
      child: Form(
        key: _formKey,
        child: AspectRatio(
          aspectRatio: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(
                  labelText: 'Device name',
                ),
                onChanged: (value) => name = value,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a device name.';
                  }
                  return null;
                },
              ),
              if (!editMode)
                DropdownButtonFormField<DeviceType>(
                  value: type,
                  items: DeviceType.values
                      .map(
                        (type) => DropdownMenuItem<DeviceType>(
                          child: type.stringWithIcon,
                          value: type,
                        ),
                      )
                      .toList(),
                  decoration: const InputDecoration(
                    labelText: 'Device type',
                  ),
                  onChanged: (value) => value != null ? type = value : null,
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a device type.';
                    }
                    return null;
                  },
                ),
              TextFormField(
                enabled: editMode,
                initialValue: value,
                decoration: const InputDecoration(
                  labelText: 'Device value',
                ),
                onChanged: (_value) => value = _value,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a device value.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    ),
    actions: [
      TextButton(
        child: const Text('Cancel'),
        onPressed: () => Get.back(result: DialogDeviceResultType.cancel),
      ),
      if (!editMode)
        TextButton(
          child: const Text('Add'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Get.back(result: DialogDeviceResultType.remove);
            }
          },
        ),
      if (editMode)
        TextButton(
          child: const Text('Edit'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Get.back(result: DialogDeviceResultType.edit);
            }
          },
        ),
      if (editMode)
        TextButton(
          child: const Text('Remove'),
          onPressed: () async {
            final result = await showConfirmRemoveDevice();
            if (result) {
              Get.back(result: DialogDeviceResultType.remove);
            } else {
              Get.back(result: DialogDeviceResultType.cancel);
            }
          },
        ),
    ],
  );
  return result ?? DialogDeviceResultType.cancel;
}
