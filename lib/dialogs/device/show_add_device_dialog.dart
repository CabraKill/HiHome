import 'package:hihome/data/models/device/device_point.dart';
import 'package:hihome/dialogs/device/show_edit_device_dialog_template.dart';
import 'package:hihome/domain/models/add_device.dart';
import '../../data/models/device/device_type.dart';
import 'dialog_result_type.dart';

Future<AddDeviceEntity?> showAddNewDeviceDialog(
  DeviceType type,
  DevicePointModel point,
  String path,
) async {
  String name = '';
  String value = '';
  final result = await showEditDeviceDialogTemplate(
    title: 'Add device',
    name: name,
    value: value,
    type: type,
  );
  false;
  if (result != DialogDeviceResultType.add) return null;
  final newDevice = AddDeviceEntity(
    name: name,
    type: type,
    bruteValue: value,
    path: path,
    point: point,
  );
  return newDevice;
}
