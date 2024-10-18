import 'package:dogpic/components/favorites_page/favorites_list_form.dart';
import 'package:dogpic/models/dog_breed_model.dart';
import 'package:dogpic/providers/breed_notifier.dart';
import 'package:dogpic/utils/colors.dart';
import 'package:dogpic/utils/dictionary.dart';
import 'package:dogpic/utils/size_calculator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditFavoritesListDialog extends ConsumerStatefulWidget {
  final double listHeight;
  final Function(String newTitle, List<int> newBreedsIds) onEdit;
  final String initialTitle; // Aggiunto
  final List<int> initialBreedIds; // Aggiunto

  EditFavoritesListDialog({
    required this.listHeight,
    required this.onEdit,
    required this.initialTitle, // Aggiunto
    required this.initialBreedIds, // Aggiunto
  });

  @override
  _EditFavoritesListDialogState createState() =>
      _EditFavoritesListDialogState();
}

class _EditFavoritesListDialogState
    extends ConsumerState<EditFavoritesListDialog> {
  String _selectedTitle = '';
  List<int> _selectedBreedIds = [];
  final ScrollController _scrollController = ScrollController();
  List<DogBreedModel> breeds = [];

  @override
  void initState() {
    super.initState();
    // Carica le razze all'avvio
    loadBreeds();
    // Inizializza il titolo e la lista di ID selezionati
    _selectedTitle = widget.initialTitle; // Aggiunto
    _selectedBreedIds = List.from(widget.initialBreedIds); // Aggiunto
  }

  Future<void> loadBreeds() async {
    final breedList = ref
        .read(breedNotifierProvider); // Usa il provider per ottenere le razze
    setState(() {
      breeds = breedList;
    });
  }

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
          Text(Dictionary.favorites_page_edit_dialog_title,
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.primaryForeground,
                ),
              )),
          SizedBox(height: 15),
          FavoritesListForm(
            selectedTitle: _selectedTitle,
            onTitleChanged: (title) {
              setState(() {
                _selectedTitle = title;
              });
            },
            breeds: breeds,
            selectedBreedIds: _selectedBreedIds,
            onBreedSelected: (id, isSelected) {
              setState(() {
                if (isSelected ?? false) {
                  _selectedBreedIds.add(id);
                } else {
                  _selectedBreedIds.remove(id);
                }
              });
            },
            listHeight: widget.listHeight,
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
                      _selectedTitle.isNotEmpty && _selectedBreedIds.isNotEmpty
                          ? () {
                              widget.onEdit(_selectedTitle, _selectedBreedIds);
                              Navigator.of(context).pop(); // Close on save
                            }
                          : null,
                  child: Text(Dictionary.update,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: _selectedTitle.isNotEmpty &&
                                  _selectedBreedIds.isNotEmpty
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
