import 'package:dogpic/components/result_page/image_card.dart';
import 'package:dogpic/utils/colors.dart';
import 'package:dogpic/utils/size_calculator.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ResultPage extends StatelessWidget {
  final VoidCallback onGoHome;

  ResultPage({required this.onGoHome});

  final List<String> imageUrls = [
    'https://images.dog.ceo/breeds/dachshund/puppy-1006024_640.jpg',
    'https://via.placeholder.com/410',
    'https://via.placeholder.com/420',
    'https://via.placeholder.com/430',
    'https://via.placeholder.com/440',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double pageWidth =
        SizeCalculator.LargeContainerWidthCalculator(screenWidth);

    return Container(
      width: pageWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.blue, size: 40),
                SizedBox(width: 10),
                Text(
                  'Search results:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20), // Margin of 20px
                  child: ImageCard(imageUrl: imageUrls[index]),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Center(
              child: ElevatedButton(
                onPressed: onGoHome,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.search, color: Colors.white, size: 30),
                    SizedBox(width: 10),
                    Text(
                      'New search',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
