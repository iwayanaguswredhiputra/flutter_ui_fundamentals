import 'package:flutter/material.dart';
void main() {
  runApp(const CourseExplorerApp());
}
class Course {
  final String id;
  final String title;
  final String code;
  final String status;
  final String description;
  final String instructor;
  bool isFavorite;
  Course({
    required this.id,
    required this.title,
    required this.code,
    required this.status,
    required this.description,
    required this.instructor,
    this.isFavorite = false,
  });
}
class CourseExplorerApp extends StatefulWidget {
  const CourseExplorerApp({super.key});
  static const String studentName = 'I Wayan Agus Wredhi Putra';
  static const String studentId = '2415051007';
  @override
  State<CourseExplorerApp> createState() => _CourseExplorerAppState();
}
class _CourseExplorerAppState extends State<CourseExplorerApp> {
  final List<Course> _courses = [
  Course(
    id: '1',
    title: 'Pemrograman Mobile',
    code: 'INF201',
    status: 'Active',
    description: 'Mempelajari pengembangan aplikasi mobile lintas platform menggunakan framework Flutter dan bahasa Dart.',
    instructor: 'Tim Dosen Pemrograman Mobile',
    isFavorite: true,
  ),
  Course(
    id: '2',
    title: 'Pemrograman Web',
    code: 'INF202',
    status: 'Active',
    description: 'Pengembangan aplikasi web dinamis menggunakan arsitektur MVC pada framework Laravel.',
    instructor: 'Tim Dosen Pemrograman Web',
  ),
  Course(
    id: '3',
    title: 'Basis Data',
    code: 'INF203',
    status: 'Active',
    description: 'Mempelajari perancangan basis data relasional, normalisasi, serta perintah SQL.',
    instructor: 'Tim Dosen Basis Data',
  ),
  Course(
    id: '4',
    title: 'Struktur Data',
    code: 'INF204',
    status: 'Planned',
    description: 'Mempelajari struktur data fundamental seperti Linked List, Stack, Queue, Tree, dan Graph.',
    instructor: 'Tim Dosen Struktur Data',
  ),
  Course(
    id: '5',
    title: 'Jaringan Komputer', 
    code: 'INF205',
    status: 'Planned',
    description: 'Simulasi konfigurasi jaringan, routing, switching, dan analisis paket data.',
    instructor: 'Tim Dosen Jaringan Komputer',
  ),
];
  void _toggleFavorite(Course course) {
    setState(() {
      course.isFavorite = !course.isFavorite;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Explorer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 1, 154, 249),
        ),
        useMaterial3: true,
      ),
      home: ResponsiveShell(
        courses: _courses,
        onToggleFavorite: _toggleFavorite,
      ),
    );
  }
}
class ResponsiveShell extends StatefulWidget {
  final List<Course> courses;
  final Function(Course) onToggleFavorite;
  const ResponsiveShell({
    super.key,
    required this.courses,
    required this.onToggleFavorite,
  });
  @override
  State<ResponsiveShell> createState() => _ResponsiveShellState();
}
class _ResponsiveShellState extends State<ResponsiveShell> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isExpanded = constraints.maxWidth >= 600;
        final List<Widget> pages = [
          HomePage(courses: widget.courses),
          CoursesPage(
            courses: widget.courses,
            isExpanded: isExpanded,
            onToggleFavorite: widget.onToggleFavorite,
          ),
          ProfilePage(
            courses: widget.courses,
            onToggleFavorite: widget.onToggleFavorite,
          ),
        ];
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 1, 154, 249),
            foregroundColor: Colors.white,
            title: const Text(
              'Course Explorer',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              if (isExpanded)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: Text(
                      '${CourseExplorerApp.studentName} (${CourseExplorerApp.studentId})',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
            ],
          ),
          body: Row(
            children: [
              if (isExpanded)
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Home'), 
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.book_outlined),
                      selectedIcon: Icon(Icons.book),
                      label: Text('Courses'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person_outlined),
                      selectedIcon: Icon(Icons.person),
                      label: Text('Profile'),
                    ),
                  ],
                ),
              if (isExpanded) const VerticalDivider(thickness: 1, width: 1),
              Expanded(child: pages[_selectedIndex]),
            ],
          ),
          bottomNavigationBar: isExpanded
              ? null
              : NavigationBar(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: 'Home', 
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.book_outlined),
                      selectedIcon: Icon(Icons.book),
                      label: 'Courses',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.person_outlined),
                      selectedIcon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                  ],
                ),
        );
      },
    );
  }
}
class StudentInfoCard extends StatelessWidget {
  const StudentInfoCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 1, 154, 249),
            child: const Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                CourseExplorerApp.studentName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 4),
              Text(
                CourseExplorerApp.studentId,
                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class CourseCardWidget extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;
  final VoidCallback onFavoritePressed;
  const CourseCardWidget({
    super.key,
    required this.course,
    required this.onTap,
    required this.onFavoritePressed,
  });
  @override
  Widget build(BuildContext context) {
    final bool isActive = course.status == 'Active';
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      course.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  GestureDetector(
                    onTap: onFavoritePressed,
                    child: Icon(
                      course.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: course.isFavorite ? Colors.red : Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    course.code,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  Text(
                    course.status,
                    style: TextStyle(
                      color: isActive ? Colors.green.shade700 : Colors.teal.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class HomePage extends StatelessWidget {
  final List<Course> courses;
  const HomePage({super.key, required this.courses});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          StudentInfoCard(),
          SizedBox(height: 24),
          Text(
            'Selamat Datang di Course Explorer!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
class CoursesPage extends StatefulWidget {
  final List<Course> courses;
  final bool isExpanded;
  final Function(Course) onToggleFavorite;
  const CoursesPage({
    super.key,
    required this.courses,
    required this.isExpanded,
    required this.onToggleFavorite,
  });
  @override
  State<CoursesPage> createState() => _CoursesPageState();
}
class _CoursesPageState extends State<CoursesPage> {
  String _searchQuery = '';
  @override
  Widget build(BuildContext context) {
    final filteredCourses = widget.courses.where((course) {
      return course.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          course.code.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search courses...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.blue.shade50.withValues(alpha: 0.5),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: widget.isExpanded
                ? GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2.5,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: filteredCourses.length,
                    itemBuilder: (context, index) {
                      return _buildCourseItem(context, filteredCourses[index]);
                    },
                  )
                : ListView.builder(
                    itemCount: filteredCourses.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: _buildCourseItem(context, filteredCourses[index]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
  Widget _buildCourseItem(BuildContext context, Course course) {
    return CourseCardWidget(
      course: course,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailPage(
              course: course,
              onToggleFavorite: widget.onToggleFavorite,
            ),
          ),
        ).then((_) => setState(() {}));
      },
      onFavoritePressed: () {
        widget.onToggleFavorite(course);
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              course.isFavorite
                  ? '${course.title} ditambahkan ke favorit.'
                  : '${course.title} dihapus dari favorit.',
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      },
    );
  }
}
class CourseDetailPage extends StatefulWidget {
  final Course course;
  final Function(Course) onToggleFavorite;

  const CourseDetailPage({
    super.key,
    required this.course,
    required this.onToggleFavorite,
  });
  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}
class _CourseDetailPageState extends State<CourseDetailPage> {
  @override
  Widget build(BuildContext context) {
    final course = widget.course;
    return Scaffold(
      appBar: AppBar(
        title: Text(course.code),
        backgroundColor: const Color.fromARGB(255, 1, 154, 249),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              course.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: course.isFavorite ? Colors.redAccent : Colors.white,
            ),
            onPressed: () {
              setState(() {
                widget.onToggleFavorite(course);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    course.isFavorite
                        ? '${course.title} ditambahkan ke favorit.'
                        : '${course.title} dihapus dari favorit.',
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: course.status == 'Active' ? Colors.green.shade100 : Colors.teal.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                course.status,
                style: TextStyle(
                  color: course.status == 'Active' ? Colors.green.shade800 : Colors.teal.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(height: 40),
            const Text('Pengajar:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 4),
            Text(course.instructor, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text('Deskripsi:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text(course.description, style: const TextStyle(fontSize: 16, height: 1.5)),
          ],
        ),
      ),
    );
  }
}
class ProfilePage extends StatefulWidget {
  final List<Course> courses;
  final Function(Course) onToggleFavorite;

  const ProfilePage({
    super.key,
    required this.courses,
    required this.onToggleFavorite,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: CourseExplorerApp.studentName);
  final _nimController = TextEditingController(text: CourseExplorerApp.studentId);
  final _feedbackController = TextEditingController();
  bool _isLoading = false;
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Konfirmasi'),
          content: Text('Kirim umpan balik ini atas nama ${_nameController.text}?'),
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
              child: const Text('Kirim'),
            ),
          ],
        ),
      );
    }
  }
  Future<void> _processSubmission() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _feedbackController.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Umpan balik berhasil dikirim!'),
        backgroundColor: Colors.green,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StudentInfoCard(),
          const SizedBox(height: 24),
          const Text(
            'Form Feedback',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Lengkap',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nimController,
                  decoration: const InputDecoration(
                    labelText: 'NIM',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.badge),
                  ),
                  validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _feedbackController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Masukan / Saran',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.comment),
                  ),
                  validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _submitForm,
                    icon: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.send),
                    label: Text(_isLoading ? 'Memproses...' : 'Kirim Umpan Balik'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 1, 154, 249),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}