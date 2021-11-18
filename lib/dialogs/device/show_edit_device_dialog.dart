import 'package:hihome/dialogs/device/show_edit_device_dialog_template.dart';
import 'package:hihome/domain/models/device.dart';
import 'dialog_result_type.dart';

Future<DialogDeviceResultType> showEditDeviceDialog(
  DeviceEntity device,
) async {
  String name = device.name ?? '';
  String value = device.bruteValue;

  final result = await showEditDeviceDialogTemplate(
    title: 'Edit device',
    name: name,
    value: value,
    type: device.type,
    editMode: true,
  );
  if (result != DialogDeviceResultType.edit) return result;
  device.name = name;
  device.bruteValue = value;
  return DialogDeviceResultType.edit;
}
