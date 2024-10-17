import 'package:dogpic/pages/page_container.dart';
import 'package:flutter/material.dart';
import 'package:dogpic/utils/globals.dart'; // Global vars definitions file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Globals.appTitle,
      debugShowCheckedModeBanner: false, // Remove the debug banner
      home: PageContainer(), // Set the page container as home
    );
  }
}
