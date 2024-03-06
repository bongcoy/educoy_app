import 'package:educoy_app/core/enums/update_user_action.dart';
import 'package:educoy_app/core/use_cases/use_cases.dart';
import 'package:educoy_app/core/utils/typedef.dart';
import 'package:educoy_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:equatable/equatable.dart';

class UpdateUser extends UsecaseWithParams<void, UpdateUserParams> {
  const UpdateUser(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(UpdateUserParams params) => _repo.updateUser(
        action: params.action,
        userData: params.userData,
      );
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({required this.action, required this.userData});

  const UpdateUserParams.empty()
      : this(action: UpdateUserAction.displayName, userData: '');

  final UpdateUserAction action;
  final dynamic userData;

  @override
  List<dynamic> get props => [action, userData];
}
