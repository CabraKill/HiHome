import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/data/models/device/device_point.dart';
import 'package:hihome/domain/models/add_device.dart';
import '../data/models/device/device_type.dart';

Future<AddDeviceEntity?> showAddNewDeviceDialog(
  DeviceType type,
  DevicePointModel point,
  String path,
) async {
  String name = '';
  String value = '';
  final _formKey = GlobalKey<FormState>();
  final result = (await Get.defaultDialog<bool?>(
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
            onPressed: Get.back,
          ),
          TextButton(
            child: const Text('Add'),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Get.back(result: true);
              }
            },
          ),
        ],
      )) ??
      false;
  if (!result) return null;
  final newDevice = AddDeviceEntity(
    name: name,
    type: type,
    bruteValue: value,
    path: path,
    point: point,
  );
  return newDevice;
}
