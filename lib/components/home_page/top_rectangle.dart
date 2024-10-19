import 'package:dogpic/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// First block on home page with dark background and logo image white
class TopRectangle extends StatefulWidget {
  final double width;
  final double height;

  const TopRectangle({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  _TopRectangleState createState() => _TopRectangleState();
}

class _TopRectangleState extends State<TopRectangle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: AppColors.primary,
      child: Align(
        alignment: const Alignment(0.0, -0.25),
        child: SvgPicture.asset(
          'lib/assets/svgs/dog_pic_logo_white.svg',
          height: widget.height * 0.32,
        ),
      ),
    );
  }
}
