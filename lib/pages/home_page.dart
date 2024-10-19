import 'package:dogpic/components/home_page/search_card.dart';
import 'package:dogpic/components/home_page/top_rectangle.dart';
import 'package:dogpic/models/search_settings_model.dart';
import 'package:dogpic/providers/breed_notifier.dart';
import 'package:dogpic/providers/dog_providers.dart';
import 'package:dogpic/utils/colors.dart';
import 'package:dogpic/utils/size_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'result_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool showResultPage = false; // Flag to control the displayed content
  bool isSearching = false; // Flag to control if search is loading
  List<String> resultUrls = [];

  // On search button pressed
  void onSearch(SearchSettingsModel searchSettings) async {
    setState(() {
      isSearching = true;
    });

    //Search logics
    List<String> tmpResultUrls = [];
    try {
      // If use favorite list is selected get an image for each breed selected in the list
      if (searchSettings.useFavoriteList &&
          searchSettings.favoriteListToUse != null) {
        final breedList = ref.read(breedNotifierProvider);
        List<String> selectedBreedNames = searchSettings
            .favoriteListToUse!.selectedBreedIds
            .map((id) => breedList.firstWhere((breed) => breed.id == id).name)
            .where((name) => name.isNotEmpty) // Filter empty names
            .toList();
        final urls = await ref
            .read(randomImagesByBreedsProvider(selectedBreedNames).future);
        tmpResultUrls = urls;
      } else {
        if (searchSettings.randomImages) {
          // If random image is selected
          if (searchSettings.subBreed == 'All sub breeds') {
            // If all sub breeds is selected
            final url = await ref
                .read(randomImageProvider(searchSettings.breed).future);
            tmpResultUrls = [url];
          } else {
            // If a specific sub breed is selected
            final url = await ref.read(randomImageBySubBreedProvider(
                [searchSettings.breed, searchSettings.subBreed]).future);
            tmpResultUrls = [url];
          }
        } else {
          // If random image is not selected
          if (searchSettings.subBreed == 'All sub breeds') {
            // If all sub breeds is selected
            final urls = await ref
                .read(imagesByBreedProvider(searchSettings.breed).future);
            tmpResultUrls = urls;
          } else {
            // If a specific sub breed is selected
            final urls = await ref.read(imagesBySubBreedProvider(
                [searchSettings.breed, searchSettings.subBreed]).future);
            tmpResultUrls = urls;
          }
        }
      }
    } catch (e) {
      tmpResultUrls = []; // Error retriving urls
    }

    setState(() {
      resultUrls = tmpResultUrls;
      isSearching = false;
      showResultPage = true; // Change the flag to show Result Page
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the total screen height and width
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate the height of the top rectangle
    final double topRectangleHeight = screenHeight * 0.25;

    // Set the max width for the card
    final double cardWidth =
        SizeCalculator.largeContainerWidthCalculator(screenWidth);

    return Scaffold(
        appBar: null,
        backgroundColor: AppColors.pageBackground,
        body: showResultPage
            ? Center(
                child: ResultPage(
                    resultUrls: resultUrls,
                    // Pass the callback to go back to HomePage
                    onGoHome: () {
                      setState(() {
                        showResultPage =
                            false; // Change the flag to show HomePage
                      });
                    }))
            : SingleChildScrollView(
                child: Stack(
                  children: [
                    // Top Rectangle with logo
                    TopRectangle(
                        width: screenWidth, height: topRectangleHeight),
                    // Card with search form
                    Container(
                        transform: Matrix4.translationValues(
                            (screenWidth - cardWidth) / 2,
                            topRectangleHeight * 0.7,
                            0.0),
                        child: Column(
                          children: [
                            SearchCard(
                              width: cardWidth,
                              isSearching: isSearching,
                              onSearch: onSearch,
                            ),
                            //Box to leave empty space on bottom of the page
                            const SizedBox(height: 170)
                          ],
                        )),
                  ],
                ),
              ));
  }
}
