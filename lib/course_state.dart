// 2415051007 - I Wayan Agus Wredhi Putra
import 'package:flutter/material.dart';
import 'models/course.dart';
import 'repositories/course_repository.dart';
class CourseState extends ChangeNotifier {
  final CourseRepository _repository;
  CourseState(this._repository);
  List<Course> _courses = [];
  final Set<String> _favorites = {};
  bool _isLoading = false;
  List<Course> get courses => _courses;
  Set<String> get favorites => _favorites;
  int get favoriteCount => _favorites.length;
  bool get isLoading => _isLoading;
  Future<void> fetchCourses() async {
    _isLoading = true;
    notifyListeners();
    try {
      _courses = await _repository.getCourses();
    } catch (e) {
      debugPrint('Error loading courses: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  bool isFavorite(String courseCode) {
    return _favorites.contains(courseCode);
  }
  void toggleFavorite(String courseCode) {
    if (_favorites.contains(courseCode)) {
      _favorites.remove(courseCode);
    } else {
      _favorites.add(courseCode);
    }
    notifyListeners();
  }
}