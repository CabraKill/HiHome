import 'package:flutter/material.dart';

class ConfirmAddDevice extends StatelessWidget {
  ConfirmAddDevice({
    this.onSuccess,
    Key? key,
  }) : super(key: key);

  final Function? onSuccess;
  final nameField = TextEditingController();
  final typeField = TextEditingController();
  final valueField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Configure device type'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          field("Name", nameField),
          field("Type", typeField),
          field("Value", valueField),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Add'),
          onPressed: () {
            Navigator.of(context).pop();
            onSuccess?.call();
          },
        ),
      ],
    );
  }

  Widget field(String label, TextEditingController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter value',
            ),
          ),
        ),
      ],
    );
  }
}
