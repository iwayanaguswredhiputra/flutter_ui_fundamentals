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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State createState() => _DashboardPageState();
}

class _DashboardPageState extends State {
  late Future studentFuture;

  @override
  void initState() {
    super.initState();
    studentFuture = loadStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 13: Learning Dashboard'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
        future: studentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Gagal memuat data: ${snapshot.error}'),
            );
          }
          final data = snapshot.data!;
          final student = data['student'] as Map;
          final courses = data['courses'] as List;

          final String studentName = student['name'] as String;
          final String studentId = student['nim'] as String;

          final int completedCount = courses
              .where((item) => item['status'] == 'done')
              .length;

          return Column(
            children: [
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
      ),
    );
  }
}