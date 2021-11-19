import 'package:hihome/dialogs/device/dialog_result_type.dart';
import 'package:hihome/dialogs/device/models/changing_device.dart';

class EditDeviceDialogResult {
  final DeviceDialogOperationType type;
  final ChangingDevice? device;

  EditDeviceDialogResult({required this.type, this.device});
}
