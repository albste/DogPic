import 'package:dogpic/components/favorites_page/favorites_list_item.dart';
import 'package:dogpic/models/favorites_list_model.dart';
import 'package:flutter/material.dart';

// Favorites list used in favorites page
class FavoritesList extends StatefulWidget {
  final List<FavoritesListModel> itemList; // All favorites lists
  final ScrollController scrollController;
  final Function(FavoritesListModel) onEdit; // On single item edit pressed
  final Function(int) onDelete; // On single item delete pressed

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
    // All content is inside a scrollbar
    return Scrollbar(
      controller: widget.scrollController,
      thumbVisibility: true,
      child: ListView.builder(
        controller: widget.scrollController,
        itemCount: widget.itemList.length,
        // Single favorite list item
        itemBuilder: (context, index) {
          // If it's the last item, add some space below
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
