class ClassModel {
  final String id;
  final String name;
  final String teacherId;
  final List<String> studentIds;
  final String schedule;

  ClassModel({
    required this.id,
    required this.name,
    required this.teacherId,
    required this.studentIds,
    required this.schedule,
  });

  factory ClassModel.fromMap(Map<String, dynamic> map) {
    return ClassModel(
      id: map['id'],
      name: map['name'],
      teacherId: map['teacherId'],
      studentIds: List<String>.from(map['studentIds']),
      schedule: map['schedule'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'teacherId': teacherId,
      'studentIds': studentIds,
      'schedule': schedule,
    };
  }
}