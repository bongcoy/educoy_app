import 'package:educoy_app/core/use_cases/use_cases.dart';
import 'package:educoy_app/core/utils/typedef.dart';
import 'package:educoy_app/features/auth/domain/entities/local_user.dart';
import 'package:educoy_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:equatable/equatable.dart';

class SignIn extends UsecaseWithParams<LocalUser, SignInParams> {
  const SignIn(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<LocalUser> call(SignInParams params) => _repo.signIn(
        email: params.email,
        password: params.password,
      );
}

class SignInParams extends Equatable {
  const SignInParams({
    required this.email,
    required this.password,
  });

  const SignInParams.empty()
      : this(
          email: '',
          password: '',
        );

  final String email;
  final String password;

  @override
  List<String> get props => [email, password];
}
