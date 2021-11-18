import 'package:hihome/dialogs/device/show_add_device_dialog.dart';
import 'package:hihome/dialogs/device/show_edit_device_dialog_template.dart';
import 'package:hihome/domain/models/device.dart';
import 'dialog_result_type.dart';

Future<DialogDeviceResultType> showEditDeviceDialog(
  DeviceEntity device,
) async {
  String name = device.name ?? '';
  String value = device.bruteValue;
  Atributes atributes =
      Atributes(name: device.name ?? '', value: device.bruteValue);

  final result = await showEditDeviceDialogTemplate(
    title: 'Edit device',
    type: device.type,
    atributes: atributes,
    editMode: true,
  );
  if (result != DialogDeviceResultType.edit) return result;
  device.name = name;
  device.bruteValue = value;
  return DialogDeviceResultType.edit;
}
