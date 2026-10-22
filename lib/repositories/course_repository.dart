// 2415051007 - I Wayan Agus Wredhi Putra
import '../models/course.dart';
import '../services/course_data_source.dart';

class CourseRepository {
  final CourseDataSource dataSource;
  CourseRepository(this.dataSource);
  Future<List<Course>> getCourses() async {
    return await dataSource.getCourses();
  }
  Future<Course> createCourse(Course course) async {
    return await dataSource.createCourse(course);
  }
  Future<Course> updateCourse(int id, Course course) async {
    return await dataSource.updateCourse(id, course);
  }
  Future<void> deleteCourse(int id) async {
    return await dataSource.deleteCourse(id);
  }
}