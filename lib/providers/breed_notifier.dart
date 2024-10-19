import 'package:dogpic/models/dog_breed_model.dart';
import 'package:dogpic/providers/dog_providers.dart';
import 'package:dogpic/repositories/dog_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Used as var containing all breeds and relative sub breeds
class BreedNotifier extends StateNotifier<List<DogBreedModel>> {
  final DogRepository dogRepository;

  BreedNotifier({required this.dogRepository}) : super([]);

  Future<void> loadBreeds() async {
    try {
      final breeds = await dogRepository.fetchAllBreeds();
      state = breeds;
    } catch (e) {
      state = [];
    }
  }
}

final breedNotifierProvider =
    StateNotifierProvider<BreedNotifier, List<DogBreedModel>>((ref) {
  final dogRepository = ref.watch(dogRepositoryProvider);
  return BreedNotifier(dogRepository: dogRepository);
});
