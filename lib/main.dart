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
      title: 'Pertemuan 6 - Tahap 3',
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
  final List<String> _favoriteCourses = [];
  void _toggleFavorite(String courseTitle) {
    setState(() {
      if (_favoriteCourses.contains(courseTitle)) {
        _favoriteCourses.remove(courseTitle);
      } else {
        _favoriteCourses.add(courseTitle);
      }
    });
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
          'P06: Tahap 3 - Lifting State Up & Single Source of Truth',
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
          CourseSummary(favoriteCount: _favoriteCourses.length),
          const Divider(height: 1),
          Expanded(
            child: CourseList(
              courses: allCourses,
              favoriteCourses: _favoriteCourses,
              onToggleFavorite: _toggleFavorite,
            ),
          ),
        ],
      ),
    );
  }
}

class CourseSummary extends StatelessWidget {
  final int favoriteCount;
  const CourseSummary({super.key, required this.favoriteCount});
  @override
  Widget build(BuildContext context) {
    return Container(
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
              '$favoriteCount Item',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
class CourseList extends StatelessWidget {
  final List<String> courses;
  final List<String> favoriteCourses;
  final Function(String) onToggleFavorite;
  const CourseList({
    super.key,
    required this.courses,
    required this.favoriteCourses,
    required this.onToggleFavorite,
  });
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        final isFav = favoriteCourses.contains(course);
        return CourseCard(
          title: course,
          isFavorite: isFav,
          onFavoriteChanged: () => onToggleFavorite(course),
        );
      },
    );
  }
}
//2415051007 - I Wayan Agus Wredhi Putra
class CourseCard extends StatelessWidget {
  final String title;
  final bool isFavorite;
  final VoidCallback onFavoriteChanged;
  const CourseCard({
    super.key,
    required this.title,
    required this.isFavorite,
    required this.onFavoriteChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(title),
        trailing: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.grey,
          ),
          onPressed: onFavoriteChanged,
        ),
      ),
    );
  }
}