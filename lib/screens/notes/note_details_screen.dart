import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '/enums.dart';
import '/styles.dart';
import '/models/note.dart';
import '/providers/categories.dart';
import '/widgets/components/appbars/pushed_note_app_bar.dart';
import '/widgets/components/custom_text.dart';
import '/screens/notes/notes_screen.dart';

class NoteDetailsScreen extends StatefulWidget {
  const NoteDetailsScreen({Key? key}) : super(key: key);

  static const routeName = '/note-details';

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  bool isReading = true;
  AppBarMode mode = AppBarMode.normal;
  final TextEditingController _editingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _editingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Note note = ModalRoute.of(context)!.settings.arguments as Note;
    q.QuillController _controller = q.QuillController(
      document: q.Document.fromJson(jsonDecode(note.description)),
      selection: const TextSelection.collapsed(offset: 0),
    );
    _editingController.text = note.title;
    final prov = Provider.of<Categories>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PushedNoteAppBar(
        mode: mode,
        isPinned: note.isPinned,
        onEdit: () => setState(() {
          isReading = false;
          mode = AppBarMode.onEdit;
        }),
        onSave: () async {
          note.description = json.encode(_controller.document.toDelta());
          note.title = _editingController.text;
          await prov.updateNote(note);
          setState(() {
            isReading = true;
            mode = AppBarMode.normal;
          });
          _unfocusAndShowSnackBar(context, "${note.title} is updated!");
        },
        onDelete: () => _onDelete(context, note, prov),
        onPin: () async {
          await prov.pinNoteSwitch(note);
          setState(() => {});
          final pinnedText = note.isPinned
              ? "${note.title} is pinned!"
              : "${note.title} is unpinned!";
          _unfocusAndShowSnackBar(context, pinnedText);
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: defaultPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: TextType.contentTitle.padding,
                    child: TextField(
                      controller: _editingController,
                      readOnly: isReading,
                      maxLines: 1,
                      style: TextType.contentTitle.style,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  CustomText(
                    DateFormat("dd MMMM yyyy - hh:mm")
                        .format(note.createdTime)
                        .toString(),
                    textType: TextType.subtitleDate,
                  ),
                  Expanded(
                    child: q.QuillEditor(
                      controller: _controller,
                      focusNode: FocusNode(),
                      readOnly: isReading,
                      autoFocus: false,
                      expands: true,
                      scrollable: true,
                      scrollController: ScrollController(),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                      ),
                      placeholder: "Type your note here...",
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!isReading)
            q.QuillToolbar.basic(
              controller: _controller,
              multiRowsDisplay: false,
              showImageButton: false,
              showCameraButton: false,
              showClearFormat: false,
              showVideoButton: false,
            ),
        ],
      ),
    );
  }
}

_unfocusAndShowSnackBar(context, text) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  FocusScope.of(context).unfocus();
  // TODO: Make it widget
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: CustomText(
        text,
        textType: TextType.secondaryButton,
        alignment: TextAlign.center,
      ),
      backgroundColor: primaryColor,
    ),
  );
}

_onDelete(context, note, prov) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: primaryColor,
      title: const CustomText(
        "Delete Note",
        textType: TextType.subtitle,
      ),
      content: const CustomText(
        "Are you sure you want to delete your note?",
      ),
      actions: [
        TextButton(
          child: const CustomText(
            "CANCEL",
            textType: TextType.secondaryButton,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: textColor,
            onPrimary: primaryColor,
          ),
          child: const CustomText(
            "DELETE",
            textType: TextType.primaryButton,
          ),
          onPressed: () async {
            _unfocusAndShowSnackBar(context, "${note.title} is deleted!");
            await prov.deleteNote(note);
            Navigator.pushNamedAndRemoveUntil(
              context,
              NotesScreen.routeName,
              (route) => false,
            );
          },
        ),
      ],
    ),
  );
}
