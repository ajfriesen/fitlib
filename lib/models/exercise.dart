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

  Exercise.fromJson(Map<String, Object?> json)
      : this(
            id: json['id']! as String,
            name: json['name']! as String,
            imageName: json['imageName']! as String,
            imageUrl: json['imageUrl']! as String,
            description: json['description']! as String);

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'imageName': imageName,
      'imageUrl': imageUrl,
      'description': description,
    };
  }
}
