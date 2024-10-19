import 'package:dogpic/components/general/dropdown_with_title.dart';
import 'package:dogpic/components/general/switch_with_title.dart';
import 'package:dogpic/components/home_page/favorites_list_selector.dart';
import 'package:dogpic/models/dog_breed_model.dart';
import 'package:dogpic/models/favorites_list_model.dart';
import 'package:dogpic/models/search_settings_model.dart';
import 'package:dogpic/providers/favorites_notifier.dart';
import 'package:dogpic/utils/colors.dart';
import 'package:dogpic/utils/dictionary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dogpic/providers/breed_notifier.dart';

// Search card used on home page
class SearchCard extends ConsumerStatefulWidget {
  final double width;
  final bool isSearching; // Var that set if is waiting api call's
  final Function(SearchSettingsModel) onSearch; // On search clicked

  const SearchCard({
    super.key,
    required this.width,
    required this.onSearch,
    required this.isSearching,
  });

  @override
  _SearchCardState createState() => _SearchCardState();
}

class _SearchCardState extends ConsumerState<SearchCard> {
  bool useFavoriteList = false;
  bool randomImages = true;
  bool switchAnimationEnabled =
      false; // Use this to manage animation of use favorites list switch
  String? selectedBreed;
  String? selectedSubBreed;
  FavoritesListModel? favoriteListToUse;

  // They will be filled by the providers
  List<DogBreedModel> breeds = [];
  List<String> subbreeds = [];

  // Load breeds on start
  @override
  void initState() {
    super.initState();
    loadBreeds();
  }

  Future<void> loadBreeds() async {
    final breedList =
        ref.read(breedNotifierProvider); // Using provider to get all breeds
    setState(() {
      breeds = breedList;
      selectedBreed = breeds.isNotEmpty ? breeds[0].name : null;
      updateSubBreeds(); // Update the sub breeds
    });
  }

  void updateSubBreeds() {
    if (selectedBreed != null) {
      // Find the right breed
      final breed = breeds.firstWhere((b) => b.name == selectedBreed,
          orElse: () => DogBreedModel(
              id: -1, name: '', hasSubBreeds: false, subBreeds: []));

      setState(() {
        // Add "All sub breeds" as first item
        subbreeds = ['All sub breeds'] +
            breed.subBreeds.map((sub) => sub.title).toList();
        selectedSubBreed = subbreeds[0]; // Pre-select "All sub breeds" item
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get all favorites lists
    final favoritesLists = ref.watch(favoritesProvider);
    // Pre-select first favorites list item if there is at least one list
    if (favoritesLists.isNotEmpty && favoriteListToUse == null) {
      favoriteListToUse = favoritesLists[0];
    }

    return Container(
      width: widget.width,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.11),
            spreadRadius: 5,
            blurRadius: 20,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo with title
            Row(
              children: [
                SvgPicture.asset(
                  'lib/assets/svgs/dogpic_only_image_dark.svg',
                  height: 40,
                ),
                const SizedBox(width: 10),
                Text(
                  Dictionary.search_card_title,
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: AppColors.primaryForeground,
                    ),
                  ),
                ),
              ],
            ),
            // Divider
            Container(
              margin:
                  const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 15),
              child: Divider(
                color: AppColors.primary,
                thickness: 0.5,
              ),
            ),
            // AnimatedSwitcher for dropdowns
            AnimatedSwitcher(
                duration:
                    Duration(milliseconds: switchAnimationEnabled ? 300 : 0),
                child: useFavoriteList
                    ?
                    // Favorites list dropdown
                    FavoritesListSelector(
                        title: Dictionary.search_card_favorite_list,
                        selectedValue: favoriteListToUse,
                        items: favoritesLists,
                        onChanged: (newValue) {
                          setState(() {
                            favoriteListToUse = newValue;
                          });
                        },
                      )
                    : Column(
                        children: [
                          // Breed dropdown
                          DropdownWithTitle(
                            title: Dictionary.search_card_breed,
                            selectedValue: selectedBreed,
                            items: breeds.map((breed) => breed.name).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedBreed = newValue;
                                updateSubBreeds();
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          // Sub breed dropdown
                          DropdownWithTitle(
                            title: Dictionary.search_card_subbreed,
                            selectedValue: selectedSubBreed,
                            items: subbreeds,
                            onChanged: (newValue) {
                              setState(() {
                                selectedSubBreed = newValue;
                              });
                            },
                          ),
                        ],
                      )),
            const SizedBox(height: 20),
            // Use Favorite List Switch
            SwitchWithTitle(
              title: Dictionary.search_card_favorite_list_switch,
              value: useFavoriteList,
              onChanged: (newValue) {
                if (newValue && favoritesLists.isEmpty) {
                  // Snackbar message if no lists are available
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          Dictionary.empty_favorites_list_snackbar_message),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  return; // Don't change switch value if no lists are available
                }

                // Update switch value if there is at least one favorites list
                setState(() {
                  useFavoriteList = newValue;
                });
              },
            ),
            const SizedBox(height: 10),
            // Random switch available only if use favorites list switch is false
            !useFavoriteList
                ? SwitchWithTitle(
                    title: Dictionary.search_card_random_images_switch,
                    value: randomImages,
                    onChanged: (newValue) {
                      setState(() {
                        randomImages = newValue;
                      });
                    },
                  )
                : const SizedBox(height: 5),
            const SizedBox(height: 30),
            // Search Button
            Align(
              alignment: Alignment.centerRight,
              child: widget.isSearching
                  ? CircularProgressIndicator(
                      color: AppColors.primary,
                    )
                  : FloatingActionButton(
                      onPressed: () => widget.onSearch(SearchSettingsModel(
                        breed: selectedBreed!,
                        subBreed: selectedSubBreed!,
                        useFavoriteList: useFavoriteList,
                        favoriteListToUse: favoriteListToUse,
                        randomImages: randomImages,
                      )),
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        Icons.search,
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
