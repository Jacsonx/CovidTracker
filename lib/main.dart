import 'package:flutter/material.dart';
import 'package:future_widget/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Future Builder widget',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch:  Colors.teal,
      ),
      home: HomePage(),
    );
  }
}
