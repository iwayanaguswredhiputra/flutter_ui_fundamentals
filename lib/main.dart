import 'package:flutter/material.dart';
void main() => runApp(const MyApp());
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String studentName = 'I Wayan Agus Wredhi Putra';
  static const String studentId = '2415051007';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 1, 154, 249),),
),
      home: const CourseListPage(),
    );
  }
}
class CourseListPage extends StatelessWidget {
  const CourseListPage({super.key});
  final List<Map<String, dynamic>> courses = const [
    {
      'code': 'INF201',
      'title': 'Pemrograman Mobile',
      'credits': 3,
      'status': 'Wajib',
      'description': 'Mempelajari pengembangan aplikasi mobile lintas platform menggunakan Flutter dan Dart.',
      'color': Colors.blue,
    },
    {
      'code': 'INF202',
      'title': 'Pemrograman Web',
      'credits': 3,
      'status': 'Wajib',
      'description': 'Mempelajari konsep web modern, backend Laravel, dan arsitektur MVC.',
      'color': Colors.teal,
    },
    {
      'code': 'INF203',
      'title': 'Basis Data',
      'credits': 3,
      'status': 'Wajib',
      'description': 'Mempelajari perancangan ERD, normalisasi, serta pemrosesan query SQL.',
      'color': Colors.orange,
    },
    {
      'code': 'INF204',
      'title': 'Struktur Data',
      'credits': 3,
      'status': 'Wajib',
      'description': 'Mempelajari konsep array, stack, queue, tree, graph, dan analisis algoritma.',
      'color': Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 8: Daftar Mata Kuliah'),
        backgroundColor: const Color.fromARGB(255, 1, 154, 249),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.indigo.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Identitas Mahasiswa:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.indigo),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${MyApp.studentId} - ${MyApp.studentName}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Pilih Mata Kuliah untuk Detail:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: CircleAvatar(
                        backgroundColor: course['color'] as Color,
                        child: Text(
                          course['code'].toString().substring(0, 3),
                          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(
                        course['title'] as String,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('${course['code']} • ${course['credits']} SKS'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CourseDetailPage(course: course),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseDetailPage extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseDetailPage({
    super.key,
    required this.course,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course['title'] as String),
        backgroundColor: course['color'] as Color,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Identitas Mahasiswa:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${MyApp.studentId} - ${MyApp.studentName}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Chip(
                          label: Text(
                            course['code'] as String,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: course['color'] as Color,
                        ),
                        Chip(
                          label: Text(course['status'] as String),
                          backgroundColor: Colors.grey.shade200,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      course['title'] as String,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Beban SKS: ${course['credits']} SKS',
                      style: const TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    const Divider(height: 24),
                    const Text(
                      'Deskripsi Mata Kuliah:',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      course['description'] as String,
                      style: const TextStyle(color: Colors.black87, height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali ke Daftar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: course['color'] as Color,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}