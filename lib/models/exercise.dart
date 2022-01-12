class Exercise {
  String? id;
  String? name;
  String? imageUrl;
  String? description;
  String? userId;

  Exercise({
    required this.id,
    required this.name,
    this.imageUrl,
    this.description,
    required this.userId
  });

  Exercise.empty();

  Exercise.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id']! as String,
            name: json['name']! as String,
            imageUrl: json['imageUrl']! as String,
            description: json['description']! as String,
            userId: json['userId']! as String
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'userId': userId,
    };
  }
}
