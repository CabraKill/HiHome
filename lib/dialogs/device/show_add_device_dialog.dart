import 'package:hihome/data/models/device/device_point.dart';
import 'package:hihome/dialogs/device/show_device_dialog_template.dart';
import 'package:hihome/domain/models/add_device.dart';
import '../../data/models/device/device_type.dart';
import 'dialog_result_type.dart';
import 'models/changing_device.dart';

Future<AddDeviceEntity?> showAddNewDeviceDialog(
  DeviceType type,
  DevicePointModel point,
  String path,
) async {
  ChangingDevice changingDevice = ChangingDevice(
    name: '',
    value: '',
    type: type,
    point: point,
  );
  final result = await showDeviceDialog(
    title: 'Add device',
    operationType: DeviceDialogOperationType.add,
    device: changingDevice,
  );
  if (result.type != DeviceDialogOperationType.add) return null;
  final newDevice = AddDeviceEntity.fromChanginDevice(changingDevice, path);
  return newDevice;
}
