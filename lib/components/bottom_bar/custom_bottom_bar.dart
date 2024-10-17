import 'package:dogpic/utils/colors.dart';
import 'package:dogpic/utils/size_calculator.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dogpic/utils/dictionary.dart';

class CustomBottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retrieve the screen width
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate the maximum available width for the bottom bar
    final double barWidth =
        SizeCalculator.LargeContainerWidthCalculator(screenWidth);

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
            offset: Offset(0, 2), // Offset to move the shadow down
          ),
        ],
      ),
      child: Container(
        width: barWidth, // Calculated width
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40), // Rounded corners
          child: FlashyTabBar(
            selectedIndex: selectedIndex,
            backgroundColor: Colors.white,
            showElevation: false,
            onItemSelected: onItemSelected, // Selection event
            items: [
              _buildTabItem(
                icon: Icons.home_outlined,
                title: Dictionary.home,
                index: 0,
              ),
              _buildTabItem(
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

  FlashyTabBarItem _buildTabItem(
      {required IconData icon, required String title, required int index}) {
    return FlashyTabBarItem(
      activeColor: AppColors.primary,
      inactiveColor: AppColors.primary.withOpacity(0.6),
      icon: MouseRegion(
        cursor: SystemMouseCursors.click, // Change cursor to hand
        child: Icon(icon, size: 26),
      ),
      title: MouseRegion(
        cursor: SystemMouseCursors.click, // Change cursor to hand
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
