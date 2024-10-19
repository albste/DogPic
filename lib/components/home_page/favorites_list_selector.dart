import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dogpic/utils/colors.dart'; // Modifica in base alla tua struttura dei pacchetti
import 'package:dogpic/models/favorites_list_model.dart'; // Assicurati di importare il tuo modello

class FavoritesListSelector extends StatelessWidget {
  final String title; // Titolo del dropdown
  final FavoritesListModel? selectedValue; // Oggetto selezionato
  final List<FavoritesListModel> items; // Lista di elementi del dropdown
  final ValueChanged<FavoritesListModel?>
      onChanged; // Callback per il cambiamento della selezione

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
        // Titolo del Dropdown
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
                color: AppColors.primary, // Colore del bordo non selezionato
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: AppColors.primary, // Colore del bordo non selezionato
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: AppColors.primary, // Colore del bordo selezionato
                width: 2,
              ),
            ),
          ),
          icon: Icon(
            Icons.arrow_drop_down,
            color: AppColors.primary, // Colore dell'icona del dropdown
          ),
          dropdownColor: Colors.white, // Sfondo bianco per il menu dropdown
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: AppColors.primaryForeground,
            ),
          ),
          items: items.map<DropdownMenuItem<FavoritesListModel>>(
              (FavoritesListModel item) {
            return DropdownMenuItem<FavoritesListModel>(
              value: item,
              child: Text(
                item.title, // Mostra il titolo
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: AppColors
                        .primaryForeground, // Colore del testo degli item
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
