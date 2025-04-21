class TaskModel {
  final String id;
  final String title;
  final String description;
  final String creator;

  TaskModel({required this.id, required this.title, required this.description,required this.creator});

  TaskModel copyWith({String? id, String? title, String? description}) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      creator: creator ?? this.creator
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'creator':creator
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      creator: map['creator'] ?? ''
    );
  }
}
