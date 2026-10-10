// 2415051007 - I Wayan Agus Wredhi Putra
import 'package:flutter/material.dart';
import '../models/course.dart';
import '../repositories/course_repository.dart';
class CourseProvider extends ChangeNotifier {
  final CourseRepository repository;
  CourseProvider(this.repository);
  List<Course> courses = [];
  bool isLoading = false;
  String? error;
  final Set<String> favorites = {};
  int get favoriteCount => favorites.length;
  List<Course> get favoriteCourses {
    return courses.where((course) => favorites.contains(course.code)).toList();
  }
  Future<void> loadCourses() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      courses = await repository.getCourses();
    } catch (e) {
      error = 'Gagal memuat data: ${e.toString()}';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  bool isFavorite(String courseCode) {
    return favorites.contains(courseCode);
  }
  void toggleFavorite(String courseCode) {
    if (favorites.contains(courseCode)) {
      favorites.remove(courseCode);
    } else {
      favorites.add(courseCode);
    }
    notifyListeners();
  }
}