import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const String apiUrl = 'https://jsonplaceholder.typicode.com/posts';
Future<List<dynamic>> fetchCourses() async {
  final response = await http.get(Uri.parse(apiUrl));
  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        debugPrint('Jumlah data berhasil dimuat: ${data.length} item');
    return data;
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            Text(
              'I Wayan Agus Wredhi Putra (2415051007)',
              style: TextStyle(fontSize: 12), 
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Cek Debug Console untuk melihat hasil fetch data!'),
      ),
    );
  }
}