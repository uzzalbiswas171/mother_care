int calculateWeekFromLMP(DateTime lmp) {
  final now = DateTime.now();
  final diffDays = now.difference(lmp).inDays;
  final week = (diffDays / 7).floor() + 1;
  return week < 1 ? 0 : week;
}

DateTime calculateDueDateFromLMP(DateTime lmp) {
  return DateTime(lmp.year, lmp.month + 9, lmp.day + 7);
}
