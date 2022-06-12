import 'package:flutter/material.dart';

import '/enums.dart';

class PushedNoteAppBar extends StatelessWidget with PreferredSizeWidget {
  final Function()? onEdit;
  final Function()? onSave;
  final Function()? onDelete;
  final Function()? onPin;
  final bool isPinned;
  final AppBarMode mode;

  const PushedNoteAppBar({
    Key? key,
    this.mode = AppBarMode.normal,
    required this.onEdit,
    required this.onSave,
    required this.onDelete,
    required this.onPin,
    this.isPinned = false,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final normalModeActions = [
      IconButton(
        splashRadius: 16,
        icon: isPinned
            ? const Icon(Icons.push_pin)
            : const Icon(Icons.push_pin_outlined),
        onPressed: onPin,
      ),
      IconButton(
        splashRadius: 16,
        icon: const Icon(Icons.delete),
        onPressed: onDelete,
      ),
      IconButton(
        splashRadius: 16,
        icon: const Icon(Icons.edit),
        onPressed: onEdit,
      ),
    ];

    final editModeActions = [
      IconButton(
        splashRadius: 16,
        icon: const Icon(Icons.save),
        onPressed: onSave,
      ),
    ];

    return AppBar(
      leading: IconButton(
        splashRadius: 16,
        icon: const Icon(Icons.arrow_back_ios_new_sharp),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: mode == AppBarMode.normal ? normalModeActions : editModeActions,
    );
  }
}
