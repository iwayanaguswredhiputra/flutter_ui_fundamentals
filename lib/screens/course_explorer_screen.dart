// 2415051007 - I Wayan Agus Wredhi Putra
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';
import '../widgets/course_card.dart';
import '../widgets/error_view.dart'; 
import 'favorites_screen.dart';
import '../screens/add_course_screen.dart';
import '../services/auth_service.dart';
import '../services/profile_service.dart'; 
import 'login_screen.dart';

class CourseExplorerScreen extends StatefulWidget {
  const CourseExplorerScreen({super.key});
  @override
  State<CourseExplorerScreen> createState() => _CourseExplorerScreenState();
}

class _CourseExplorerScreenState extends State<CourseExplorerScreen> {
  int _selectedIndex = 0;
  final String studentName = "I Wayan Agus Wredhi Putra";
  final String studentId = "2415051007";

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();
    
    final List<Widget> pages = [
      SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$studentId • $studentName',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 1, 154, 249),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: Colors.blue.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Courses', style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 8),
                          Text(
                            '${provider.courses.length}',
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Card(
                    color: Colors.red.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Favorites', style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 8),
                          Text(
                            '${provider.favoriteCount}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (provider.isLoading)
              const Center(child: CircularProgressIndicator())
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: provider.courses.length,
                itemBuilder: (context, index) {
                  return CourseCard(course: provider.courses[index]);
                },
              ),
          ],
        ),
      ),
      
      Builder(
        builder: (context) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$studentId • $studentName',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 1, 154, 249),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (provider.isLoading)
                  const Padding(
                    padding: EdgeInsets.only(top: 60),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (provider.error != null)
                  SizedBox(
                    height: 350,
                    child: ErrorView(
                      message: provider.error!,
                      onRetry: () => provider.loadCourses(),
                    ),
                  )
                else if (provider.courses.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 60),
                    child: Center(
                      child: Text(
                        'Data course belum tersedia',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.courses.length,
                    itemBuilder: (context, index) {
                      return CourseCard(course: provider.courses[index]);
                    },
                  ),
              ],
            ),
          );
        },
      ),
      
      const FavoritesScreen(),

      FutureBuilder<UserProfile?>(
        future: ProfileService().getMyProfile(),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError || snap.data == null) {
            return const Center(child: Text('Gagal memuat profil'));
          }
          final p = snap.data!;
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 40,
                backgroundColor: Color.fromARGB(255, 1, 154, 249),
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Nama'),
                subtitle: Text(p.name.isEmpty ? '-' : p.name),
              ),
              ListTile(
                leading: const Icon(Icons.email),
                title: const Text('Email'),
                subtitle: Text(p.email),
              ),
              ListTile(
                leading: const Icon(Icons.badge),
                title: const Text('Role'),
                subtitle: Text(p.role),
              ),
            ],
          );
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Course Explorer v2',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 1, 154, 249),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Logout',
            onPressed: () async {
              await AuthService.instance.logout();
              if (!context.mounted) return;
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 1, 154, 249),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed, 
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile', 
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCourseScreen()),
          );
        },
        backgroundColor: const Color.fromARGB(255, 1, 154, 249),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}