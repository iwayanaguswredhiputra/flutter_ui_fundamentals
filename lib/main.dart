// 2415051007 - I Wayan Agus Wredhi Putra
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'repositories/course_repository.dart';
import 'providers/course_provider.dart';
import 'screens/course_explorer_screen.dart';
import '../services/course_supabase_service.dart';
import 'screens/login_screen.dart';
import 'services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Supabase.initialize(
    url: 'https://xtucenwhlvxwhqfwbefa.supabase.co',
    publishableKey: 'sb_publishable_B9ysjNe3H7Tbyegcq7ZsIg_ROphP9BT', 
  );

  final session = Supabase.instance.client.auth.currentSession;

  final courseSupabaseService = CourseSupabaseService();
  final courseRepository = CourseRepository(courseSupabaseService);
  
  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseProvider(courseRepository)..loadCourses(),
      child: CourseExplorerApp(isLoggedIn: session != null),
    ),
  );
}

class CourseExplorerApp extends StatelessWidget {
  final bool isLoggedIn;
  const CourseExplorerApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromARGB(255, 1, 154, 249);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Explorer v2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white, 
          elevation: 0,
        ),
        useMaterial3: true,
      ),
      home: AuthService.instance.isLoggedIn 
          ? const CourseExplorerScreen() 
          : const LoginScreen(),
    );
  }
}