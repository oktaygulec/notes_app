import 'package:flutter/material.dart';
import 'package:notesapp/models/note.dart';

class NoteScreen extends StatelessWidget {
  final Note note;
  const NoteScreen({
    required this.note,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return scaffold
    return Container(
      child: Text("hello"),
    );
  }
}
