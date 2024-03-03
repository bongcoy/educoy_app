import 'package:educoy_app/core/errors/exceptions.dart';
import 'package:educoy_app/features/on_boarding/data/data_sources/on_boarding_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockOnBoardingLocalDataSource extends Mock
    implements OnBoardingLocalDataSource {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences sharedPreferences;
  late OnBoardingLocalDataSource dataSource;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    dataSource = OnBoardingLocalDSImpl(sharedPreferences);
  });

  group('cacheFirstTimer', () {
    test('should call [SharedPreferences] to create cache', () async {
      // 1. Arrange
      when(() => sharedPreferences.setBool(any(), any())).thenAnswer(
        (_) async => true,
      );
      // 2. Act
      await dataSource.cacheFirstTimer();
      // 3. Assert
      verify(
        () => sharedPreferences.setBool(
          keySharedPreferences,
          // we set to false to check the not-first-timer user
          false,
        ),
      ).called(1);
      // make sure that we don't have interactions with the dependencies
      verifyNoMoreInteractions(sharedPreferences);

      // check if actually saved
      // final result = sharedPreferences.getBool(keySharedPreferences);
      // expect(result, equals(false));

      // Test-Driven Development (TDD) is a coding principle that emphasizes
      // writing test cases before features. TDD involves building a test first
      // and then creating features based on the test results.
    });
    test(
      'should throw a [CacheException] when error caching data',
      () async {
        // 1. Arrange
        when(() => sharedPreferences.setBool(any(), any())).thenThrow(
          const CacheException(message: 'message'),
        );
        // 2. Act
        final methodCallResult = dataSource.cacheFirstTimer;
        // 3. Assert
        expect(
          methodCallResult,
          throwsA(isA<CacheException>()),
        );
        verify(
          () => sharedPreferences.setBool(
            keySharedPreferences,
            false,
          ),
        ).called(1);
        // make sure that we don't have interactions with the dependencies
        verifyNoMoreInteractions(sharedPreferences);

        // Test-Driven Development (TDD) is a coding principle that emphasizes
        // writing test cases before features. TDD involves building a test first
        // and then creating features based on the test results.
      },
    );
  });

  group('checkIfFirstTimer', () {
    test('should call [SharedPreferences] to check first timer '
        'and return the right data when exist', () async {
      // 1. Arrange
      when(() => sharedPreferences.getBool(any())).thenReturn(false);
      // 2. Act
      final result = await dataSource.checkIfFirstTimer();
      // 3. Assert
      expect(result, equals(false));
      verify(
            () => sharedPreferences.getBool(keySharedPreferences),
      ).called(1);
      // make sure that we don't have interactions with the dependencies
      verifyNoMoreInteractions(sharedPreferences);


      // Test-Driven Development (TDD) is a coding principle that emphasizes
      // writing test cases before features. TDD involves building a test first
      // and then creating features based on the test results.
    });
    test(
      'should throw a [CacheException] when error caching data',
          () async {
        // 1. Arrange
        when(() => sharedPreferences.getBool(keySharedPreferences)).thenThrow(
          const CacheException(message: 'message'),
        );
        // 2. Act
        final methodCallResult = dataSource.checkIfFirstTimer();
        // 3. Assert
        expect(
          methodCallResult,
          throwsA(isA<CacheException>()),
        );
        verify(
              () => sharedPreferences.getBool(keySharedPreferences),
        ).called(1);
        // make sure that we don't have interactions with the dependencies
        verifyNoMoreInteractions(sharedPreferences);

        // Test-Driven Development (TDD) is a coding principle that emphasizes
        // writing test cases before features. TDD involves building a test first
        // and then creating features based on the test results.
      },
    );
  });
}
