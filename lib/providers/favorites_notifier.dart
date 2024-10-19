import 'package:dogpic/models/favorites_list_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Used to manage favorites lists
class FavoritesNotifier extends StateNotifier<List<FavoritesListModel>> {
  FavoritesNotifier() : super([]);

  int currentId = 0; // Unique ID var

  List<FavoritesListModel> get favoritesList =>
      state; // Read all favoritesLists

  // Add new item to favorites lists
  void addFavorite(String title, List<int> selectedBreedIds) {
    currentId++;
    final newFavorite = FavoritesListModel(
      id: currentId,
      title: title,
      selectedBreedIds: selectedBreedIds,
    );
    state = [...state, newFavorite];
  }

  // Update a favorites list item
  void updateFavorite(int id, String newTitle, List<int> newSelectedBreedIds) {
    state = state.map((favorite) {
      if (favorite.id == id) {
        return FavoritesListModel(
          id: favorite.id,
          title: newTitle,
          selectedBreedIds: newSelectedBreedIds,
        );
      }
      return favorite;
    }).toList();
  }

  // Empty list
  void removeAllFavorites() {
    state = [];
  }

  // Remove item by ID
  void removeFavorite(int id) {
    state = state.where((favorite) => favorite.id != id).toList();
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<FavoritesListModel>>(
  (ref) => FavoritesNotifier(),
);
