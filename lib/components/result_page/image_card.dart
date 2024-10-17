import 'package:dogpic/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:html' as html;

class ImageCard extends StatefulWidget {
  final String imageUrl;

  const ImageCard({required this.imageUrl});

  @override
  _ImageCardState createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    Future<void> _openImage(String imageUrl) async {
      try {
        final anchor = html.AnchorElement(href: imageUrl)
          ..setAttribute('download', 'downloaded_image.jpg')
          ..setAttribute('target', '_blank')
          ..click();
        anchor.remove();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error opening image\'s url.')),
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
        // Actual image
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            widget.imageUrl,
            width: screenWidth,
            height: 250, // Altezza fissa
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                // Se loadingProgress è null, significa che l'immagine è stata caricata.
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                });
                return child; // Mostra l'immagine caricata
              } else {
                // L'immagine è ancora in caricamento
                return SizedBox(
                  width: screenWidth,
                  height: 250,
                  child: Center(
                    child:
                        CircularProgressIndicator(), // Mostra un indicatore di caricamento
                  ),
                );
              }
            },
            errorBuilder: (context, error, stackTrace) {
              // Gestione dell'errore
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
                color: Colors
                    .grey[300], // Sfondo per il fallimento del caricamento
                child: Center(
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
        // Download button
        Positioned(
          bottom: 10,
          right: 0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(8),
              shape: CircleBorder(),
              backgroundColor: _isLoading ? Colors.grey : AppColors.primary,
            ),
            onPressed: _isLoading
                ? null
                : () {
                    _openImage(widget.imageUrl);
                  },
            child: Icon(Icons.open_in_new, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
