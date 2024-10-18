import 'package:dogpic/models/dog_breed_model.dart';
import 'package:dogpic/models/dog_subbreed_model.dart';
import 'package:dogpic/models/favorites_list_model.dart';
import 'package:dogpic/providers/favorites_notifier.dart';
import 'package:dogpic/repositories/dog_repository.dart';
import 'package:dogpic/services/api_client.dart';
import 'package:dogpic/services/dog_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

final dogServiceProvider = Provider<DogService>(
    (ref) => DogService(apiClient: ref.watch(apiClientProvider)));

final dogRepositoryProvider = Provider<DogRepository>(
    (ref) => DogRepository(dogService: ref.watch(dogServiceProvider)));

final dogBreedsProvider = FutureProvider<List<DogBreedModel>>(
    (ref) async => ref.watch(dogRepositoryProvider).fetchAllBreeds());

final dogSubBreedsProvider =
    FutureProvider.family<List<DogSubBreedModel>, DogBreedModel>(
        (ref, breed) async {
  return ref.watch(dogRepositoryProvider).fetchSubBreedsForBreed(breed);
});

final randomImageProvider =
    FutureProvider.family<String, String>((ref, breedName) async {
  return ref.watch(dogRepositoryProvider).fetchRandomImage(breedName);
});

final imagesByBreedProvider =
    FutureProvider.family<List<String>, String>((ref, breedName) async {
  return ref.watch(dogRepositoryProvider).fetchImagesByBreed(breedName);
});

final randomImageBySubBreedProvider =
    FutureProvider.family<String, List<String>>((ref, params) async {
  final breedName = params[0];
  final subBreedName = params[1];
  return ref
      .watch(dogRepositoryProvider)
      .fetchRandomImageBySubBreed(breedName, subBreedName);
});

final imagesBySubBreedProvider =
    FutureProvider.family<List<String>, List<String>>((ref, params) async {
  final breedName = params[0];
  final subBreedName = params[1];
  return ref
      .watch(dogRepositoryProvider)
      .fetchImagesBySubBreed(breedName, subBreedName);
});

final randomImagesByBreedsProvider =
    FutureProvider.family<List<String>, List<String>>((ref, breedNames) async {
  return ref.watch(dogRepositoryProvider).fetchRandomImagesByBreeds(breedNames);
});
