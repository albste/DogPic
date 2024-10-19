import 'package:dogpic/models/favorites_list_model.dart';
import 'package:dogpic/utils/colors.dart';
import 'package:dogpic/utils/dictionary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritesListItem extends StatefulWidget {
  final FavoritesListModel item;
  final Function(FavoritesListModel) onEdit;
  final Function(int) onDelete;
  const FavoritesListItem(
      {super.key,
      required this.item,
      required this.onEdit,
      required this.onDelete});

  @override
  _FavoritesListItemState createState() => _FavoritesListItemState();
}

class _FavoritesListItemState extends State<FavoritesListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 18, right: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.11),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: ListTile(
          leading: SvgPicture.asset(
            'lib/assets/svgs/dogpic_only_image_dark.svg',
            height: 20,
          ),
          title: Text(widget.item.title,
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: AppColors.primaryForeground,
                ),
              )),
          subtitle: Text(
              '${widget.item.selectedBreedIds.length} ${Dictionary.favorites_page_breeds_selected}',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: AppColors.primaryForeground,
                ),
              )),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: AppColors.primary),
                onPressed: () => widget.onEdit(widget.item),
              ),
              IconButton(
                icon: Icon(Icons.close, color: AppColors.primary),
                onPressed: () => widget.onDelete(widget.item.id),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
