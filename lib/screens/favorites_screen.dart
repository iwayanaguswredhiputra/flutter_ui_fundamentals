// 2415051007 - I Wayan Agus Wredhi Putra
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';
import '../widgets/course_card.dart';
import '../services/profile_service.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final String studentName = "I Wayan Agus Wredhi Putra";
  final String studentId = "2415051007";
  
  late final Future<UserProfile?> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = ProfileService().getMyProfile();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();
    final favCourses = provider.favoriteCourses;

    return FutureBuilder<UserProfile?>(
      future: _profileFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final p = snapshot.data;
        final userRole = p?.role ?? 'student';

        return Scaffold(
          appBar: AppBar(
            title: const Text('Course Favorit Saya', style: TextStyle(color: Colors.white, fontSize: 16)),
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: const Color.fromARGB(255, 1, 154, 249),
          ),
          body: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                color: Colors.indigo.shade50,
                child: Text(
                  '$studentName - $studentId',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: favCourses.isEmpty
                    ? const Center(
                        child: Text(
                          'Belum ada course favorit.',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: favCourses.length,
                        itemBuilder: (context, index) {
                          return CourseCard(
                            course: favCourses[index],
                            role: userRole, 
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}