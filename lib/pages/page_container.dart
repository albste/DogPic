import 'package:flutter/material.dart';
import 'package:dogpic/components/bottom_bar/custom_bottom_bar.dart';
import 'package:dogpic/pages/favorites_page.dart';
import 'package:dogpic/pages/home_page.dart';
import 'package:dogpic/utils/colors.dart';

class PageContainer extends StatefulWidget {
  @override
  _PageContainerState createState() => _PageContainerState();
}

class _PageContainerState extends State<PageContainer> {
  int _selectedIndex = 0;

  // Pages
  final List<Widget> _pages = [
    HomePage(),
    FavoritesPage(),
  ];

  void _onItemTapped(int index) {
    if (index == _selectedIndex) {
      return; // If the item is already selected, do nothing
    }
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // You can set an AppBar if needed
      body: _pages[_selectedIndex], // Display the selected page
      backgroundColor: AppColors.pageBackground,
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}
