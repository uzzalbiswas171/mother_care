import 'package:flutter/foundation.dart';
import '../models/profile_model.dart';
import '../db/app_database.dart';
import '../utils/date_utils.dart';

class ProfileProvider with ChangeNotifier {
  ProfileModel? profile;

  Future<void> loadProfile() async {
    profile = await AppDatabase.instance.getProfile();
    notifyListeners();
  }

  Future<void> saveProfile(String name, DateTime lmp) async {
    final due = calculateDueDateFromLMP(lmp);
    final model = ProfileModel(
      name: name,
      lmpDate: lmp.toIso8601String(),
      dueDate: due.toIso8601String(),
    );
    await AppDatabase.instance.insertProfile(model);
    profile = model;
    notifyListeners();
  }

  int getCurrentWeek() {
    if (profile == null) return 0;
    return calculateWeekFromLMP(DateTime.parse(profile!.lmpDate));
  }
}
