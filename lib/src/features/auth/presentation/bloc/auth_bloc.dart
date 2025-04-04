import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadin_guide_scann/src/core/common/app_user/app_user_cubit.dart';
import 'package:loadin_guide_scann/src/core/common/entities/user.dart';
import 'package:loadin_guide_scann/src/core/usecase/usecase.dart';
import 'package:loadin_guide_scann/src/core/utils/constants/variables_constat.dart';
import 'package:loadin_guide_scann/src/features/auth/domain/usecases/current_user.dart';
import 'package:loadin_guide_scann/src/features/auth/domain/usecases/user_login.dart';
import 'package:loadin_guide_scann/src/features/auth/domain/usecases/user_logout.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLogin _userLogin;
  final UserLogout _userLogout;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserLogin userLogin,
    required UserLogout userLogout,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userLogin = userLogin,
        _userLogout = userLogout,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
    on<AuthLogin>(_onAuthLogin);
    on<AuthLoggedOut>(_onAuthLogOut);
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());

    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _onAuthLogin(
    AuthLogin event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userLogin(
      UserLoginParams(
        ci: event.ci,
        password: event.password,
      ),
    );

    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _emitAuthSuccess(
    User user,
    Emitter<AuthState> emit,
  ) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }

  void _onAuthLogOut(
    AuthLoggedOut event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userLogout(NoParams());

    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => emit(AuthUnauthenticated()),
    );
  }
}
