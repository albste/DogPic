import 'package:dogpic/models/dog_breed_model.dart';
import 'package:dogpic/models/dog_subbreed_model.dart';
import 'package:dogpic/services/dog_service.dart';

class DogRepository {
  final DogService dogService;

  DogRepository({required this.dogService});

  Future<List<DogBreedModel>> fetchAllBreeds() async {
    final data = await dogService.fetchAllBreeds();
    List<DogBreedModel> breeds = [];
    int id = 0;
    data.forEach((key, value) {
      breeds.add(DogBreedModel.fromJson(key, value, id++));
    });
    return breeds;
  }

  Future<List<DogSubBreedModel>> fetchSubBreedsForBreed(
      DogBreedModel breed) async {
    return breed.subBreeds;
  }

  Future<List<String>> fetchImagesByBreed(String breedName) async {
    return await dogService.fetchImagesByBreed(breedName);
  }

  Future<List<String>> fetchImagesBySubBreed(
      String breedName, String subBreedName) async {
    return await dogService.fetchImagesBySubBreed(breedName, subBreedName);
  }

  Future<String> fetchRandomImage(String breedName) async {
    return await dogService.fetchRandomImage(breedName);
  }

  Future<String> fetchRandomImageBySubBreed(
      String breedName, String subBreedName) async {
    return await dogService.fetchRandomImageBySubBreed(breedName, subBreedName);
  }

  Future<List<String>> fetchRandomImagesByBreeds(
      List<String> breedNames) async {
    return await dogService.fetchRandomImagesByBreeds(breedNames);
  }
}
