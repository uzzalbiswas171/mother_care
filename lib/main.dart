import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/onboarding_screen.dart';
import 'screens/home_screen.dart';
import 'providers/profile_provider.dart';
import 'providers/week_provider.dart';
import 'utils/load_weeks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WeekLoader.loadWeeksFromJSON(); // Load JSON to DB

  runApp(const MotherCareApp());
}

class MotherCareApp extends StatelessWidget {
  const MotherCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileProvider()..loadProfile()),
        ChangeNotifierProvider(create: (_) => WeekProvider()..loadWeeks()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'মা ও আমি',
        theme: ThemeData(primarySwatch: Colors.pink),
        initialRoute: '/onboarding',
        routes: {
          '/onboarding': (_) => const OnboardingScreen(),
          '/home': (_) => const HomeScreen(),
        },
      ),
    );
  }
}
