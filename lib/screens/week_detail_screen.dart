import 'package:flutter/material.dart';
import '../db/app_database.dart';
import '../models/week_model.dart';

class WeekDetailScreen extends StatefulWidget {
  final int weekNumber;
  const WeekDetailScreen({super.key, required this.weekNumber});

  @override
  State<WeekDetailScreen> createState() => _WeekDetailScreenState();
}

class _WeekDetailScreenState extends State<WeekDetailScreen> {
  WeekModel? week;

  @override
  void initState() {
    super.initState();
    loadWeek();
  }

  Future<void> loadWeek() async {
    final allWeeks = await AppDatabase.instance.getAllWeeks();
    setState(() {
      week = allWeeks.firstWhere(
        (e) => e.weekNumber == widget.weekNumber,
        orElse: () => allWeeks.first,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('সপ্তাহ ${widget.weekNumber}')),
      body: week == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  Text(
                    week!.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'শিশুর বিকাশ:',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  Text(week!.description),
                  const SizedBox(height: 12),
                  Text(
                    'এই সপ্তাহে করণীয়:',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  Text(week!.tips),
                ],
              ),
            ),
    );
  }
}
