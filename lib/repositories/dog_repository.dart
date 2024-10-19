import 'package:dogpic/models/dog_breed_model.dart';
import 'package:dogpic/models/dog_subbreed_model.dart';
import 'package:dogpic/services/dog_service.dart';

class DogRepository {
  final DogService dogService;

  DogRepository({required this.dogService});

  // Used to get all breeds and relatives sub breeds
  Future<List<DogBreedModel>> fetchAllBreeds() async {
    final data = await dogService.fetchAllBreeds();
    List<DogBreedModel> breeds = [];
    int id = 0;
    data.forEach((key, value) {
      breeds.add(DogBreedModel.fromJson(key, value, id++));
    });
    return breeds;
  }

  // Used to get sub breeds of a breed
  Future<List<DogSubBreedModel>> fetchSubBreedsForBreed(
      DogBreedModel breed) async {
    return breed.subBreeds;
  }

  // Used to get all images of a breed
  Future<List<String>> fetchImagesByBreed(String breedName) async {
    return await dogService.fetchImagesByBreed(breedName);
  }

  // Used to get all images by breed and relative sub breed
  Future<List<String>> fetchImagesBySubBreed(
      String breedName, String subBreedName) async {
    return await dogService.fetchImagesBySubBreed(breedName, subBreedName);
  }

  // Used to get a random image by a breed
  Future<String> fetchRandomImage(String breedName) async {
    return await dogService.fetchRandomImage(breedName);
  }

  // Used to get random image by a breed and relative sub breed
  Future<String> fetchRandomImageBySubBreed(
      String breedName, String subBreedName) async {
    return await dogService.fetchRandomImageBySubBreed(breedName, subBreedName);
  }

  // Used to get random images by breeds list
  Future<List<String>> fetchRandomImagesByBreeds(
      List<String> breedNames) async {
    return await dogService.fetchRandomImagesByBreeds(breedNames);
  }
}
