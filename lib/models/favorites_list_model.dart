// Model for a Favorites List Item
class FavoritesListModel {
  final int id;
  final String title;
  final List<int> selectedBreedIds;

  FavoritesListModel({
    required this.id,
    required this.title,
    required this.selectedBreedIds,
  });
}
