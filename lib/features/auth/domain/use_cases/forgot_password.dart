import 'package:educoy_app/core/use_cases/use_cases.dart';
import 'package:educoy_app/core/utils/typedef.dart';
import 'package:educoy_app/features/auth/domain/repositories/auth_repo.dart';

class ForgotPassword extends UsecaseWithParams<void, String> {
  const ForgotPassword(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(String params) => _repo.forgotPassword(params);
}
