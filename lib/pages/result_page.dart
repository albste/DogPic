import 'package:dogpic/components/result_page/image_card.dart';
import 'package:dogpic/utils/colors.dart';
import 'package:dogpic/utils/dictionary.dart';
import 'package:dogpic/utils/size_calculator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Here will displayed images from search result
class ResultPage extends StatelessWidget {
  final List<String> resultUrls; // The images urls
  final VoidCallback onGoHome; // On new search button clicked

  const ResultPage(
      {super.key, required this.resultUrls, required this.onGoHome});

  @override
  Widget build(BuildContext context) {
    // Get widget max width
    final screenWidth = MediaQuery.of(context).size.width;
    final double pageWidth =
        SizeCalculator.largeContainerWidthCalculator(screenWidth);

    return SizedBox(
      width: pageWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon and page title
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Icon(Icons.search, color: AppColors.primary, size: 30),
                const SizedBox(width: 10),
                Text(Dictionary.result_page_title,
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
          const SizedBox(height: 20),
          // List of results
          Expanded(
            child: ListView.builder(
              itemCount: resultUrls.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20), // Margin of 20px
                  child: ImageCard(imageUrl: resultUrls[index]),
                );
              },
            ),
          ),
          // New search button
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Center(
              child: ElevatedButton(
                onPressed: onGoHome,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.search, color: Colors.white, size: 23),
                    const SizedBox(width: 10),
                    Text(Dictionary.result_page_new_search_button,
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: AppColors.secondaryForeground,
                          ),
                        )),
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
