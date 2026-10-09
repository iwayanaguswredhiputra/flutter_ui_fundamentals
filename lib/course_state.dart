import 'package:flutter/material.dart';
//2415051007 - I Wayan Agus Wredhi Putra
class CourseState extends ChangeNotifier {
  final Set<String> _favorites = {};
  Set<String> get favorites => _favorites;
  int get favoriteCount => _favorites.length;
  bool isFavorite(String courseTitle) {
    return _favorites.contains(courseTitle);
  }
  void toggleFavorite(String courseTitle) {
    if (_favorites.contains(courseTitle)) {
      _favorites.remove(courseTitle);
    } else {
      _favorites.add(courseTitle);
    }
    notifyListeners();
  }
}