import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/enums.dart';
import '/styles.dart';
import '/models/category.dart';
import '/providers/appbar_status.dart';
import '/providers/categories.dart';
import '/widgets/components/custom_text.dart';

class CategoryDialog extends StatelessWidget {
  final ActionType actionType;
  final Category? category;

  const CategoryDialog({Key? key, required this.actionType, this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    Category _category = actionType == ActionType.create
        ? Category(
            id: DateTime.now().toIso8601String(),
            createdTime: DateTime.now(),
            title: "",
          )
        : category ?? Provider.of<AppBarStatus>(context).item as Category;

    void _onSubmit() {
      final _isValid = _formKey.currentState!.validate();
      if (_isValid) {
        _formKey.currentState!.save();
      }
    }

    Future<void> _onSaved(String? value) async {
      _category.title = value!;
      final prov = Provider.of<Categories>(context, listen: false);
      try {
        actionType == ActionType.create
            ? await prov.newCategory(_category)
            : await prov.updateCategory(_category);
        FocusScope.of(context).unfocus();
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CustomText(
              actionType == ActionType.create
                  ? "${_category.title} added to your categories!"
                  : "${_category.title} updated!",
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

    return AlertDialog(
      backgroundColor: primaryColor,
      content: SizedBox(
        height: 150,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Category name",
                  fillColor: Colors.white,
                ),
                validator: (v) {
                  if (v!.isEmpty) {
                    return "Please enter a category name";
                  }
                  return null;
                },
                initialValue: _category.title,
                onSaved: _onSaved,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const CustomText(
                      "CANCEL",
                      textType: TextType.secondaryButton,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: textColor,
                      onPrimary: primaryColor,
                    ),
                    child: CustomText(
                      actionType == ActionType.create ? "ADD" : "UPDATE",
                      textType: TextType.primaryButton,
                    ),
                    onPressed: _onSubmit,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
