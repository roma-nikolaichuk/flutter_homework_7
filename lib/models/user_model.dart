class User {
  final int? id;
  final String name;
  final String age;

  const User({required this.name, required this.age, this.id});

  factory User.fromJson(Map<String, dynamic> json) =>
      User(id: json['id'], name: json['name'], age: json['age']);

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'age': age};
}
