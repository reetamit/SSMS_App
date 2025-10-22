import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EventDialog extends StatelessWidget {
  //const EventDialog({super.key});
  TextEditingController _eventDescriptionController = TextEditingController();

  EventDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Event'),
      content: SingleChildScrollView(
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          children: [
            //const Text('Enter event description below:'),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Enter event description below:'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _eventDescriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'e.g. Krishna Janmashtami celebration at 6 PM',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_eventDescriptionController.text.trim());
          },
          child: const Text('Add'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(null);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
