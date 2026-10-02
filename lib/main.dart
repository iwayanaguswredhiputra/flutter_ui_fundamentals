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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 1, 154, 249),
        ),
        useMaterial3: true,
      ),
      home: const MainNavigationPage(),
    );
  }
}
class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});
  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}
class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = const [
    HomePage(),
    CourseListPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.school), label: 'Courses'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 10: Home'),
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
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Identitas Mahasiswa:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blue),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${MyApp.studentId} - ${MyApp.studentName}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Selamat Datang!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Gunakan Navigation Bar di bawah untuk berpindah ke daftar mata kuliah atau melihat profil.'),
          ],
        ),
      ),
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
        title: const Text('Daftar Mata Kuliah'),
        backgroundColor: const Color.fromARGB(255, 1, 154, 249),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: courses.length,
          itemBuilder: (context, index) {
            final course = courses[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: course['color'] as Color,
                  child: Text(
                    course['code'].toString().substring(0, 3),
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(course['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${course['code']} • ${course['credits']} SKS'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async {
                  final result = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(builder: (_) => CourseDetailPage(course: course)),
                  );
                  if (result == true && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Mata kuliah "${course['title']}" berhasil difavoritkan!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
class CourseDetailPage extends StatelessWidget {
  final Map<String, dynamic> course;
  const CourseDetailPage({super.key, required this.course});
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
            Text('Beban SKS: ${course['credits']} SKS', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(course['description'] as String),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context, true),
                icon: const Icon(Icons.favorite),
                label: const Text('Pilih / Favoritkan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
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
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Mahasiswa'),
        backgroundColor: const Color.fromARGB(255, 1, 154, 249),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 40,
              backgroundColor: Color.fromARGB(255, 1, 154, 249),
              child: Icon(Icons.person, size: 45, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              MyApp.studentName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              '${MyApp.studentId}',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const Divider(height: 32),
            const ListTile(
              leading: Icon(Icons.school, color: Colors.blue),
              title: Text('Program Studi'),
              subtitle: Text('Pendidikan Teknik Informatika'),
            ),
            const ListTile(
              leading: Icon(Icons.badge, color: Colors.blue),
              title: Text('Status Mahasiswa'),
              subtitle: Text('Aktif'),
            ),
          ],
        ),
      ),
    );
  }
}