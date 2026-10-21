import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/course.dart';

const String apiUrl = 'https://jsonplaceholder.typicode.com/posts';
Future<List<Course>> fetchCourses() async {
  final response = await http.get(Uri.parse(apiUrl));
  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    List<Course> courses = body.map((dynamic item) => Course.fromJson(item)).toList();
    debugPrint('Jumlah course berhasil dimuat: ${courses.length} item');
    return courses;
  } else {
    throw Exception('Gagal memuat data: HTTP ${response.statusCode}');
  }
}
class CourseExplorerScreen extends StatefulWidget {
  const CourseExplorerScreen({super.key});
  @override
  State<CourseExplorerScreen> createState() => _CourseExplorerScreenState();
}
class _CourseExplorerScreenState extends State<CourseExplorerScreen> {
  @override
  void initState() {
    super.initState();
    fetchCourses(); 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75, 
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Course Explorer',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            Text(
              'I Wayan Agus Wredhi Putra (2415051007)',
              style: TextStyle(fontSize: 15), 
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Course>>(
        future: fetchCourses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data.'));
          }
          final courses = snapshot.data!;
          return ListView.builder(
            itemCount: courses.length > 10 ? 10 : courses.length, 
            itemBuilder: (context, index) {
              final course = courses[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text('${course.id}'),
                  ),
                  title: Text(course.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Kode: ${course.code} | SKS: ${course.credits}'),
                  trailing: Chip(
                    label: Text(course.status),
                    backgroundColor: course.status == 'active' ? Colors.green[150] : Colors.orange[150],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}