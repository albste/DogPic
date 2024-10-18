import 'package:dogpic/utils/settings.dart';

class SizeCalculator {
  static double LargeContainerWidthCalculator(double screenWidth) {
    final double containerWidth = screenWidth > Settings.maxComponentsWidth
        ? Settings.maxComponentsWidth
        : screenWidth -
            (Settings.singleSideComponentsMargin *
                2); // With margin on both sides
    return containerWidth;
  }
}
