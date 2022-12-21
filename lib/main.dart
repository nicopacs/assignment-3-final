
import 'package:final_assignment_3/pages/form_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Assignment 3',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const FormPage(),
    );
  }
}
