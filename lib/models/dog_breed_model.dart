// Model for Dog Breeds
class DogBreedModel {
  final int id;
  final String name;
  final bool hasSubBreeds;
  final int? subBreedId;

  DogBreedModel({
    required this.id,
    required this.name,
    required this.hasSubBreeds,
    this.subBreedId,
  });
}
