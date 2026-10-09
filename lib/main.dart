import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'repositories/course_repository.dart';
import 'services/course_service.dart';
import 'providers/course_provider.dart';
void main() {
  final courseService = CourseService();
  final courseRepository = CourseRepository(courseService);
  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseProvider(courseRepository)..loadCourses(),
      child: const CourseExplorerApp(),
    ),
  );
}
class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pertemuan 6 - Tahap 11',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const CourseExplorerScreen(),
    );
  }
}
class CourseExplorerScreen extends StatelessWidget {
  const CourseExplorerScreen({super.key});
  final String studentName = "I Wayan Agus Wredhi Putra";
  final String studentId = "2415051007";
  @override
  Widget build(BuildContext context) {
    final providerWatch = context.watch<CourseProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'P06: Tahap 11 - Async State Management',
          style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 1, 154, 249),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: Colors.indigo.shade50,
            child: Column(
              children: [
                Text(
                  studentName,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  'NIM: $studentId',
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.amber.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Course Favorit:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Chip(
                  avatar: const Icon(Icons.favorite, color: Colors.red, size: 18),
                  label: Text(
                    '${providerWatch.favoriteCount} Item',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          //2415051007 - I Wayan Agus Wredhi Putra
          Expanded(
            child: Builder(
              builder: (context) {
                if (providerWatch.isLoading) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 12),
                        Text('Memuat data mata kuliah...'),
                      ],
                    ),
                  );
                }
                if (providerWatch.error != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, color: Colors.red, size: 48),
                        const SizedBox(height: 12),
                        Text(
                          providerWatch.error!,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            context.read<CourseProvider>().loadCourses();
                          },
                          child: const Text('Coba Lagi'),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: providerWatch.courses.length,
                  itemBuilder: (context, index) {
                    final course = providerWatch.courses[index];
                    return Consumer<CourseProvider>(
                      builder: (context, provider, child) {
                        final isFav = provider.isFavorite(course.code);
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          child: ListTile(
                            title: Text('${course.title} (${course.code})'),
                            subtitle: Text('${course.credits} SKS | Status: ${course.status}'),
                            trailing: IconButton(
                              icon: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: isFav ? Colors.red : Colors.grey,
                              ),
                              onPressed: () {
                                context.read<CourseProvider>().toggleFavorite(course.code);
                              },
                            ),
                          ),
                        );
                      },
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