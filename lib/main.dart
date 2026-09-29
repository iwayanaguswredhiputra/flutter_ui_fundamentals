import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

Future loadStudentData() async {
  final jsonString = await rootBundle.loadString('assets/data/student_data.json');
  return jsonDecode(jsonString) as Map;
}
void main() => runApp(const MyApp());
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const DashboardPage(),
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
        title: const Text('Learning Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: FutureBuilder(
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
            final String studentName = student['name'] ?? '';
            final String studentNim = student['nim'] ?? '';
            final String studentProdi = student['prodi'] ?? ''; 
            final int totalCourses = courses.length;
            final int totalSks = courses.fold(0, (sum, item) => sum + (item['credits'] as int));
            final int completedCourses = courses.where((item) => item['status'] == 'done').length;
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileCard(
                    name: studentName,
                    nim: studentNim,
                    prodi: studentProdi,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: SummaryCard(
                          title: 'Progres Matakuliah',
                          value: '$completedCourses dari $totalCourses Selesai',
                          icon: Icons.task_alt,
                          bgColor: Colors.blue.shade50,
                          iconColor: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SummaryCard(
                          title: 'Total Beban',
                          value: '$totalSks Total SKS',
                          icon: Icons.menu_book,
                          bgColor: Colors.amber.shade50,
                          iconColor: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    'Daftar Topik / Matakuliah',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        final course = courses[index] as Map;
                        return CourseCard(course: course);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String name;
  final String nim;
  final String prodi;
  const ProfileCard({
    super.key,
    required this.name,
    required this.nim,
    required this.prodi,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 26,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'NIM: $nim',
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  Text(
                    prodi,
                    style: TextStyle(fontSize: 12, color: Colors.blue.shade700, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 26),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class CourseCard extends StatelessWidget {
  final Map course;
  const CourseCard({super.key, required this.course});
  @override
  Widget build(BuildContext context) {
    final String status = course['status'] as String;
    final bool isDone = status == 'done';
    final bool isActive = status == 'active';
    Color avatarBg = isDone ? Colors.green.shade100 : (isActive ? Colors.blue.shade100 : Colors.grey.shade200);
    Color textColor = isDone ? Colors.green.shade900 : Colors.black87;
    IconData statusIcon = isDone ? Icons.check_circle : (isActive ? Icons.play_circle_fill : Icons.hourglass_empty);
    Color iconColor = isDone ? Colors.green : (isActive ? Colors.blue : Colors.grey);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: avatarBg,
          child: Text(
            course['code'] as String,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: textColor),
          ),
        ),
        title: Text(
          course['title'] as String,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        subtitle: Text('${course['credits']} SKS • Status: $status'),
        trailing: Icon(statusIcon, color: iconColor),
      ),
    );
  }
}