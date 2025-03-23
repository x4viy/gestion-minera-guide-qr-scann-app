import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:loadin_guide_scann/src/core/common/app_user/app_user_cubit.dart';
import 'package:loadin_guide_scann/src/core/common/qr_scann/qr_scann_cubit.dart';
import 'package:loadin_guide_scann/src/core/network/api_service.dart';
import 'package:loadin_guide_scann/src/core/network/connection_checker.dart';
import 'package:loadin_guide_scann/src/core/secrets/app_secrets.dart';
import 'package:loadin_guide_scann/src/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:loadin_guide_scann/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:loadin_guide_scann/src/features/auth/domain/repository/auth_repository.dart';
import 'package:loadin_guide_scann/src/features/auth/domain/usecases/current_user.dart';
import 'package:loadin_guide_scann/src/features/auth/domain/usecases/user_login.dart';
import 'package:loadin_guide_scann/src/features/auth/domain/usecases/user_logout.dart';
import 'package:loadin_guide_scann/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:loadin_guide_scann/src/features/home/presentation/bloc/home_page_bloc.dart';

part 'init_dependencies.main.dart';
