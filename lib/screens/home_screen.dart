import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import '../providers/week_provider.dart';
import 'week_detail_screen.dart';
import 'onboarding_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProv = Provider.of<ProfileProvider>(context);
    final weekProv = Provider.of<WeekProvider>(context);

    final currentWeek = profileProv.getCurrentWeek();
    final week = weekProv.getWeek(currentWeek);

    return Scaffold(
      appBar: AppBar(title: const Text('মা ও আমি')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profileProv.profile != null
                    ? 'স্বাগতম ${profileProv.profile!.name} ${profileProv.profile!.dueDate}'
                    : 'স্বাগতম মা ও আমি',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text('বর্তমান সপ্তাহ: $currentWeek'),
              const SizedBox(height: 20),
              if (week != null)
                Card(
                  child: ListTile(
                    title: Text(week.title),
                    subtitle: Text(week.description),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              WeekDetailScreen(weekNumber: currentWeek),
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: weekProv.weeks.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final week = weekProv.weeks[index];
                  return Card(
                child: ListTile(
                  title: Text(week.title),
                  subtitle: Text(week.description),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            WeekDetailScreen(weekNumber: currentWeek),
                      ),
                    );
                  },
                ),
              );
            },)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        tooltip: 'আপনার তথ্য সম্পাদনা করুন',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const OnboardingScreen()),
          );
        },
      ),
    );
  }
}
