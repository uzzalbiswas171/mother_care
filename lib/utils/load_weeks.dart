import 'dart:convert';
import 'package:flutter/services.dart';
import '../db/app_database.dart';
import '../models/week_model.dart';

class WeekLoader {
  static Future<void> loadWeeksFromJSON() async {
    final db = AppDatabase.instance;
    final weeks = await db.getAllWeeks();
    if (weeks.isNotEmpty) return; // prevent duplicate insert

    final jsonString = await rootBundle.loadString('lib/data/weeks_data.json');
    final List data = json.decode(jsonString);

    final weekList = data.map((e) => WeekModel.fromMap(e)).toList();
    await db.insertWeeks(weekList);
  }
}
