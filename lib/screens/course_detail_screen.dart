// 2415051007 - I Wayan Agus Wredhi Putra
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';
class CourseDetailScreen extends StatelessWidget {
  const CourseDetailScreen({super.key, required this.course});
  final Course course;
  final String studentName = "I Wayan Agus Wredhi Putra";
  final String studentId = "2415051007";
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();
    final isFav = provider.isFavorite(course.code);
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title, style: const TextStyle(color: Colors.white, fontSize: 16)),
        backgroundColor: Color.fromARGB(255, 1, 154, 249),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              color: Colors.indigo.shade50,
              child: Text(
                '$studentName ($studentId)',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Text('Kode Mata Kuliah: ${course.code}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Nama Mata Kuliah: ${course.title}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Jumlah SKS: ${course.credits}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Status: ${course.status}', style: const TextStyle(fontSize: 16)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isFav ? Colors.red.shade50 : Colors.indigo.shade50,
                  foregroundColor: isFav ? Colors.red : const Color.fromARGB(255, 1, 154, 249),
                ),
                icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                label: Text(isFav ? 'Hapus dari Favorit' : 'Tambah ke Favorit'),
                onPressed: () {
                  provider.toggleFavorite(course.code);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}