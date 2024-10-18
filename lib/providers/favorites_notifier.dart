import 'package:dogpic/models/favorites_list_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesNotifier extends StateNotifier<List<FavoritesListModel>> {
  FavoritesNotifier() : super([]);

  int _currentId = 0; // ID univoco crescente

  List<FavoritesListModel> get favoritesList =>
      state; // Read all favoritesLists

  // Aggiungi un nuovo elemento alla lista
  void addFavorite(String title, List<int> selectedBreedIds) {
    _currentId++;
    final newFavorite = FavoritesListModel(
      id: _currentId,
      title: title,
      selectedBreedIds: selectedBreedIds,
    );
    state = [...state, newFavorite];
  }

  void updateFavorite(int id, String newTitle, List<int> newSelectedBreedIds) {
    state = state.map((favorite) {
      if (favorite.id == id) {
        // Crea una nuova istanza di FavoritesListModel con i dati aggiornati
        return FavoritesListModel(
          id: favorite.id,
          title: newTitle,
          selectedBreedIds: newSelectedBreedIds,
        );
      }
      return favorite;
    }).toList();
  }

  // Rimuovi tutti gli elementi dalla lista
  void removeAllFavorites() {
    state = [];
  }

  // Rimuovi un singolo elemento dalla lista usando l'ID
  void removeFavorite(int id) {
    state = state.where((favorite) => favorite.id != id).toList();
  }
}

// Definizione del StateNotifierProvider
final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<FavoritesListModel>>(
  (ref) => FavoritesNotifier(),
);
