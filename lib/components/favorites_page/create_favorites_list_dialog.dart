import 'package:dogpic/components/favorites_page/favorites_list_form.dart';
import 'package:dogpic/models/dog_breed_model.dart';
import 'package:dogpic/providers/breed_notifier.dart';
import 'package:dogpic/utils/colors.dart';
import 'package:dogpic/utils/dictionary.dart';
import 'package:dogpic/utils/size_calculator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Content of bottomsheet for Create a Favorites List
class CreateFavoritesListDialog extends ConsumerStatefulWidget {
  final double listHeight;
  final Function(String title, List<int> breedsIds) onCreate;

  const CreateFavoritesListDialog({
    super.key,
    required this.listHeight,
    required this.onCreate,
  });

  @override
  _CreateFavoritesListDialogState createState() =>
      _CreateFavoritesListDialogState();
}

class _CreateFavoritesListDialogState
    extends ConsumerState<CreateFavoritesListDialog> {
  String selectedTitle = '';
  List<int> selectedBreedIds = [];
  List<DogBreedModel> breeds = [];

  @override
  void initState() {
    super.initState();
    // Load breeds on start
    loadBreeds();
  }

  // Using provider to get all breeds
  Future<void> loadBreeds() async {
    final breedList = ref.read(breedNotifierProvider);
    setState(() {
      breeds = breedList;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Getting the dialog width
    final screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth =
        SizeCalculator.largeContainerWidthCalculator(screenWidth) - 40;

    return Container(
      width: cardWidth,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dialog title text
          Text(Dictionary.favorites_page_new_dialog_title,
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.primaryForeground,
                ),
              )),
          const SizedBox(height: 15),
          // Favorites title and breeds list form
          FavoritesListForm(
            selectedTitle: selectedTitle,
            onTitleChanged: (title) {
              setState(() {
                selectedTitle = title;
              });
            },
            breeds: breeds,
            selectedBreedIds: selectedBreedIds,
            onBreedSelected: (id, isSelected) {
              setState(() {
                if (isSelected) {
                  selectedBreedIds.add(id);
                } else {
                  selectedBreedIds.remove(id);
                }
              });
            },
            listHeight: widget.listHeight,
          ),
          const SizedBox(height: 16),
          // Bottom dialog's buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Cancel button
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
              const SizedBox(width: 8),
              // Save button
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: TextButton(
                  onPressed:
                      // Check if all fields are not empty
                      selectedTitle.isNotEmpty && selectedBreedIds.isNotEmpty
                          ? () {
                              widget.onCreate(selectedTitle, selectedBreedIds);
                              Navigator.of(context).pop(); // Close on save
                            }
                          : null,
                  child: Text(Dictionary.save,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          // Set disabled color if fields are not empty
                          color: selectedTitle.isNotEmpty &&
                                  selectedBreedIds.isNotEmpty
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
}
