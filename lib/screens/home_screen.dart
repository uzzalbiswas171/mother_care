import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import '../screens/week_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProv = Provider.of<ProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('মা ও আমি')),
      body: profileProv.profile == null
          ? const Center(child: Text('প্রথমে আপনার তথ্য দিন'))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'স্বাগতম ${profileProv.profile!.name}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('আপনার বর্তমান সপ্তাহ: ${profileProv.getCurrentWeek()}'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WeekDetailScreen(
                            weekNumber: profileProv.getCurrentWeek(),
                          ),
                        ),
                      );
                    },
                    child: const Text('এই সপ্তাহের তথ্য দেখুন'),
                  ),
                ],
              ),
            ),
    );
  }
}
