// 2415051007 - I Wayan Agus Wredhi Putra
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'repositories/course_repository.dart';
import 'services/course_service.dart';
import 'providers/course_provider.dart';
import 'screens/course_explorer_screen.dart';
void main() {
  final courseService = CourseService();
  final courseRepository = CourseRepository(courseService);
  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseProvider(courseRepository)..loadCourses(),
      child: const CourseExplorerApp(),
    ),
  );
}
class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});
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
      home: const CourseExplorerScreen(),
    );
  }
}