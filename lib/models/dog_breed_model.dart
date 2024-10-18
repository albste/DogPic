import 'package:dogpic/models/dog_subbreed_model.dart';

class DogBreedModel {
  final int id;
  final String name;
  final bool hasSubBreeds;
  final List<DogSubBreedModel> subBreeds;

  DogBreedModel({
    required this.id,
    required this.name,
    required this.hasSubBreeds,
    required this.subBreeds,
  });

  factory DogBreedModel.fromJson(String name, List<dynamic> subBreeds, int id) {
    List<DogSubBreedModel> parsedSubBreeds =
        subBreeds.asMap().entries.map((entry) {
      return DogSubBreedModel(
        id: entry.key,
        parentBreedId: id,
        title: entry.value,
      );
    }).toList();

    return DogBreedModel(
      id: id,
      name: name,
      hasSubBreeds: parsedSubBreeds.isNotEmpty,
      subBreeds: parsedSubBreeds,
    );
  }
}
