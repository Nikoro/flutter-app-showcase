import 'package:bloc/bloc.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';

class LoginPresenter extends Cubit<LoginViewModel> {
  LoginPresenter(
    LoginPresentationModel super.model,
    this.navigator,
    this.logInUseCase,
  );

  final LoginNavigator navigator;
  final LogInUseCase logInUseCase;

  // ignore: unused_element
  LoginPresentationModel get _model => state as LoginPresentationModel;

  void onUsernameChanged(String username) {
    emit(_model.copyWith(credentials: _model.credentials.copyWith(username: username)));
  }

  void onPasswordChanged(String password) {
    emit(_model.copyWith(credentials: _model.credentials.copyWith(password: password)));
  }

  Future<void> onLoginButtonPressed() async {
    final credentials = _model.credentials;
    await logInUseCase
        .execute(
          username: credentials.username,
          password: credentials.password,
        )
        .observeStatusChanges((result) => emit(_model.copyWith(logInResult: result)));
  }
}
