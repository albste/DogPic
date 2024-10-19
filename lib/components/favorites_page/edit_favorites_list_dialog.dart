import 'package:dogpic/components/favorites_page/favorites_list_form.dart';
import 'package:dogpic/models/dog_breed_model.dart';
import 'package:dogpic/providers/breed_notifier.dart';
import 'package:dogpic/utils/colors.dart';
import 'package:dogpic/utils/dictionary.dart';
import 'package:dogpic/utils/size_calculator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Content of bottomsheet for Edit a Favorites List
class EditFavoritesListDialog extends ConsumerStatefulWidget {
  final double listHeight; //Fixed size of breeds's checkboxes list
  final Function(String newTitle, List<int> newBreedsIds)
      onEdit; //On edit pressed function trigger
  final String initialTitle; //The current title of the list to be edited
  final List<int>
      initialBreedIds; //The current breeds selected of the list to be edited

  const EditFavoritesListDialog({
    super.key,
    required this.listHeight,
    required this.onEdit,
    required this.initialTitle,
    required this.initialBreedIds,
  });

  @override
  _EditFavoritesListDialogState createState() =>
      _EditFavoritesListDialogState();
}

class _EditFavoritesListDialogState
    extends ConsumerState<EditFavoritesListDialog> {
  String selectedTitle = '';
  List<int> selectedBreedIds = [];
  List<DogBreedModel> breeds = [];

  @override
  void initState() {
    super.initState();
    //Load breeds on start
    loadBreeds();
    //Get initial values
    selectedTitle = widget.initialTitle; // Aggiunto
    selectedBreedIds = List.from(widget.initialBreedIds); // Aggiunto
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
          Text(Dictionary.favorites_page_edit_dialog_title,
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
              // Updated button
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: TextButton(
                  onPressed:
                      // Check if all fields are not empty
                      selectedTitle.isNotEmpty && selectedBreedIds.isNotEmpty
                          ? () {
                              widget.onEdit(selectedTitle, selectedBreedIds);
                              Navigator.of(context).pop(); // Close on save
                            }
                          : null,
                  child: Text(Dictionary.update,
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
