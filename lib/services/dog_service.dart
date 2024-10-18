import 'api_client.dart';
import 'dart:convert';

class DogService {
  final ApiClient apiClient;

  DogService({required this.apiClient});

  Future<Map<String, dynamic>> fetchAllBreeds() async {
    final response = await apiClient.get('https://dog.ceo/api/breeds/list/all');
    final decoded = json.decode(response.body);
    return decoded['message'] as Map<String, dynamic>;
  }

  Future<String> fetchRandomImage(String breedName) async {
    final response = await apiClient
        .get('https://dog.ceo/api/breed/$breedName/images/random');
    final decoded = json.decode(response.body);
    return decoded['message'];
  }

  Future<List<String>> fetchImagesByBreed(String breedName) async {
    final response =
        await apiClient.get('https://dog.ceo/api/breed/$breedName/images');
    final decoded = json.decode(response.body);
    return List<String>.from(decoded['message']);
  }

  Future<String> fetchRandomImageBySubBreed(
      String breedName, String subBreedName) async {
    final response = await apiClient.get(
        'https://dog.ceo/api/breed/$breedName/$subBreedName/images/random');
    final decoded = json.decode(response.body);
    return decoded['message'];
  }

  Future<List<String>> fetchImagesBySubBreed(
      String breedName, String subBreedName) async {
    final response = await apiClient
        .get('https://dog.ceo/api/breed/$breedName/$subBreedName/images');
    final decoded = json.decode(response.body);
    return List<String>.from(decoded['message']);
  }

  Future<List<String>> fetchRandomImagesByBreeds(
      List<String> breedNames) async {
    List<String> images = [];
    for (String breed in breedNames) {
      final response =
          await apiClient.get('https://dog.ceo/api/breed/$breed/images/random');
      final decoded = json.decode(response.body);
      images.add(decoded['message']);
    }
    return images;
  }
}
