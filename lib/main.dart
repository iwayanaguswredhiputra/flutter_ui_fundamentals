import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'course_state.dart';
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
      title: 'Pertemuan 6 - Tahap 7',
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
    final List<String> allCourses = [
      "Pemrograman Mobile",
      "Pengembangan Web",
      "Pengolahan Citra Digital",
      "Jaringan Komputer",
    ];
    final courseStateWatch = context.watch<CourseState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'P06: Tahap 7 - watch, read & Consumer',
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
              itemCount: allCourses.length,
              itemBuilder: (context, index) {
                final course = allCourses[index];
//2415051007 - I Wayan Agus Wredhi Putra
                return Consumer<CourseState>(
                  builder: (context, courseState, child) {
                    final isFav = courseState.isFavorite(course);
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListTile(
                        title: Text(course),
                        trailing: IconButton(
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            context.read<CourseState>().toggleFavorite(course);
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