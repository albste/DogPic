import 'package:dogpic/models/favorites_list_model.dart';

class SearchSettingsModel {
  final String breed;
  final String subBreed;
  final bool useFavoriteList;
  final FavoritesListModel? favoriteListToUse;
  final bool randomImages;

  SearchSettingsModel({
    required this.breed,
    required this.subBreed,
    this.useFavoriteList = false,
    this.favoriteListToUse,
    this.randomImages = false,
  });
}
