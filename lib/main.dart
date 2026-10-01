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
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tahap 5: GridView Responsif'),
          backgroundColor: const Color.fromARGB(255, 0, 76, 255),
          foregroundColor: Colors.white,
        ),
        body: const ResponsiveGridPage(),
      ),
    );
  }
}
class Course {
  final String code;
  final String title;
  final int sks;
  final Color color;

  const Course({
    required this.code,
    required this.title,
    required this.sks,
    required this.color,
  });
}
class ResponsiveGridPage extends StatelessWidget {
  const ResponsiveGridPage({super.key});
  final List<Course> courses = const [
    Course(code: 'INF201', title: 'Pemrograman Mobile', sks: 3, color: Colors.blue),
    Course(code: 'INF202', title: 'Pemrograman Web', sks: 3, color: Colors.teal),
    Course(code: 'INF203', title: 'Basis Data', sks: 3, color: Colors.orange),
    Course(code: 'INF204', title: 'Struktur Data', sks: 3, color: Colors.purple),
    Course(code: 'INF205', title: 'Jaringan Komputer', sks: 3, color: Colors.indigo),
    Course(code: 'INF206', title: 'Pembelajaran Mikro', sks: 3, color: Colors.green),
  ];
  int columnsFor(double width) {
    if (width < 600) return 1;
    if (width < 840) return 2;
    return 3;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
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
            'Daftar Mata Kuliah',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final cols = columnsFor(constraints.maxWidth);
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: cols,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: cols == 1 ? 2.8 : 2.0,
                  ),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses[index];
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border(
                            left: BorderSide(color: course.color, width: 6),
                          ),
                        ),
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              course.code,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: course.color,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              course.title,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Beban: ${course.sks} SKS',
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                            ),
                          ],
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