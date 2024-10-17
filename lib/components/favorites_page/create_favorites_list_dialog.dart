import 'package:dogpic/models/dog_breed_model.dart';
import 'package:dogpic/models/dog_subbreed_model.dart';
import 'package:dogpic/utils/dictionary.dart';
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
    final double cardWidth =
        SizeCalculator.LargeContainerWidthCalculator(screenWidth) - 40;

    return Container(
      width: cardWidth,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(Dictionary.favorites_page_new_dialog_title),
          TextField(
            decoration: InputDecoration(
              labelText: '',
              hintText: Dictionary.favorites_page_enter_title_placeholder,
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
                child: Text(Dictionary.cancel),
              ),
              SizedBox(width: 8),
              TextButton(
                onPressed: _selectedTitle.isNotEmpty && _selectedBreedId != null
                    ? () {
                        // Save the selected title and breeds/sub-breeds
                        Navigator.of(context).pop(); // Close on save
                      }
                    : null,
                child: Text(Dictionary.save),
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
