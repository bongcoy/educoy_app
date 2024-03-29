import 'package:educoy_app/core/common/views/under_construction_page.dart';
import 'package:educoy_app/core/extensions/context_extension.dart';
import 'package:educoy_app/core/services/injection_container.dart';
import 'package:educoy_app/features/auth/data/models/local_user_model.dart';
import 'package:educoy_app/features/auth/presentation/manager/auth_bloc.dart';
import 'package:educoy_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:educoy_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:educoy_app/features/home/presentation/pages/home_page.dart';
import 'package:educoy_app/features/on_boarding/data/data_sources/on_boarding_local_data_source.dart';
import 'package:educoy_app/features/on_boarding/presentation/manager/on_boarding_cubit.dart';
import 'package:educoy_app/features/on_boarding/presentation/pages/on_boarding_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as fui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'router.main.dart';
