import 'package:dogpic/providers/breed_notifier.dart';
import 'package:flutter/material.dart';
import 'package:dogpic/components/bottom_bar/custom_bottom_bar.dart';
import 'package:dogpic/pages/favorites_page.dart';
import 'package:dogpic/pages/home_page.dart';
import 'package:dogpic/utils/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageContainer extends ConsumerStatefulWidget {
  @override
  _PageContainerState createState() => _PageContainerState();
}

class _PageContainerState extends ConsumerState<PageContainer> {
  int _selectedIndex = 0;

  // Main Pages
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
  void initState() {
    super.initState();
    final breeds = ref.read(breedNotifierProvider);
    if (breeds.isEmpty) {
      ref.read(breedNotifierProvider.notifier).loadBreeds();
    }
  }

  @override
  Widget build(BuildContext context) {
    final breeds = ref.watch(breedNotifierProvider);

    return Scaffold(
      appBar: null, // Remove appbar
      body: breeds.isEmpty
          ? Center(child: CircularProgressIndicator())
          : AnimatedSwitcher(
              duration: Duration(milliseconds: 250), // Animation duration
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation, // Apply fade transition
                  child: child,
                );
              },
              child: _pages[_selectedIndex], // Display the selected page
            ),
      backgroundColor: AppColors.pageBackground,
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}
