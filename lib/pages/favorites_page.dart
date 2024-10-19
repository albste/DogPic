import 'package:dogpic/components/favorites_page/create_favorites_list_dialog.dart';
import 'package:dogpic/components/favorites_page/edit_favorites_list_dialog.dart';
import 'package:dogpic/models/favorites_list_model.dart';
import 'package:dogpic/providers/favorites_notifier.dart';
import 'package:dogpic/utils/colors.dart';
import 'package:dogpic/utils/dictionary.dart';
import 'package:dogpic/utils/size_calculator.dart';
import 'package:flutter/material.dart';
import 'package:dogpic/components/favorites_page/favorites_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritesPage extends ConsumerStatefulWidget {
  const FavoritesPage({super.key});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends ConsumerState<FavoritesPage> {
  // On create new list pressed
  void showCreateFavoritesListDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to be full height
      backgroundColor: Colors.transparent, // Make the background transparent
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white, // Background color of the bottom sheet
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(16)), // Rounded top corners
          ),
          child: CreateFavoritesListDialog(
              onCreate: (title, breedsIds) {
                ref
                    .read(favoritesProvider.notifier)
                    .addFavorite(title, breedsIds);
              },
              listHeight: 300),
        );
      },
    );
  }

  // On edit list pressed
  void showEditFavoritesListDialog(FavoritesListModel item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to be full height
      backgroundColor: Colors.transparent, // Make the background transparent
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white, // Background color of the bottom sheet
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(16)), // Rounded top corners
          ),
          child: EditFavoritesListDialog(
              initialTitle: item.title,
              initialBreedIds: item.selectedBreedIds,
              onEdit: (newTitle, newBreedsIds) {
                ref.read(favoritesProvider.notifier).updateFavorite(
                      item.id,
                      newTitle,
                      newBreedsIds,
                    );
              },
              listHeight: 300),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the width of the page
    final screenWidth = MediaQuery.of(context).size.width;
    final double pageWidth =
        SizeCalculator.largeContainerWidthCalculator(screenWidth);

    final ScrollController scrollController = ScrollController();

    // Get all favorites lists
    final favoritesList = ref.watch(favoritesProvider);

    return Center(
      child: Container(
        width: pageWidth,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  // Heart icon
                  Icon(Icons.favorite_border,
                      color: AppColors.primary, size: 30),
                  const SizedBox(width: 10),
                  // Favorites title
                  Text(Dictionary.favorites_page_title,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: AppColors.primaryForeground,
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Show message if the favorites list is empty, otherwise show the list
            favoritesList.isEmpty
                ? Center(
                    child: Text(
                      Dictionary.favorites_page_empty_list_message,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: AppColors.primaryForeground.withOpacity(0.5),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 80, bottom: 50),
                    child: Container(
                      child: FavoritesList(
                        itemList: favoritesList,
                        scrollController: scrollController,
                        onEdit: showEditFavoritesListDialog,
                        onDelete: (idToDelete) {
                          ref
                              .read(favoritesProvider.notifier)
                              .removeFavorite(idToDelete);
                        },
                      ),
                    )),
            // Add list button
            Positioned(
              bottom: 16,
              right: 20,
              child: FloatingActionButton(
                onPressed: showCreateFavoritesListDialog,
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                  Icons.add,
                  size: 30,
                  color: AppColors.secondaryForeground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
