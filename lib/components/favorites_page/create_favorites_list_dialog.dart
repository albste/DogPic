import 'package:dogpic/models/dog_breed_model.dart';
import 'package:dogpic/models/dog_subbreed_model.dart';
import 'package:dogpic/utils/size_calculator.dart';
import 'package:flutter/material.dart';

class CreateFavoritesListDialog extends StatefulWidget {
  final List<DogBreedModel> breeds;
  final List<DogSubBreedModel> subBreeds;
  final double listHeight;

  CreateFavoritesListDialog({
    required this.breeds,
    required this.subBreeds,
    required this.listHeight,
  });

  @override
  _CreateFavoritesListDialogState createState() =>
      _CreateFavoritesListDialogState();
}

class _CreateFavoritesListDialogState extends State<CreateFavoritesListDialog> {
  String _selectedTitle = '';
  int? _selectedBreedId;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Set the max width for the card
    final double cardWidth =
        SizeCalculator.LargeContainerWidthCalculator(screenWidth);

    return Container(
        width: cardWidth,
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.11),
              spreadRadius: 5,
              blurRadius: 20,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: AlertDialog(
              title: Text('CREATE NEW LIST'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Title',
                      hintText: 'Enter a title..',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _selectedTitle = value;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: widget.listHeight,
                    child: Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      child: ListView(
                        controller: _scrollController,
                        children: _buildBreedList(),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('CANCEL'),
                ),
                TextButton(
                  onPressed:
                      _selectedTitle.isNotEmpty && _selectedBreedId != null
                          ? () {
                              // Save the selected title and breeds/sub-breeds
                              Navigator.of(context).pop();
                            }
                          : null,
                  child: Text('SAVE'),
                ),
              ],
            )));
  }

  List<Widget> _buildBreedList() {
    List<Widget> breedWidgets = [];

    for (var breed in widget.breeds) {
      breedWidgets.add(
        RadioListTile<int>(
          title: Text(breed.name),
          value: breed.id,
          groupValue: _selectedBreedId,
          onChanged: (value) {
            setState(() {
              _selectedBreedId = value;
              // Select all sub-breeds if the parent breed is selected
            });
          },
        ),
      );

      if (breed.hasSubBreeds) {
        for (var subBreed
            in widget.subBreeds.where((sub) => sub.parentBreedId == breed.id)) {
          breedWidgets.add(
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: RadioListTile<int>(
                title: Text(subBreed.title),
                value: subBreed.id,
                groupValue: _selectedBreedId,
                onChanged: (value) {
                  setState(() {
                    _selectedBreedId = value;
                  });
                },
              ),
            ),
          );
        }
      }
    }
    return breedWidgets;
  }
}
