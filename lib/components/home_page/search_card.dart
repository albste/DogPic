import 'package:dogpic/components/general/dropdown_with_title.dart';
import 'package:dogpic/components/general/switch_with_title.dart';
import 'package:dogpic/models/search_settings_model.dart';
import 'package:dogpic/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchCard extends StatefulWidget {
  final double width;
  final Function(SearchSettingsModel) onSearch;

  const SearchCard({
    required this.width,
    required this.onSearch,
  });

  @override
  _SearchCardState createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  bool useFavoriteList = false;
  bool randomImages = true;
  bool switchAnimationEnabled = false;
  String? selectedBreed;
  String? selectedSubBreed;
  String? favoriteList;

  final List<String> breeds = ['African', 'Bulldog', 'Labrador', 'Poodle'];

  final List<String> subbreeds = [
    'All sub breeds',
    'Sub 1',
    'Sub 2',
  ];

  final List<String> favoriteLists = ['List 1', 'List 2', 'List 3'];

  @override
  void initState() {
    super.initState();
    selectedBreed = breeds[0];
    selectedSubBreed = subbreeds[0];
    favoriteList = favoriteLists[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.11),
            spreadRadius: 5,
            blurRadius: 20,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'lib/assets/svgs/dogpic_only_image_dark.svg',
                  height: 40,
                ),
                SizedBox(width: 10),
                Text(
                  'Search dogs pictures',
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
                    ? DropdownWithTitle(
                        title: 'Favorite list to use',
                        selectedValue: favoriteList,
                        items: favoriteLists,
                        onChanged: (newValue) {
                          setState(() {
                            favoriteList =
                                newValue; // Aggiorna il valore selezionato
                          });
                        },
                      )
                    : Column(
                        children: [
                          DropdownWithTitle(
                            title: 'Breed',
                            selectedValue: selectedBreed,
                            items: breeds,
                            onChanged: (newValue) {
                              setState(() {
                                selectedBreed =
                                    newValue; // Aggiorna il valore selezionato
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          DropdownWithTitle(
                            title: 'Sub Breed',
                            selectedValue: selectedSubBreed,
                            items: subbreeds,
                            onChanged: (newValue) {
                              setState(() {
                                selectedSubBreed =
                                    newValue; // Aggiorna il valore selezionato
                              });
                            },
                          ),
                        ],
                      )),
            SizedBox(height: 20),
            // Use Favorite List Switch
            SwitchWithTitle(
              title: 'Use a favorite list',
              value: useFavoriteList,
              onChanged: (newValue) {
                setState(() {
                  useFavoriteList = newValue; // Aggiorna lo stato del switch
                });
              },
            ),
            SizedBox(height: 10),
            SwitchWithTitle(
              title: 'Random images',
              value: randomImages,
              onChanged: (newValue) {
                setState(() {
                  randomImages = newValue; // Aggiorna lo stato del switch
                });
              },
            ),
            SizedBox(height: 30),
            // Search Button
            Align(
              alignment: Alignment.centerRight,
              child: FloatingActionButton(
                onPressed: () =>
                    widget.onSearch(SearchSettingsModel(name: 'name')),
                backgroundColor: AppColors.primary,
                child: Icon(
                  Icons.search,
                  size: 30,
                  color: AppColors.secondaryForeground,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(50), // Rende il bordo rotondo
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// child: Center(
//         child: Column(children: [
//       Container(
//         height: 500,
//         margin: EdgeInsets.all(20),
//         color: Colors.grey[200],
//         child: Center(
//           child: Text('Example Content'),
//         ),
//       ),
//     ])),
