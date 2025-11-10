import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final TextEditingController _nameController = TextEditingController();
  DateTime? _lmpDate;

  @override
  Widget build(BuildContext context) {
    final profileProv = Provider.of<ProfileProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('প্রথমবারের তথ্য')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'আপনার নাম'),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  _lmpDate == null
                      ? 'শেষ মাসিকের তারিখ বাছাই করুন'
                      : 'LMP: ${_lmpDate!.toLocal()}'.split(' ')[0],
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now().subtract(
                        const Duration(days: 365),
                      ),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setState(() => _lmpDate = picked);
                    }
                  },
                  child: const Text('Select Date'),
                ),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _lmpDate == null || _nameController.text.isEmpty
                  ? null
                  : () async {
                      await profileProv.saveProfile(
                        _nameController.text,
                        _lmpDate!,
                      );
                      Navigator.pushReplacementNamed(context, '/home');
                    },
              child: const Text('Save & Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
