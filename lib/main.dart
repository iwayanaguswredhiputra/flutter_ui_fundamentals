import 'package:flutter/material.dart';

void main() {
  runApp(const CourseExplorerApp());
}

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pertemuan 6 - Tahap 4',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const CourseExplorerScreen(),
    );
  }
}

class CourseExplorerScreen extends StatefulWidget {
  const CourseExplorerScreen({super.key});
  @override
  State<CourseExplorerScreen> createState() => _CourseExplorerScreenState();
}
class _CourseExplorerScreenState extends State<CourseExplorerScreen> {
  final String studentName = "I Wayan Agus Wredhi Putra";
  final String studentId = "2415051007";
  final ValueNotifier<int> favoriteCountNotifier = ValueNotifier<int>(0);
  final List<String> _favoriteCourses = [];
  void _toggleFavorite(String courseTitle) {
    setState(() {
      if (_favoriteCourses.contains(courseTitle)) {
        _favoriteCourses.remove(courseTitle);
      } else {
        _favoriteCourses.add(courseTitle);
      }
    });
    favoriteCountNotifier.value = _favoriteCourses.length;
  }
  @override
  void dispose() {
    favoriteCountNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> allCourses = [
      "Pemrograman Mobile",
      "Pengembangan Web",
      "Pengolahan Citra Digital",
      "Jaringan Komputer",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'P06: Tahap 4 - ValueNotifier & ValueListenableBuilder',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
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

//2415051007 - I Wayan Agus Wredhi Putra
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
                ValueListenableBuilder<int>(
                  valueListenable: favoriteCountNotifier,
                  builder: (context, count, child) {
                    return Chip(
                      avatar: const Icon(Icons.favorite, color: Colors.red, size: 18),
                      label: Text(
                        '$count Item',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  },
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
                final isFav = _favoriteCourses.contains(course);
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(course),
                    trailing: IconButton(
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? Colors.red : Colors.grey,
                      ),
                      onPressed: () => _toggleFavorite(course),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}