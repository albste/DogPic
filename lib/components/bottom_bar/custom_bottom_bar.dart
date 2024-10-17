import 'package:dogpic/utils/colors.dart';
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
    final double maxBarWidth = 400;
    final double barWidth = screenWidth > maxBarWidth
        ? maxBarWidth
        : screenWidth - 40; // With 20px margins on each side

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
              FlashyTabBarItem(
                activeColor: AppColors.primary,
                inactiveColor: AppColors.primary.withOpacity(0.6),
                icon: Icon(Icons.home_outlined, size: 23),
                title: Text(
                  Dictionary.home,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              FlashyTabBarItem(
                activeColor: AppColors.primary,
                inactiveColor: AppColors.primary.withOpacity(0.6),
                icon: Icon(Icons.favorite_outline),
                title: Text(
                  Dictionary.favorites,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}