class DogSubBreedModel {
  final int id;
  final int parentBreedId;
  final String title;

  DogSubBreedModel({
    required this.id,
    required this.parentBreedId,
    required this.title,
  });

  factory DogSubBreedModel.fromJson(
      Map<String, dynamic> json, int id, int parentBreedId) {
    return DogSubBreedModel(
      id: id,
      parentBreedId: parentBreedId,
      title: json['title'],
    );
  }
}
