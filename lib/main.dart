import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/profile_provider.dart';
import 'screens/home_screen.dart';
import 'utils/load_weeks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WeekLoader.loadWeeksFromJSON(); // JSON থেকে DB তে লোড
  runApp(const MotherCareApp());
}

class MotherCareApp extends StatelessWidget {
  const MotherCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileProvider()..loadProfile()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'মা ও আমি',
        theme: ThemeData(primarySwatch: Colors.pink),
        home: const HomeScreen(),
      ),
    );
  }
}
