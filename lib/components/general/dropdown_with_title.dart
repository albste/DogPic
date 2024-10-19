import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dogpic/utils/colors.dart';

// Dropdown component with a label above
class DropdownWithTitle extends StatelessWidget {
  final String title; // Label text
  final String? selectedValue; // Selected dropdown's value
  final List<String> items; // Items of dropdown
  final ValueChanged<String?> onChanged; // On selection changed event

  const DropdownWithTitle({
    super.key,
    required this.title,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          title,
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w700,
              fontSize: 17,
              color: AppColors.primaryForeground,
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Dropdown
        DropdownButtonFormField<String>(
          value: selectedValue,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 2,
              ),
            ),
          ),
          // Down arrow icon
          icon: Icon(
            Icons.arrow_drop_down,
            color: AppColors.primary,
          ),
          dropdownColor: Colors.white,
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: AppColors.primaryForeground,
            ),
          ),
          items: items.map<DropdownMenuItem<String>>((String value) {
            // Single dropdown item
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: AppColors.primaryForeground,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
