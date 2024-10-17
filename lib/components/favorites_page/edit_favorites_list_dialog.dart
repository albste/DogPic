import 'package:dogpic/models/dog_breed_model.dart';
import 'package:dogpic/models/dog_subbreed_model.dart';
import 'package:dogpic/utils/size_calculator.dart';
import 'package:flutter/material.dart';

class EditFavoritesListDialog extends StatefulWidget {
  final List<DogBreedModel> breeds;
  final List<DogSubBreedModel> subBreeds;
  final double listHeight;

  EditFavoritesListDialog({
    required this.breeds,
    required this.subBreeds,
    required this.listHeight,
  });

  @override
  _EditFavoritesListDialogState createState() =>
      _EditFavoritesListDialogState();
}

class _EditFavoritesListDialogState extends State<EditFavoritesListDialog> {
  String _selectedTitle = '';
  int? _selectedBreedId;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth =
        SizeCalculator.LargeContainerWidthCalculator(screenWidth) - 40;

    return Container(
      width: cardWidth,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('EDIT LIST'),
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
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  // Optional: Add any action for cancel button
                  Navigator.of(context)
                      .pop(); // Assuming you still want to close it
                },
                child: Text('CANCEL'),
              ),
              SizedBox(width: 8),
              TextButton(
                onPressed: _selectedTitle.isNotEmpty && _selectedBreedId != null
                    ? () {
                        // Save the selected title and breeds/sub-breeds
                        Navigator.of(context).pop(); // Close on save
                      }
                    : null,
                child: Text('UPDATE'),
              ),
            ],
          ),
        ],
      ),
    );
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
