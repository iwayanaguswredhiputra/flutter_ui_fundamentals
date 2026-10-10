// 2415051007 - I Wayan Agus Wredhi Putra
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';
import '../widgets/course_card.dart';
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});
  final String studentName = "I Wayan Agus Wredhi Putra";
  final String studentId = "2415051007";
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();
    final favCourses = provider.favoriteCourses;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Favorit Saya', style: TextStyle(color: Colors.white, fontSize: 16)),
        backgroundColor: Color.fromARGB(255, 1, 154, 249),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            color: Colors.indigo.shade50,
            child: Text(
              '$studentName - $studentId',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: favCourses.isEmpty
                ? const Center(
                    child: Text(
                      'Belum ada course favorit.',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: favCourses.length,
                    itemBuilder: (context, index) {
                      return CourseCard(course: favCourses[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}