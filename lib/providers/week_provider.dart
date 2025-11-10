import 'package:flutter/foundation.dart';
import '../db/app_database.dart';
import '../models/week_model.dart';

class WeekProvider with ChangeNotifier {
  List<WeekModel> weeks = [];

  Future<void> loadWeeks() async {
    weeks = await AppDatabase.instance.getAllWeeks();
    notifyListeners();
  }

  WeekModel? getWeek(int weekNumber) {
    try {
      return weeks.firstWhere((w) => w.weekNumber == weekNumber);
    } catch (_) {
      return null;
    }
  }
}
