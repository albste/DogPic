import 'package:dogpic/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchCard extends StatefulWidget {
  final double width;

  const SearchCard({
    key,
    required this.width,
  });

  @override
  _SearchCardState createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
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
      child: Center(
          child: Column(children: [
        Container(
          height: 500,
          margin: EdgeInsets.all(20),
          color: Colors.grey[200],
          child: Center(
            child: Text('Example Content'),
          ),
        ),
      ])),
    );
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
