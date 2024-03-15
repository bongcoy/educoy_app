import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educoy_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:educoy_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:educoy_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:educoy_app/features/auth/domain/use_cases/forgot_password.dart';
import 'package:educoy_app/features/auth/domain/use_cases/sign_in.dart';
import 'package:educoy_app/features/auth/domain/use_cases/sign_up.dart';
import 'package:educoy_app/features/auth/domain/use_cases/update_user.dart';
import 'package:educoy_app/features/auth/presentation/manager/auth_bloc.dart';
import 'package:educoy_app/features/on_boarding/data/data_sources/on_boarding_local_data_source.dart';
import 'package:educoy_app/features/on_boarding/data/repositories/on_boarding_repo_impl.dart';
import 'package:educoy_app/features/on_boarding/domain/repositories/on_boarding_repo.dart';
import 'package:educoy_app/features/on_boarding/domain/use_cases/cache_first_timer.dart';
import 'package:educoy_app/features/on_boarding/domain/use_cases/check_if_first_timer.dart';
import 'package:educoy_app/features/on_boarding/presentation/manager/on_boarding_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'injection_container.main.dart';
