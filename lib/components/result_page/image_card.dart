// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:dogpic/utils/colors.dart';
import 'package:dogpic/utils/dictionary.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:html' as html;

// Item of images result list
class ImageCard extends StatefulWidget {
  final String imageUrl; // Url of image

  const ImageCard({super.key, required this.imageUrl});

  @override
  _ImageCardState createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Open image externally
    Future<void> openImage(String imageUrl) async {
      try {
        final anchor = html.AnchorElement(href: imageUrl)
          ..setAttribute('download', 'downloaded_image.jpg')
          ..setAttribute('target', '_blank')
          ..click();
        anchor.remove();
      } catch (e) {
        // Error opening image
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(Dictionary.open_image_snackbar_error_message)),
        );
      }
    }

    return Stack(
      children: [
        // Skeleton during loading
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
              width: screenWidth,
              height: 250,
              child: _isLoading
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.grey.shade400,
                      child: Container(
                        color: Colors.grey,
                      ),
                    )
                  : Container()),
        ),
        // Image
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            widget.imageUrl,
            width: screenWidth,
            height: 250,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              // Loading image logic
              if (loadingProgress == null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                });
                return child; // Show image
              } else {
                // Image is still loading
                return SizedBox(
                  width: screenWidth,
                  height: 250,
                  child: const Center(
                    child: CircularProgressIndicator(), // Loading indicator
                  ),
                );
              }
            },
            errorBuilder: (context, error, stackTrace) {
              // Error loading image
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    _isLoading = false;
                  });
                }
              });
              return Container(
                width: screenWidth,
                height: 250,
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 50,
                  ),
                ),
              );
            },
          ),
        ),
        // Open image button
        Positioned(
          bottom: 10,
          right: 0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(8),
              shape: const CircleBorder(),
              backgroundColor: _isLoading ? Colors.grey : AppColors.primary,
            ),
            onPressed: _isLoading
                ? null
                : () {
                    openImage(widget.imageUrl);
                  },
            child: const Icon(Icons.open_in_new, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
