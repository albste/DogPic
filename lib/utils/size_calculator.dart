// ignore_for_file: non_constant_identifier_names

import 'package:dogpic/utils/settings.dart';

class SizeCalculator {
  static double largeContainerWidthCalculator(double screenWidth) {
    final double containerWidth = screenWidth > Settings.maxComponentsWidth
        ? Settings.maxComponentsWidth
        : screenWidth -
            (Settings.singleSideComponentsMargin *
                2); // With margin on both sides
    return containerWidth;
  }
}
