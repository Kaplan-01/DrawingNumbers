import 'package:flutter/material.dart';
import 'main_screen.dart';

void main()=>runApp(recognition());

class recognition extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.pink,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
      ),
      home: mainScreen(),
    );
  }
}


