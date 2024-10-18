import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dogpic/models/dog_breed_model.dart';
import 'package:dogpic/utils/colors.dart';
import 'package:dogpic/utils/dictionary.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritesListForm extends StatelessWidget {
  final String selectedTitle;
  final Function(String) onTitleChanged;
  final List<DogBreedModel> breeds;
  final List<int> selectedBreedIds;
  final Function(int id, bool isSelected) onBreedSelected;
  final double listHeight;

  const FavoritesListForm({
    Key? key,
    required this.selectedTitle,
    required this.onTitleChanged,
    required this.breeds,
    required this.selectedBreedIds,
    required this.onBreedSelected,
    required this.listHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Dictionary.title,
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: AppColors.primaryForeground,
            ),
          ),
        ),
        TextField(
          cursorColor: AppColors.primaryForeground,
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: AppColors.primaryForeground,
            ),
          ),
          decoration: InputDecoration(
            hintText: Dictionary.favorites_page_enter_title_placeholder,
            hintStyle: TextStyle(
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: AppColors.primaryForeground.withOpacity(0.6),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primary,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 2.0,
              ),
            ),
          ),
          onChanged: onTitleChanged,
          controller: TextEditingController(
              text: selectedTitle), // Assicurati di impostare il controller
        ),
        Padding(
          padding: EdgeInsets.only(top: 30, bottom: 10),
          child: Text(
            Dictionary.breeds,
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppColors.primaryForeground,
              ),
            ),
          ),
        ),
        Container(
          height: listHeight,
          child: ListView(
            children: breeds.map((breed) {
              return CheckboxListTile(
                title: Text(breed.name),
                value: selectedBreedIds.contains(breed.id),
                activeColor: AppColors.primary,
                onChanged: (isSelected) {
                  onBreedSelected(breed.id, isSelected ?? false);
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
