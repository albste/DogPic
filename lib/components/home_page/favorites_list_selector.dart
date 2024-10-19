import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dogpic/utils/colors.dart';
import 'package:dogpic/models/favorites_list_model.dart';

// Dropdown with label used to select favorites list to use in search
class FavoritesListSelector extends StatelessWidget {
  final String title; // Label text
  final FavoritesListModel? selectedValue; // Selected favorites list
  final List<FavoritesListModel> items; // All favorites lists
  final ValueChanged<FavoritesListModel?> onChanged; // On selection changed

  const FavoritesListSelector({
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
        // Favorites list dropdown
        DropdownButtonFormField<FavoritesListModel?>(
          value: selectedValue,
          onChanged: (FavoritesListModel? newValue) {
            onChanged(newValue);
          },
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
          // Single list item
          items: items.map<DropdownMenuItem<FavoritesListModel>>(
              (FavoritesListModel item) {
            return DropdownMenuItem<FavoritesListModel>(
              value: item,
              child: Text(
                item.title,
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
