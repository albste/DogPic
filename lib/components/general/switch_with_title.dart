import 'package:dogpic/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Switch component with a label
class SwitchWithTitle extends StatelessWidget {
  final String title; // Label text
  final bool value; // Switch value
  final ValueChanged<bool> onChanged; // On changed switch value event

  const SwitchWithTitle({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Label
        Text(
          title,
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: AppColors.primaryForeground,
            ),
          ),
        ),
        // Switch
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primary,
        ),
      ],
    );
  }
}
