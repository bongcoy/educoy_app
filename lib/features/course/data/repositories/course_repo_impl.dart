import 'package:dartz/dartz.dart';
import 'package:educoy_app/core/errors/exceptions.dart';
import 'package:educoy_app/core/errors/failures.dart';
import 'package:educoy_app/core/utils/typedef.dart';
import 'package:educoy_app/features/course/data/data_sources/course_remote_data_source.dart';
import 'package:educoy_app/features/course/domain/entities/course.dart';
import 'package:educoy_app/features/course/domain/repositories/course_repo.dart';

class CourseRepoImpl implements CourseRepo {
  const CourseRepoImpl(this._remoteDataSrc);

  final CourseRemoteDataSource _remoteDataSrc;

  @override
  ResultFuture<void> addCourse(Course course) async {
    try {
      await _remoteDataSrc.addCourse(course);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Course>> getCourses() async {
    try {
      final courses = await _remoteDataSrc.getCourses();
      return Right(courses);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
