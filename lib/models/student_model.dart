class Student {
  final String id;
  final String name;
  bool isPresent;

  Student({
    required this.id,
    required this.name,
    this.isPresent = false,
  });

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
