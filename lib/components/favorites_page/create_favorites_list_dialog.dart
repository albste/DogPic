import 'package:dogpic/models/dog_breed_model.dart';
import 'package:dogpic/models/dog_subbreed_model.dart';
import 'package:dogpic/utils/colors.dart';
import 'package:dogpic/utils/dictionary.dart';
import 'package:dogpic/utils/size_calculator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateFavoritesListDialog extends StatefulWidget {
  final List<DogBreedModel> breeds;
  final List<DogSubBreedModel> subBreeds;
  final double listHeight;

  CreateFavoritesListDialog({
    required this.breeds,
    required this.subBreeds,
    required this.listHeight,
  });

  @override
  _CreateFavoritesListDialogState createState() =>
      _CreateFavoritesListDialogState();
}

class _CreateFavoritesListDialogState extends State<CreateFavoritesListDialog> {
  String _selectedTitle = '';
  int? _selectedBreedId;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth =
        SizeCalculator.LargeContainerWidthCalculator(screenWidth) - 40;

    return Container(
      width: cardWidth,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Dictionary.favorites_page_new_dialog_title,
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.primaryForeground,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(Dictionary.title,
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.primaryForeground,
                    ),
                  ))),
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
            onChanged: (value) {
              setState(() {
                _selectedTitle = value;
              });
            },
          ),
          Padding(
              padding: EdgeInsets.only(top: 30, bottom: 10),
              child: Text(Dictionary.breeds,
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.primaryForeground,
                    ),
                  ))),
          Container(
            height: widget.listHeight,
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: ListView(
                controller: _scrollController,
                children: _buildBreedList(),
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(Dictionary.cancel,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: AppColors.primaryForeground,
                        ),
                      )),
                ),
              ),
              SizedBox(width: 8),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: TextButton(
                  onPressed:
                      _selectedTitle.isNotEmpty && _selectedBreedId != null
                          ? () {
                              Navigator.of(context).pop(); // Close on save
                            }
                          : null,
                  child: Text(Dictionary.save,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: _selectedTitle.isNotEmpty &&
                                  _selectedBreedId != null
                              ? AppColors.primaryForeground
                              : AppColors.primaryForeground.withOpacity(0.5),
                        ),
                      )),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildBreedList() {
    List<Widget> breedWidgets = [];

    for (var breed in widget.breeds) {
      breedWidgets.add(
        RadioListTile<int>(
          title: Text(breed.name),
          value: breed.id,
          groupValue: _selectedBreedId,
          onChanged: (value) {
            setState(() {
              _selectedBreedId = value;
            });
          },
        ),
      );

      if (breed.hasSubBreeds) {
        for (var subBreed
            in widget.subBreeds.where((sub) => sub.parentBreedId == breed.id)) {
          breedWidgets.add(
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: RadioListTile<int>(
                title: Text(subBreed.title),
                value: subBreed.id,
                groupValue: _selectedBreedId,
                onChanged: (value) {
                  setState(() {
                    _selectedBreedId = value;
                  });
                },
              ),
            ),
          );
        }
      }
    }
    return breedWidgets;
  }
}
