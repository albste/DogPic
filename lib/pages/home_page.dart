import 'package:dogpic/components/home_page/search_card.dart';
import 'package:dogpic/components/home_page/top_rectangle.dart';
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
        body: SingleChildScrollView(
          child: Stack(
            children: [
              // Top Rectangle with logo
              TopRectangle(width: screenWidth, height: topRectangleHeight),
              // Card with search form
              Container(
                  transform: Matrix4.translationValues(
                      (screenWidth - cardWidth) / 2,
                      topRectangleHeight * 0.7,
                      0.0),
                  child: Column(
                    children: [
                      SearchCard(width: cardWidth),
                      //Box to leave empty space on bottom of the page
                      SizedBox(height: 200)
                    ],
                  )),
            ],
          ),
        ));
  }
}

// import 'package:dogpic/utils/colors.dart';
// import 'package:flutter/material.dart';
// import 'result_page.dart'; // Import the ResultPage

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   bool _showResultPage = false; // Flag to control the displayed content

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: null, // Remove the app bar
//       backgroundColor: AppColors.pageBackground,
//       body: Center(
//         child: _showResultPage
//             ? ResultPage(onGoHome: () {
//                 setState(() {
//                   _showResultPage = false; // Change the flag to show HomePage
//                 });
//               }) // Pass the callback to go back to HomePage
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Home Page',
//                     style: TextStyle(fontSize: 24),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         _showResultPage =
//                             true; // Change the flag to show ResultPage
//                       });
//                     },
//                     child: Text('Go to Result Page'),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }
