import 'package:dartz/dartz.dart';
import 'package:educoy_app/features/auth/domain/entities/local_user.dart';
import 'package:educoy_app/features/auth/domain/use_cases/sign_in.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../repositories/auth_repo.mock.dart';

void main() {
  late MockAuthRepo repo;
  late SignIn usecase;

  const tEmail = 'Test email';
  const tPassword = 'Test password';

  setUp(() {
    repo = MockAuthRepo();
    usecase = SignIn(repo);
  });

  final testUser = LocalUser.empty();

  test(
    'should return [LocalUser] from the [AuthRepo]',
    () async {
      when(
        () => repo.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => Right(testUser));

      final result = await usecase(
        const SignInParams(
          email: tEmail,
          password: tPassword,
        ),
      );

      expect(result, Right<dynamic, LocalUser>(testUser));

      verify(
        () => repo.signIn(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);

      verifyNoMoreInteractions(repo);
    },
  );
}
