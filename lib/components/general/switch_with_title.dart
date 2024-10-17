import 'package:dogpic/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SwitchWithTitle extends StatelessWidget {
  final String title; // Titolo del switch
  final bool value; // Stato del switch
  final ValueChanged<bool> onChanged; // Callback per il cambiamento dello stato

  const SwitchWithTitle({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
        Switch(
          value: value,
          onChanged: onChanged, // Trigger per il cambiamento dello stato
          activeColor: AppColors.primary,
        ),
      ],
    );
  }
}
