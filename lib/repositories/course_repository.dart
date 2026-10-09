// 2415051007 - I Wayan Agus Wredhi Putra
import '../models/course.dart';
import '../services/course_service.dart';
class CourseRepository {
  final CourseService service;
  CourseRepository(this.service);
  Future<List<Course>> getCourses() {
    return service.loadCourses();
  }
}