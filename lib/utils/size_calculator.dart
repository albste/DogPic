import 'package:dogpic/utils/globals.dart';

class SizeCalculator {
  static double LargeContainerWidthCalculator(double screenWidth) {
    final double containerWidth = screenWidth > Globals.maxComponentsWidth
        ? Globals.maxComponentsWidth
        : screenWidth -
            (Globals.singleSideComponentsMargin *
                2); // With margin on both sides
    return containerWidth;
  }
}
