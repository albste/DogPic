import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Assicurati di avere la dipendenza di google_fonts nel tuo pubspec.yaml
import 'package:dogpic/utils/colors.dart'; // Modifica in base alla tua struttura dei pacchetti

class DropdownWithTitle extends StatelessWidget {
  final String title; // Titolo del dropdown
  final String? selectedValue; // Valore selezionato
  final List<String> items; // Lista di elementi del dropdown
  final ValueChanged<String?>
      onChanged; // Callback per il cambiamento della selezione

  const DropdownWithTitle({
    Key? key,
    required this.title,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      key: ValueKey('breedSubBreedDropdowns'),
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
        SizedBox(height: 10),
        // Dropdown
        DropdownButtonFormField<String>(
          value: selectedValue,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15),
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
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
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
