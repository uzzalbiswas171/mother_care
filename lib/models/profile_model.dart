class ProfileModel {
  final int? id;
  final String name;
  final String lmpDate; // YYYY-MM-DD
  final String dueDate; // YYYY-MM-DD

  ProfileModel({
    this.id,
    required this.name,
    required this.lmpDate,
    required this.dueDate,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'lmpDate': lmpDate, 'dueDate': dueDate};
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'],
      name: map['name'],
      lmpDate: map['lmpDate'],
      dueDate: map['dueDate'],
    );
  }
}
