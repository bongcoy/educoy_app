import 'package:educoy_app/core/utils/typedef.dart';
import 'package:educoy_app/features/course/domain/entities/course.dart';

abstract class CourseRepo {
  const CourseRepo();

  ResultFuture<List<Course>> getCourses();

  ResultFuture<void> addCourse(Course course);
}
