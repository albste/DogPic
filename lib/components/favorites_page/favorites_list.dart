import 'package:dogpic/components/favorites_page/favorites_list_item.dart';
import 'package:dogpic/models/favorites_list_model.dart';
import 'package:flutter/material.dart';

class FavoritesList extends StatefulWidget {
  final List<FavoritesListModel> itemList;
  final ScrollController scrollController;
  final Function(FavoritesListModel) onEdit;
  final Function(int) onDelete;

  const FavoritesList({
    super.key,
    required this.itemList,
    required this.scrollController,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  _FavoritesListState createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: widget.scrollController,
      thumbVisibility: true,
      child: ListView.builder(
        controller: widget
            .scrollController, // Associa il controller anche al ListView.builder
        itemCount: widget.itemList.length,
        itemBuilder: (context, index) {
          if (index == widget.itemList.length - 1) {
            return Column(
              children: [
                FavoritesListItem(
                  item: widget.itemList[index],
                  onEdit: widget.onEdit,
                  onDelete: widget.onDelete,
                ),
                const SizedBox(height: 30),
              ],
            );
          } else {
            return FavoritesListItem(
              item: widget.itemList[index],
              onEdit: widget.onEdit,
              onDelete: widget.onDelete,
            );
          }
        },
      ),
    );
  }
}
