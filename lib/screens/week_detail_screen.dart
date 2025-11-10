import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/week_provider.dart';
import '../models/week_model.dart';

class WeekDetailScreen extends StatelessWidget {
  final int weekNumber;
  const WeekDetailScreen({super.key, required this.weekNumber});

  @override
  Widget build(BuildContext context) {
    final weekProv = Provider.of<WeekProvider>(context);
    WeekModel? week = weekProv.getWeek(weekNumber);

    if (week == null)
      return const Scaffold(body: Center(child: Text('No data')));

    return Scaffold(
      appBar: AppBar(title: Text('সপ্তাহ ${week.weekNumber}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              week.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'শিশুর বিকাশ:',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(week.description),
            const SizedBox(height: 12),
            Text(
              'এই সপ্তাহে করণীয়:',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(week.tips),
          ],
        ),
      ),
    );
  }
}
