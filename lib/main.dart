import 'package:dogpic/pages/page_container.dart';
import 'package:flutter/material.dart';
import 'package:dogpic/utils/settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Global vars definitions file

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Settings.appTitle,
      debugShowCheckedModeBanner: false, // Remove the debug banner
      home: PageContainer(), // Set the page container as home
    );
  }
}
