import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pedidos/src/core/common/app_user/app_user_cubit.dart';
import 'package:pedidos/src/core/network/api_service.dart';
import 'package:pedidos/src/core/network/connection_checker.dart';
import 'package:pedidos/src/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:pedidos/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:pedidos/src/features/auth/domain/repository/auth_repository.dart';
import 'package:pedidos/src/features/auth/domain/usecases/current_user.dart';
import 'package:pedidos/src/features/auth/domain/usecases/user_login.dart';
import 'package:pedidos/src/features/auth/presentation/bloc/auth_bloc.dart';

part 'init_dependencies.main.dart';
