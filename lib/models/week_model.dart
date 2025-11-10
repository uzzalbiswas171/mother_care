class WeekModel {
  final int weekNumber;
  final String title;
  final String description;
  final String tips;

  WeekModel({
    required this.weekNumber,
    required this.title,
    required this.description,
    required this.tips,
  });

  Map<String, dynamic> toMap() => {
    'weekNumber': weekNumber,
    'title': title,
    'description': description,
    'tips': tips,
  };

  factory WeekModel.fromMap(Map<String, dynamic> map) => WeekModel(
    weekNumber: map['weekNumber'],
    title: map['title'],
    description: map['description'],
    tips: map['tips'],
  );
}
