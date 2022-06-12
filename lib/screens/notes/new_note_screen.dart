import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:provider/provider.dart';

import '/enums.dart';
import '/styles.dart';
import '/models/note.dart';
import '/models/category.dart';
import '/providers/categories.dart';
import '/widgets/components/custom_text.dart';
import '/widgets/components/icon_text.dart';
import 'category_dialog.dart';

class NewNoteScreen extends StatefulWidget {
  static const routeName = '/new-notes';
  const NewNoteScreen({Key? key}) : super(key: key);

  @override
  _NewNoteScreenState createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  final _quillController = q.QuillController.basic();
  final _formKey = GlobalKey<FormState>();

  List<Category> _categories = [];

  var _title = "";
  var _description = "";
  Category? _currentCategory;

  bool _isDescriptionValid() {
    if (!_quillController.document.isEmpty()) {
      _description = json.encode(_quillController.document.toDelta());
      return true;
    }
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: primaryColor,
        title: const CustomText(
          "Empty note",
          textType: TextType.appBarTitle,
        ),
        content: SizedBox(
          height: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                "Please enter your note...",
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: textColor,
                      onPrimary: primaryColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const CustomText(
                      "OK",
                      textType: TextType.primaryButton,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    return false;
  }

  _addNote() async {
    final _isValid = _isDescriptionValid() && _formKey.currentState!.validate();
    if (_isValid) {
      _formKey.currentState!.save();
      Note note = Note(
        id: DateTime.now().toIso8601String(),
        createdTime: DateTime.now(),
        title: _title,
        description: _description,
      );
      try {
        await Provider.of<Categories>(context, listen: false)
            .newNote(note, _currentCategory!);
        FocusScope.of(context).unfocus();
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CustomText(
              "$_title added to your notes!",
              textType: TextType.secondaryButton,
              alignment: TextAlign.center,
            ),
            backgroundColor: primaryColor,
          ),
        );
      } catch (err) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CustomText(
              "Couldn't add... ERROR: $err",
              textType: TextType.secondaryButton,
              alignment: TextAlign.center,
            ),
            backgroundColor: primaryColor,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _quillController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 16,
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const CustomText(
          "New Note",
          textType: TextType.appBarTitle,
        ),
        actions: [
          IconButton(
            splashRadius: 16,
            icon: const Icon(Icons.save),
            onPressed: () {
              _addNote();
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 12.0,
              ),
              child: Consumer<Categories>(
                builder: (_, categoriesData, __) {
                  _categories = categoriesData.items.values
                      .map((category) => category)
                      .toList();
                  return Form(
                    key: _formKey,
                    child: _categories.isEmpty
                        ? const NoCategoryView()
                        : Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Enter title",
                                  hintStyle: TextType.subtitlePlaceholder.style,
                                ),
                                validator: (v) {
                                  if (v!.isEmpty) {
                                    return "Please enter a title";
                                  }
                                  return null;
                                },
                                onSaved: (v) => _title = v!,
                              ),
                              const SizedBox(height: 12),
                              DropdownButtonFormField<Category>(
                                value: _currentCategory,
                                isExpanded: true,
                                hint: const CustomText(
                                  "Select category",
                                  textType: TextType.subtitlePlaceholder,
                                ),
                                onChanged: (Category? v) {
                                  setState(() {
                                    _currentCategory = v!;
                                  });
                                },
                                validator: (v) {
                                  if (v == null) {
                                    return "Please select a category";
                                  }
                                  return null;
                                },
                                onSaved: (v) => _currentCategory = v!,
                                items: [
                                  ..._categories
                                      .map(
                                        (e) => DropdownMenuItem<Category>(
                                          child: CustomText(
                                            e.title,
                                            textType:
                                                TextType.subtitleZeroPadding,
                                          ),
                                          value: e,
                                        ),
                                      )
                                      .toList()
                                ],
                              ),
                              Expanded(
                                child: q.QuillEditor(
                                  controller: _quillController,
                                  focusNode: FocusNode(),
                                  autoFocus: false,
                                  expands: true,
                                  scrollable: true,
                                  scrollController: ScrollController(),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16.0,
                                  ),
                                  readOnly: false,
                                  placeholder: "Type your note here...",
                                ),
                              ),
                            ],
                          ),
                  );
                },
              ),
            ),
          ),
          if (_categories.isNotEmpty)
            q.QuillToolbar.basic(
              controller: _quillController,
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

class NoCategoryView extends StatelessWidget {
  const NoCategoryView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CustomText(
          "You don't have any categories...",
          textType: TextType.subtitle,
          maxLines: 3,
        ),
        ElevatedButton(
          child: const Padding(
            padding: EdgeInsets.all(4.0),
            child: IconText(
              icon: Icon(Icons.add),
              text: "ADD CATEGORY",
              textType: TextType.secondaryButton,
              iconPosition: IconPosition.left,
              isStretched: false,
            ),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => const CategoryDialog(
                actionType: ActionType.create,
              ),
            );
          },
        )
      ],
    );
  }
}
