import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/styles.dart';
import '/providers/appbar_status.dart';
import '/providers/categories.dart';
import '/screens/home/home_screen.dart';

void main() {
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
        home: const HomeScreen(),
        routes: {
          HomeScreen.routeName: (ctx) => const HomeScreen(),
        },
      ),
    );
  }
}
