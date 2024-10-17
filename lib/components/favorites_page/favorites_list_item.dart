import 'package:dogpic/models/favorites_list_model.dart';
import 'package:flutter/material.dart';

class FavoritesListItem extends StatefulWidget {
  final FavoritesListModel item;
  final Function(int) onEdit;
  final Function(int) onDelete;
  FavoritesListItem(
      {required this.item, required this.onEdit, required this.onDelete});

  @override
  _FavoritesListItemState createState() => _FavoritesListItemState();
}

class _FavoritesListItemState extends State<FavoritesListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.11),
              spreadRadius: 0,
              blurRadius: 5,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(Icons.pets, color: Colors.blue),
          title: Text(widget.item.title,
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle:
              Text('${widget.item.selectedBreedIds.length} breeds selected'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.blue),
                onPressed: () => widget.onEdit(widget.item.id),
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.blue),
                onPressed: () => widget.onDelete(widget.item.id),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
