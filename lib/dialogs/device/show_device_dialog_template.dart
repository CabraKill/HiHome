import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/data/models/device/device_type.dart';
import 'package:hihome/dialogs/device/models/edit_device_dialog_result.dart';
import 'package:hihome/dialogs/device/show_remove_device_dialog.dart';
import 'package:hihome/dialogs/device/models/changing_device.dart';
import 'dialog_result_type.dart';

Future<EditDeviceDialogResult> showDeviceDialog({
  required String title,
  required ChangingDevice device,
  required DeviceDialogOperationType operationType,
}) async {
  final result = await _showDialog(
    title: title,
    device: device,
    operationType: operationType,
  );

  return EditDeviceDialogResult(
    type: result,
    device: device,
  );
}

Future<DeviceDialogOperationType> _showDialog({
  required String title,
  required ChangingDevice device,
  required DeviceDialogOperationType operationType,
}) async {
  final _formKey = GlobalKey<FormState>();
  final result = await Get.defaultDialog<DeviceDialogOperationType?>(
    title: title,
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
                initialValue: device.name,
                decoration: const InputDecoration(
                  labelText: 'Device name',
                ),
                onChanged: (_name) => device.name = _name,
                validator: (_name) {
                  if (_name?.isEmpty ?? true) {
                    return 'Please enter a device name.';
                  }
                  return null;
                },
              ),
              if (!_editMode(operationType))
                DropdownButtonFormField<DeviceType>(
                  value: device.type,
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
                  onChanged: (_value) =>
                      _value != null ? device.type = _value : null,
                  validator: (_value) {
                    if (_value == null) {
                      return 'Please select a device type.';
                    }
                    return null;
                  },
                ),
              TextFormField(
                initialValue: device.value,
                decoration: const InputDecoration(
                  labelText: 'Device value',
                ),
                onChanged: (_value) => device.value = _value,
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
        onPressed: () => Get.back(result: DeviceDialogOperationType.cancel),
      ),
      if (!_editMode(operationType))
        TextButton(
          child: const Text('Add'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Get.back(result: DeviceDialogOperationType.add);
            }
          },
        ),
      if (_editMode(operationType))
        TextButton(
          child: const Text('Edit'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Get.back(result: DeviceDialogOperationType.edit);
            }
          },
        ),
      if (_editMode(operationType))
        TextButton(
          child: const Text('Remove'),
          onPressed: () async {
            final result = await showConfirmRemoveDevice();
            if (result) {
              Get.back(result: DeviceDialogOperationType.remove);
            } else {
              Get.back(result: DeviceDialogOperationType.cancel);
            }
          },
        ),
    ],
  );
  return result ?? DeviceDialogOperationType.cancel;
}

bool _editMode(DeviceDialogOperationType type) =>
    type == DeviceDialogOperationType.edit;
