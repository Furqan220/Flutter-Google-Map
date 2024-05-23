import 'package:flutter/material.dart';
import 'package:fluttergooglemap/google_map_view.dart';
import 'package:fluttergooglemap/index_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      themeAnimationCurve: Curves.bounceInOut,
      themeAnimationDuration: const Duration(seconds: 1),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.deepOrange,
        ),
      ),
      home: const IndexScreen(),
    );
  }
}
