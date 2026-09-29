import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

// Function pembaca JSON statik
Future loadStudentData() async {
  final jsonString = await rootBundle.loadString(
    'assets/data/student_data.json',
  );
  return jsonDecode(jsonString) as Map;
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tahap 12: Read JSON Asset'),
          backgroundColor: Colors.blue,
        ),
        body: const TopicListScreen(),
      ),
    );
  }
}

class TopicListScreen extends StatelessWidget {
  const TopicListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadStudentData(),
      builder: (context, snapshot) {
        // Tampilan Loading saat membaca file JSON
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Tampilan jika terdapat Error
        if (snapshot.hasError) {
          return Center(
            child: Text('Gagal memuat JSON: ${snapshot.error}'),
          );
        }

        // Data JSON berhasil di-decode
        final data = snapshot.data as Map;
        final student = data['student'] as Map;
        final courses = data['courses'] as List;

        final String studentName = student['name'] as String;
        final String studentId = student['nim'] as String;

        // Menghitung status dari data JSON
        final int completedCount = courses
            .where((item) => item['status'] == 'done')
            .length;

        return Column(
          children: [
            // Header Identitas Profil (Membaca Data JSON Student)
            Container(
              width: double.infinity,
              color: Colors.blue.shade50,
              padding: const EdgeInsets.all(12.0),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage('assets/images/profile.png'),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            studentName,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            studentId,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Teks Ringkasan Mata Kuliah / Topik dari JSON
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$completedCount dari ${courses.length} matakuliah selesai',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const Icon(Icons.folder_special, color: Colors.blue),
                ],
              ),
            ),

            // Render List Kursus dari JSON Assets
            Expanded(
              child: ListView.builder(
                itemCount: courses.length,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                itemBuilder: (context, index) {
                  final course = courses[index] as Map;
                  final String status = course['status'] as String;
                  final bool isDone = status == 'done';
                  final int credits = course['credits'] as int;

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: isDone
                            ? Colors.green.shade100
                            : (status == 'active'
                                ? Colors.blue.shade100
                                : Colors.grey.shade200),
                        child: Text(
                          course['code'] as String,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: isDone
                                ? Colors.green.shade900
                                : Colors.black87,
                          ),
                        ),
                      ),
                      title: Text(
                        course['title'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          decoration: isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      subtitle: Text('$credits SKS • Status: $status'),
                      trailing: Icon(
                        isDone
                            ? Icons.check_circle
                            : (status == 'active'
                                ? Icons.play_circle_fill
                                : Icons.hourglass_empty),
                        color: isDone
                            ? Colors.green
                            : (status == 'active' ? Colors.blue : Colors.grey),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}