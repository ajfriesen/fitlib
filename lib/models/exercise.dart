class Exercise {
  String? id;
  String? name;
  String? imageName;
  String? imageUrl;
  String? description;

  Exercise(
      {required this.id,
      required this.name,
      this.imageName,
      this.imageUrl,
      this.description});

  Exercise.empty();
}