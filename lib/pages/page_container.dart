import 'package:dogpic/providers/breed_notifier.dart';
import 'package:flutter/material.dart';
import 'package:dogpic/components/bottom_bar/custom_bottom_bar.dart';
import 'package:dogpic/pages/favorites_page.dart';
import 'package:dogpic/pages/home_page.dart';
import 'package:dogpic/utils/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//All content of a page will displayed here (excluding the appbar)
class PageContainer extends ConsumerStatefulWidget {
  const PageContainer({super.key});

  @override
  _PageContainerState createState() => _PageContainerState();
}

class _PageContainerState extends ConsumerState<PageContainer> {
  int selectedIndex = 0;

  // Main Pages
  final List<Widget> pages = [
    HomePage(),
    FavoritesPage(),
  ];

  void onItemTapped(int index) {
    if (index == selectedIndex) {
      return; // If the item is already selected, do nothing
    }
    setState(() {
      selectedIndex = index; // Update the selected index
    });
  }

  // Load first time the breeds and sub breeds lists
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
      // Page
      body: breeds.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : AnimatedSwitcher(
              duration: const Duration(milliseconds: 250), // Animation duration
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation, // Apply fade transition
                  child: child,
                );
              },
              child: pages[selectedIndex], // Display the selected page
            ),
      backgroundColor: AppColors.pageBackground,
      // Bottom bar
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: selectedIndex,
        onItemSelected: onItemTapped,
      ),
    );
  }
}
