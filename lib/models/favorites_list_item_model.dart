// Model for a Single List Item
class FavoritesListItemModel {
  final int id;
  final String title;
  final List<int> selectedBreedIds;
  final List<int> selectedSubBreedIds;

  FavoritesListItemModel({
    required this.id,
    required this.title,
    required this.selectedBreedIds,
    required this.selectedSubBreedIds,
  });
}
