import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Explorer - Tahap 1',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CourseExplorerApp(),
    );
  }
}
class CourseExplorerApp extends StatefulWidget {
  const CourseExplorerApp({super.key});

  @override
  State<CourseExplorerApp> createState() => _CourseExplorerAppState();
}
class _CourseExplorerAppState extends State<CourseExplorerApp> {
  int _selectedIndex = 0; 
  bool _isFavorite = false; 
  final String studentName = 'I Wayan Agus Wredhi Putra';
  final String studentId = '2415051007';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local State - Course Explorer'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$studentName\n($studentId)',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            const Text('Local State : Toggle Favorite'),
            IconButton(
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.red : Colors.grey,
                size: 50,
              ),
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
            ),
            Text(_isFavorite ? 'Status: Favorit' : 'Status: Belum Favorit'),
            const SizedBox(height: 40),
            Text('Tab Aktif (Local State): $_selectedIndex'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Courses'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}