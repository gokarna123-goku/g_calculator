import 'package:flutter/material.dart';
// import 'package:calculator/view/neumorphism_calculator/n_calculator.dart';
import 'package:calculator/view/glassmorphism_calculator/g_calculator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neumorphism Calculator',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      debugShowCheckedModeBanner: false,
      // home: NeumorphismCalculatorPage(),
      home: GlassmorphismCalculatorPage(),
    );
  }
}
