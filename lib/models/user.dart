class User {
  String? id;
  String? email;
  DateTime? created;
  DateTime? updated;

  User.empty();

  User({required this.id, this.email, this.created, this.updated});

  User.fromJson(Map<String, dynamic> json)
      : this(
      id: json['id']! as String,
      email: json['email']! as String,
      created: json['created']! as DateTime,
      updated: json['updated']! as DateTime);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'created': created,
      'updated': updated,
    };
  }

}
