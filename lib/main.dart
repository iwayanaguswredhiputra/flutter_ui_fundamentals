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
    FeedbackFormPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        if (constraint.maxWidth < 600) {
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
                NavigationDestination(icon: Icon(Icons.rate_review), label: 'Feedback'),
                NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
              ],
            ),
          );
        }
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.school),
                      label: Text('Courses'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.rate_review),
                      label: Text('Feedback'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person),
                      label: Text('Profile'),
                    ),
                  ],
                ),
              ),
              const VerticalDivider(thickness: 1, width: 1),
              Expanded(
                child: _pages[_selectedIndex],
              ),
            ],
          ),
        );
      },
    );
  }
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 14: SnackBar & Dialog'),
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${MyApp.studentId} - ${MyApp.studentName}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Selamat Datang di Home Page',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tahap ini menambahkan SnackBar, AlertDialog konfirmasi, serta CircularProgressIndicator untuk umpan balik interaksi pengguna.',
            ),
          ],
        ),
      ),
    );
  }
}
class CourseListPage extends StatefulWidget {
  const CourseListPage({super.key});
  @override
  State<CourseListPage> createState() => _CourseListPageState();
}
class _CourseListPageState extends State<CourseListPage> {
  final Set<String> _favoriteCourseCodes = {};
  final List<Map<String, dynamic>> courses = const [
    {
      'code': 'INF201',
      'title': 'Pemrograman Mobile',
      'credits': 3,
      'status': 'Wajib',
      'description':
          'Mempelajari pengembangan aplikasi mobile lintas platform menggunakan Flutter dan Dart.',
      'color': Colors.blue,
    },
    {
      'code': 'INF202',
      'title': 'Pemrograman Web',
      'credits': 3,
      'status': 'Wajib',
      'description':
          'Mempelajari konsep web modern, backend Laravel, dan arsitektur MVC.',
      'color': Colors.teal,
    },
    {
      'code': 'INF203',
      'title': 'Basis Data',
      'credits': 3,
      'status': 'Wajib',
      'description':
          'Mempelajari perancangan ERD, normalisasi, serta pemrosesan query SQL.',
      'color': Colors.orange,
    },
    {
      'code': 'INF204',
      'title': 'Struktur Data',
      'credits': 3,
      'status': 'Wajib',
      'description':
          'Mempelajari konsep array, stack, queue, tree, graph, dan analisis algoritma.',
      'color': Colors.purple,
    },
  ];
  void _toggleFavorite(String code) {
    setState(() {
      if (_favoriteCourseCodes.contains(code)) {
        _favoriteCourseCodes.remove(code);
      } else {
        _favoriteCourseCodes.add(code);
      }
    });
  }
  void _showQuickInfoDialog(BuildContext context, Map<String, dynamic> course) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Info Cepat: ${course['code']}'),
        content: Text(
          'Mata Kuliah: ${course['title']}\n'
          'SKS: ${course['credits']} SKS\n'
          'Status: ${course['status']}\n',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }
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
            final isFavorite = _favoriteCourseCodes.contains(course['code']);
            return CourseCard(
              course: course,
              isFavorite: isFavorite,
              onFavoriteToggle: () => _toggleFavorite(course['code'] as String),
              onLongPressInfo: () => _showQuickInfoDialog(context, course),
            );
          },
        ),
      ),
    );
  }
}
class CourseCard extends StatelessWidget {
  final Map<String, dynamic> course;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onLongPressInfo;
  const CourseCard({
    super.key,
    required this.course,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onLongPressInfo,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: GestureDetector(
        onLongPress: onLongPressInfo,
        child: InkWell(
          onTap: () async {
            final result = await Navigator.push<bool>(
              context,
              MaterialPageRoute(
                builder: (_) => CourseDetailPage(course: course),
              ),
            );
            if (result == true && context.mounted) {
              onFavoriteToggle();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: course['color'] as Color,
                  child: Text(
                    course['code'].toString().substring(0, 3),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course['title'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${course['code']} • ${course['credits']} SKS',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: onFavoriteToggle,
                  tooltip: 'Favorit',
                ),
              ],
            ),
          ),
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
            Text(
              'Beban SKS: ${course['credits']} SKS',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(course['description'] as String),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context, true),
                icon: const Icon(Icons.favorite),
                label: const Text('Pilih Favorit'),
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
class FeedbackFormPage extends StatefulWidget {
  const FeedbackFormPage({super.key});
  @override
  State<FeedbackFormPage> createState() => _FeedbackFormPageState();
}
class _FeedbackFormPageState extends State<FeedbackFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _nimController;
  final TextEditingController _commentController = TextEditingController();
  bool _isLoading = false;
  String? _submittedResult;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: MyApp.studentName);
    _nimController = TextEditingController(text: MyApp.studentId);
  }
  @override
  void dispose() {
    _nameController.dispose();
    _nimController.dispose();
    _commentController.dispose();
    super.dispose();
  }
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Konfirmasi Pengiriman'),
          content: Text(
            'Apakah Anda yakin ingin mengirim umpan balik ini?\n\n'
            'Pengirim: ${_nameController.text} (${_nimController.text})',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _processSubmission();
              },
              child: const Text('Ya, Kirim'),
            ),
          ],
        ),
      );
    }
  }
  Future<void> _processSubmission() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
      _submittedResult =
          'Umpan balik berhasil dikirim oleh ${_nameController.text} (${_nimController.text}):\n"${_commentController.text}"';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Umpan balik dari ${MyApp.studentName} (${MyApp.studentId}) berhasil disimpan!',
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Feedback'),
        backgroundColor: const Color.fromARGB(255, 1, 154, 249),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Formulir Umpan Balik',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nimController,
                decoration: const InputDecoration(
                  labelText: 'NIM',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.badge),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'NIM wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _commentController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Komentar / Umpan Balik',
                  hintText: 'Tuliskan masukan Anda',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.comment),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Komentar wajib diisi';
                  }
                  if (value.trim().length < 5) {
                    return 'Komentar wajib minimal 5 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 1, 154, 249),
                    foregroundColor: Colors.white,
                  ),
                  child: _isLoading
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                            SizedBox(width: 12),
                            Text('Memproses...'),
                          ],
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.send),
                            SizedBox(width: 8),
                            Text('Kirim Umpan Balik'),
                          ],
                        ),
                ),
              ),
              if (_submittedResult != null) ...[
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hasil Pengiriman:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(_submittedResult!),
                    ],
                  ),
                ),
              ],
            ],
          ),
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
              MyApp.studentId,
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