import 'package:dogpic/components/home_page/search_card.dart';
import 'package:dogpic/components/home_page/top_rectangle.dart';
import 'package:dogpic/models/search_settings_model.dart';
import 'package:dogpic/providers/dog_providers.dart';
import 'package:dogpic/utils/colors.dart';
import 'package:dogpic/utils/size_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'result_page.dart'; // Import the ResultPage

class HomePage extends ConsumerStatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool _showResultPage = false; // Flag to control the displayed content
  bool _isSearching = false; // Flag to control if search is loading
  List<String> _resultUrls = [];

  void _onSearch(SearchSettingsModel searchSettings) async {
    setState(() {
      _isSearching = true;
    });

    //Search logics
    List<String> resultUrls = [];
    try {
      if (searchSettings.useFavoriteList) {
      } else {
        if (searchSettings.randomImages) {
          if (searchSettings.subBreed == 'All sub breeds') {
            // Chiamata per ottenere le immagini in base alla razza
            final url = await ref
                .read(randomImageProvider(searchSettings.breed).future);
            resultUrls = [url];
          } else {
            // Chiamata per ottenere un'immagine casuale in base alla razza e sottorazza
            final url = await ref.read(randomImageBySubBreedProvider(
                [searchSettings.breed, searchSettings.subBreed]).future);
            resultUrls = [url]; // Mettiamo l'URL in una lista
          }
        } else {
          if (searchSettings.subBreed == 'All sub breeds') {
            // Chiamata per ottenere le immagini in base alla razza
            final urls = await ref
                .read(imagesByBreedProvider(searchSettings.breed).future);
            resultUrls = urls;
          } else {
            // Chiamata per ottenere un'immagine casuale in base alla razza e sottorazza
            final urls = await ref.read(imagesBySubBreedProvider(
                [searchSettings.breed, searchSettings.subBreed]).future);
            resultUrls = urls;
          }
        }
      }
    } catch (e) {
      print('Error fetching images: $e');
      resultUrls = []; // Imposta a vuoto in caso di errore
    }

    setState(() {
      _resultUrls = resultUrls;
      _isSearching = false;
      _showResultPage = true; // Change the flag to show Result Page
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
        SizeCalculator.LargeContainerWidthCalculator(screenWidth);

    return Scaffold(
        appBar: null,
        backgroundColor: AppColors.pageBackground,
        body: _showResultPage
            ? Center(
                child: ResultPage(
                    resultUrls: _resultUrls,
                    onGoHome: () {
                      setState(() {
                        _showResultPage =
                            false; // Change the flag to show HomePage
                      });
                    })) // Pass the callback to go back to HomePage
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
                              isSearching: _isSearching,
                              onSearch: _onSearch,
                            ),
                            //Box to leave empty space on bottom of the page
                            SizedBox(height: 170)
                          ],
                        )),
                  ],
                ),
              ));
  }
}
