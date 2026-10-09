import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'course_state.dart';
import 'models/course.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseState(),
      child: const CourseExplorerApp(),
    ),
  );
}
class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pertemuan 6 - Tahap 8',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const CourseExplorerScreen(),
    );
  }
}
class CourseExplorerScreen extends StatelessWidget {
  const CourseExplorerScreen({super.key});
  final String studentName = "I Wayan Agus Wredhi Putra";
  final String studentId = "2415051007";
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> rawCourses = [
      {
        "code": "MOB101",
        "title": "Pemrograman Mobile",
        "credits": 3,
        "status": "Wajib"
      },
      {
        "code": "WEB102",
        "title": "Pengembangan Web",
        "credits": 3,
        "status": "Wajib"
      },
      {
        "code": "PCD103",
        "title": "Pengolahan Citra Digital",
        "credits": 2,
        "status": "Pilihan"
      },
      {
        "code": "JARKOM104",
        "title": "Jaringan Komputer",
        "credits": 3,
        "status": "Wajib"
      },
    ];
    final List<Course> courseList =
        rawCourses.map((json) => Course.fromJson(json)).toList();
    final courseStateWatch = context.watch<CourseState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'P06: Tahap 8 - Model Course & JSON',
          style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 1, 154, 249),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: Colors.indigo.shade50,
            child: Column(
              children: [
                Text(
                  studentName,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  'NIM: $studentId',
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.amber.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Course Favorit:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Chip(
                  avatar: const Icon(Icons.favorite, color: Colors.red, size: 18),
                  label: Text(
                    '${courseStateWatch.favoriteCount} Item',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              itemCount: courseList.length,
              itemBuilder: (context, index) {
                final course = courseList[index];
                return Consumer<CourseState>(
                  builder: (context, courseState, child) {
                    final isFav = courseState.isFavorite(course.code);
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListTile(
                        title: Text('${course.title} (${course.code})'),
                        subtitle: Text('${course.credits} SKS | Status: ${course.status}'),
                        trailing: IconButton(
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            context.read<CourseState>().toggleFavorite(course.code);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}