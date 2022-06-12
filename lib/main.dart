import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notesapp/screens/notes/category_details_screen.dart';
import 'package:provider/provider.dart';

import '/styles.dart';
import '/models/category.dart';
import '/models/note.dart';
import '/providers/appbar_status.dart';
import '/providers/categories.dart';
import '/screens/notes/new_note_screen.dart';
import '/screens/notes/notes_screen.dart';
import '/screens/notes/note_details_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(CategoryAdapter());
  await Hive.openBox<Category>('categories');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Categories(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => AppBarStatus(),
        ),
      ],
      child: MaterialApp(
        title: 'Notes App',
        theme: buildTheme(),
        debugShowCheckedModeBanner: false,
        home: const NotesScreen(),
        routes: {
          NotesScreen.routeName: (ctx) => const NotesScreen(),
          NewNoteScreen.routeName: (ctx) => const NewNoteScreen(),
          NoteDetailsScreen.routeName: (ctx) => const NoteDetailsScreen(),
          CategoryDetailsScreen.routeName: (ctx) =>
              const CategoryDetailsScreen()
        },
      ),
    );
  }
}
