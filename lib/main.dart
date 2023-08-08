import 'package:capstoneapp1/pages/loadingPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 40.0, fontFamily: 'Rubik'),
          titleMedium: TextStyle(fontSize: 30.0, fontFamily: 'Rubik'),
          titleSmall: TextStyle(
              fontFamily: 'Edusa',
              fontSize: 35.0,
              fontWeight: FontWeight.bold,
              color: Colors.green),
          labelMedium: TextStyle(
              fontFamily: 'Anton', fontWeight: FontWeight.bold, fontSize: 30.0),
        ),
        primaryColor: Colors.green[400],
        primarySwatch: Colors.green,
      ),
      home: loadingPage(),
    );
  }
}
