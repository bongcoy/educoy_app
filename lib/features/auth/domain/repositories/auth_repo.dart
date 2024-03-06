import 'package:educoy_app/core/enums/update_user_action.dart';
import 'package:educoy_app/core/utils/typedef.dart';
import 'package:educoy_app/features/auth/domain/entities/local_user.dart';

abstract class AuthRepo {
  ResultFuture<void> forgotPassword(String email);

  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  });

  ResultFuture<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });
}
