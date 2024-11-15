import 'package:dogpic/utils/colors.dart';
import 'package:dogpic/utils/size_calculator.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dogpic/utils/dictionary.dart';

// The bottom bar used in all app's views
class CustomBottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Retrieve the screen width
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate the maximum available width for the bottom bar
    final double barWidth =
        SizeCalculator.largeContainerWidthCalculator(screenWidth);

    // Calculate dynamic margins based on the width
    final double sideMargin = (screenWidth - barWidth) / 2;

    return Container(
      margin: EdgeInsets.only(
        left: sideMargin,
        bottom: 20,
        right: sideMargin,
      ),
      decoration: BoxDecoration(
        // Additional shadow starting from the outer container
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Slightly lighter shadow
            blurRadius: 20, // Spread of the shadow
            offset: const Offset(0, 2), // Offset to move the shadow down
          ),
        ],
      ),
      child: SizedBox(
        width: barWidth, // Calculated width
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40), // Rounded corners
          child: FlashyTabBar(
            selectedIndex: selectedIndex,
            backgroundColor: Colors.white,
            showElevation: false,
            onItemSelected: onItemSelected, // Selection event
            items: [
              buildTabItem(
                icon: Icons.home_outlined,
                title: Dictionary.home,
                index: 0,
              ),
              buildTabItem(
                icon: Icons.favorite_outline,
                title: Dictionary.favorites,
                index: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Single item constructor
  FlashyTabBarItem buildTabItem(
      {required IconData icon, required String title, required int index}) {
    return FlashyTabBarItem(
      activeColor: AppColors.primary,
      inactiveColor: AppColors.primary.withOpacity(0.6),
      icon: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Icon(icon, size: 26),
      ),
      title: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Text(
          title,
          textAlign: TextAlign.left,
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
