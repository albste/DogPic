import 'package:dogpic/components/home_page/search_card.dart';
import 'package:dogpic/components/home_page/top_rectangle.dart';
import 'package:dogpic/models/search_settings_model.dart';
import 'package:dogpic/utils/colors.dart';
import 'package:dogpic/utils/size_calculator.dart';
import 'package:flutter/material.dart';
import 'result_page.dart'; // Import the ResultPage

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showResultPage = false; // Flag to control the displayed content

  void _onSearch(SearchSettingsModel searchSettings) {
    setState(() {
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
            ? Center(child: ResultPage(onGoHome: () {
                setState(() {
                  _showResultPage = false; // Change the flag to show HomePage
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
