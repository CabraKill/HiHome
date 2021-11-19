import 'package:hihome/dialogs/device/show_device_dialog_template.dart';
import 'package:hihome/dialogs/device/models/changing_device.dart';
import 'package:hihome/domain/models/device.dart';
import 'dialog_result_type.dart';
import 'models/edit_device_dialog_result.dart';

Future<EditDeviceDialogResult> showEditDeviceDialog(
  DeviceEntity device,
) async {
  ChangingDevice changingDevice = ChangingDevice(
    name: device.name,
    value: device.bruteValue,
    type: device.type,
    point: device.point,
  );
  final result = await showDeviceDialog(
    title: 'Edit device',
    device: changingDevice,
    operationType: DeviceDialogOperationType.edit,
  );
  return result;
}
