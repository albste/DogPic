import 'package:dogpic/utils/colors.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final VoidCallback onGoHome; // Callback to go back to Home

  // Constructor to accept the callback
  ResultPage({required this.onGoHome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // Remove the app bar
      backgroundColor: AppColors.pageBackground,
      body: Center(
        child: ElevatedButton(
          onPressed: onGoHome, // Use the callback to navigate back
          child: Text('Go to Home'),
        ),
      ),
    );
  }
}
