import 'package:dogpic/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopRectangle extends StatefulWidget {
  final double width;
  final double height;

  const TopRectangle({
    key,
    required this.width,
    required this.height,
  });

  @override
  _TopRectangleState createState() => _TopRectangleState();
}

class _TopRectangleState extends State<TopRectangle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: AppColors.primary,
      child: Align(
        alignment: Alignment(0.0, -0.25),
        child: SvgPicture.asset(
          'lib/assets/svgs/dog_pic_logo_white.svg',
          height: widget.height * 0.32,
        ),
      ),
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
