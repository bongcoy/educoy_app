import 'package:dartz/dartz.dart';
import 'package:educoy_app/core/errors/exceptions.dart';
import 'package:educoy_app/core/errors/failures.dart';
import 'package:educoy_app/features/course/data/data_sources/course_remote_data_source.dart';
import 'package:educoy_app/features/course/data/models/course_model.dart';
import 'package:educoy_app/features/course/data/repositories/course_repo_impl.dart';
import 'package:educoy_app/features/course/domain/entities/course.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCourseRemoteDataSrc extends Mock implements CourseRemoteDataSource {}

void main() {
  late CourseRemoteDataSource remoteDataSrc;
  late CourseRepoImpl repoImpl;

  final tCourse = CourseModel.empty();

  setUp(() {
    remoteDataSrc = MockCourseRemoteDataSrc();
    repoImpl = CourseRepoImpl(remoteDataSrc);
    registerFallbackValue(tCourse);
  });
  const tException = ServerException(
    message: 'Something went wrong',
    statusCode: '500',
  );

  group('addCourse', () {
    test(
      'should complete successfully when call to remote source is successful',
      () async {
        when(() => remoteDataSrc.addCourse(any())).thenAnswer(
          (_) async => Future.value(),
        );
        final result = await repoImpl.addCourse(tCourse);
        expect(result, const Right<dynamic, void>(null));
        verify(() => remoteDataSrc.addCourse(tCourse)).called(1);
        verifyNoMoreInteractions(remoteDataSrc);
      },
    );
    test(
      'should return [ServerFailure] when call to remote source is '
      'unsuccessful',
      () async {
        when(() => remoteDataSrc.addCourse(any())).thenThrow(tException);

        final result = await repoImpl.addCourse(tCourse);
        expect(
          result,
          Left<Failure, void>(ServerFailure.fromException(tException)),
        );

        verify(() => remoteDataSrc.addCourse(tCourse)).called(1);
        verifyNoMoreInteractions(remoteDataSrc);
      },
    );
  });

  group('getCourses', () {
    test(
      'should return [List<Course>] when call to remote source is successful',
      () async {
        when(() => remoteDataSrc.getCourses()).thenAnswer(
          (_) async => [tCourse],
        );

        final result = await repoImpl.getCourses();

        expect(result, isA<Right<dynamic, List<Course>>>());

        verify(() => remoteDataSrc.getCourses()).called(1);
        verifyNoMoreInteractions(remoteDataSrc);
      },
    );

    test(
      'should return [ServerFailure] when call to remote source is '
      'unsuccessful',
      () async {
        when(() => remoteDataSrc.getCourses()).thenThrow(tException);

        final result = await repoImpl.getCourses();

        expect(
          result,
          Left<Failure, dynamic>(ServerFailure.fromException(tException)),
        );

        verify(() => remoteDataSrc.getCourses()).called(1);
        verifyNoMoreInteractions(remoteDataSrc);
      },
    );
  });
}
