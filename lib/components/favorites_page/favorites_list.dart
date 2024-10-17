import 'package:dogpic/components/favorites_page/favorites_list_item.dart';
import 'package:dogpic/models/favorites_list_model.dart';
import 'package:flutter/material.dart';

class FavoritesList extends StatefulWidget {
  final FavoritesListModel itemList;

  FavoritesList({required this.itemList});

  @override
  _FavoritesListState createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.itemList.items.length,
      itemBuilder: (context, index) {
        return FavoritesListItem(item: widget.itemList.items[index]);
      },
    );
  }
}
