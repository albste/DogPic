import 'package:dogpic/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchCard extends StatefulWidget {
  final double width;

  const SearchCard({
    key,
    required this.width,
  });

  @override
  _SearchCardState createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  String selectedBreed = 'African';
  String selectedSubBreed = 'All sub breeds';
  bool useFavoriteList = false;
  bool randomImages = true;
  String favoriteList = 'List 1';
  bool switchAnimationEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.pets, color: Colors.blue, size: 40),
                SizedBox(width: 10),
                Text(
                  'Search dogs pictures',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // AnimatedSwitcher for dropdowns
            AnimatedSwitcher(
              duration:
                  Duration(milliseconds: switchAnimationEnabled ? 300 : 0),
              child: useFavoriteList
                  ? Column(
                      key: ValueKey('favoriteListDropdown'),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Favorite list to use',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                        SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: favoriteList,
                          onChanged: (newValue) {
                            setState(() {
                              favoriteList = newValue!;
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          items: <String>['List 1', 'List 2', 'List 3']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    )
                  : Column(
                      key: ValueKey('breedSubBreedDropdowns'),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Breed Dropdown
                        Text(
                          'Breed',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                        SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: selectedBreed,
                          onChanged: (newValue) {
                            setState(() {
                              selectedBreed = newValue!;
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          items: <String>[
                            'African',
                            'Bulldog',
                            'Labrador',
                            'Poodle'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 20),
                        // Sub Breed Dropdown
                        Text(
                          'Sub Breed',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                        SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: selectedSubBreed,
                          onChanged: (newValue) {
                            setState(() {
                              selectedSubBreed = newValue!;
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          items: <String>[
                            'All sub breeds',
                            'Sub 1',
                            'Sub 2',
                            'Sub 3'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
            ),
            SizedBox(height: 20),
            // Use Favorite List Switch
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Use a favorite list',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue[900],
                  ),
                ),
                Switch(
                  value: useFavoriteList,
                  onChanged: (newValue) {
                    setState(() {
                      useFavoriteList = newValue;
                    });
                  },
                  activeColor: Colors.blue[900],
                ),
              ],
            ),
            // Random Images Switch
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Random Images',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue[900],
                  ),
                ),
                Switch(
                  value: true,
                  onChanged: (newValue) {
                    // handle logic for random images switch
                  },
                  activeColor: Colors.blue[900],
                ),
              ],
            ),
            SizedBox(height: 40),
            // Search Button
            Align(
              alignment: Alignment.centerRight,
              child: FloatingActionButton(
                onPressed: () {
                  // Logica di ricerca
                },
                backgroundColor: Colors.blue[900],
                child: Icon(Icons.search, size: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// child: Center(
//         child: Column(children: [
//       Container(
//         height: 500,
//         margin: EdgeInsets.all(20),
//         color: Colors.grey[200],
//         child: Center(
//           child: Text('Example Content'),
//         ),
//       ),
//     ])),
