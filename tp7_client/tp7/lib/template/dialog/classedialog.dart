import 'package:flutter/material.dart';

class ClassDialog extends StatefulWidget {
  final String classe; // Marked as final for immutability
  const ClassDialog({Key? key, required this.classe}) : super(key: key);

  @override
  _ClassDialogState createState() => _ClassDialogState();
}

class _ClassDialogState extends State<ClassDialog> {
  @override
  void initState() {
    super.initState();
    // Implement initState functionality here
  }

  void addClass() {
    // Define the addClass method functionality here
  }

  void updateClasse() {
    // Define the updateClasse method functionality here
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Class Dialog'),
      content: Text('Class: ${widget.classe}'),
      actions: [
        TextButton(
          onPressed: addClass, // Call addClass when pressed
          child: Text('Add Class'),
        ),
        TextButton(
          onPressed: updateClasse, // Call updateClasse when pressed
          child: Text('Update Class'),
        ),
      ],
    );
  }
}
