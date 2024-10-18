import 'package:dogpic/components/favorites_page/create_favorites_list_dialog.dart';
import 'package:dogpic/components/favorites_page/edit_favorites_list_dialog.dart';
import 'package:dogpic/models/dog_breed_model.dart';
import 'package:dogpic/models/dog_subbreed_model.dart';
import 'package:dogpic/models/favorites_list_model.dart';
import 'package:dogpic/utils/colors.dart';
import 'package:dogpic/utils/dictionary.dart';
import 'package:dogpic/utils/size_calculator.dart';
import 'package:flutter/material.dart';
import 'package:dogpic/models/favorites_list_model.dart';
import 'package:dogpic/components/favorites_page/favorites_list.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  void _showCreateFavoritesListDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to be full height
      backgroundColor: Colors.transparent, // Make the background transparent
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16), // Add padding if needed
          decoration: BoxDecoration(
            color: Colors.white, // Background color of the bottom sheet
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(16)), // Rounded top corners
          ),
          child: CreateFavoritesListDialog(breeds: [
            DogBreedModel(
                id: 1, name: 'title', hasSubBreeds: true, subBreeds: [])
          ], subBreeds: [
            DogSubBreedModel(id: 1, parentBreedId: 1, title: 'title2')
          ], listHeight: 300), // Your dialog widget
        );
      },
    );
  }

  void _showEditFavoritesListDialog(int itemId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to be full height
      backgroundColor: Colors.transparent, // Make the background transparent
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16), // Add padding if needed
          decoration: BoxDecoration(
            color: Colors.white, // Background color of the bottom sheet
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(16)), // Rounded top corners
          ),
          child: EditFavoritesListDialog(breeds: [
            DogBreedModel(
                id: 1, name: 'title', hasSubBreeds: true, subBreeds: [])
          ], subBreeds: [
            DogSubBreedModel(id: 1, parentBreedId: 1, title: 'title2')
          ], listHeight: 300), // Your dialog widget
        );
      },
    );
  }

  void _deleteItem(int itemId) {}

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double pageWidth =
        SizeCalculator.LargeContainerWidthCalculator(screenWidth);
    final ScrollController _scrollController = ScrollController();
    final List<FavoritesListModel> favorites = [
      FavoritesListModel(
          id: 1,
          title: 'title',
          selectedBreedIds: [1],
          selectedSubBreedIds: [2]),
      FavoritesListModel(
          id: 1,
          title: 'title',
          selectedBreedIds: [1],
          selectedSubBreedIds: [2]),
      FavoritesListModel(
          id: 1,
          title: 'title',
          selectedBreedIds: [1],
          selectedSubBreedIds: [2]),
      FavoritesListModel(
          id: 1,
          title: 'title',
          selectedBreedIds: [1],
          selectedSubBreedIds: [2]),
      FavoritesListModel(
          id: 1,
          title: 'title',
          selectedBreedIds: [1],
          selectedSubBreedIds: [2]),
      FavoritesListModel(
          id: 1,
          title: 'title',
          selectedBreedIds: [1],
          selectedSubBreedIds: [2]),
      FavoritesListModel(
          id: 1,
          title: 'title',
          selectedBreedIds: [1],
          selectedSubBreedIds: [2]),
      FavoritesListModel(
          id: 1,
          title: 'title',
          selectedBreedIds: [1],
          selectedSubBreedIds: [2]),
      FavoritesListModel(
          id: 1,
          title: 'title',
          selectedBreedIds: [1],
          selectedSubBreedIds: [2]),
      FavoritesListModel(
          id: 1,
          title: 'title',
          selectedBreedIds: [1],
          selectedSubBreedIds: [2]),
      FavoritesListModel(
          id: 1,
          title: 'title',
          selectedBreedIds: [1],
          selectedSubBreedIds: [2]),
      FavoritesListModel(
          id: 1,
          title: 'title',
          selectedBreedIds: [1],
          selectedSubBreedIds: [2]),
      FavoritesListModel(
          id: 1,
          title: 'title',
          selectedBreedIds: [1],
          selectedSubBreedIds: [2]),
      FavoritesListModel(
          id: 1,
          title: 'title',
          selectedBreedIds: [1],
          selectedSubBreedIds: [2]),
      FavoritesListModel(
          id: 1,
          title: 'title',
          selectedBreedIds: [1],
          selectedSubBreedIds: [2]),
      FavoritesListModel(
          id: 1,
          title: 'title2',
          selectedBreedIds: [1],
          selectedSubBreedIds: [2]),
    ]; // List of favorite items

    return Center(
      child: Container(
        width: pageWidth,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Icon(Icons.favorite_border,
                      color: AppColors.primary, size: 30),
                  SizedBox(width: 10),
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
            SizedBox(height: 20),
            // Show message if the favorites list is empty, otherwise show the list
            favorites.isEmpty
                ? Center(
                    child: Text(
                      'No list added. Please create one',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors
                            .grey[600], // Adjust the color to match your theme
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(top: 80, bottom: 50),
                    child: Container(
                      child: FavoritesList(
                        itemList: favorites,
                        scrollController: _scrollController,
                        onEdit: _showEditFavoritesListDialog,
                        onDelete: _deleteItem,
                      ),
                    )),
            // Positioned add button (+)
            Positioned(
              bottom: 16,
              right: 20,
              child: FloatingActionButton(
                onPressed: _showCreateFavoritesListDialog,
                backgroundColor: AppColors.primary,
                child: Icon(
                  Icons.add,
                  size: 30,
                  color: AppColors.secondaryForeground,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(50), // Rende il bordo rotondo
                ),
              ),
              //  FloatingActionButton(
              //   onPressed: _showCreateFavoritesListDialog,
              //   backgroundColor: Colors.blue, // Adjust color as needed
              //   child: Icon(Icons.add, color: Colors.white),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
