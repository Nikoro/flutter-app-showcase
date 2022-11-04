import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/features/auth/login/login_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utils/test_utils.dart';
import '../mocks/auth_mock_definitions.dart';
import '../mocks/auth_mocks.dart';

void main() {
  late LoginPresentationModel model;
  late LoginPresenter presenter;
  late MockLoginNavigator navigator;

  T anyTitle<T>() => any(named: 'title');
  T anyMessage<T>() => any(named: 'message');
  T anyUsername<T>() => any(named: 'username');
  T anyPassword<T>() => any(named: 'password');

  test(
    'should show error when logInUseCase fails',
    () async {
      // GIVEN
      when(
        () => AuthMocks.logInUseCase.execute(
          username: anyUsername(),
          password: anyPassword(),
        ),
      ).thenAnswer((_) => failFuture(const LogInFailure.unknown()));
      when(() => navigator.showError(any())).thenAnswer((_) async => {});

      // WHEN
      await presenter.onLoginButtonPressed();

      // THEN
      verify(() => navigator.showError(any()));
    },
  );

  test(
    'should show success when logInUseCase returns [User]',
    () async {
      // GIVEN
      when(
        () => AuthMocks.logInUseCase.execute(
          username: anyUsername(),
          password: anyPassword(),
        ),
      ).thenAnswer((_) => successFuture(const User.empty()));
      when(
        () => navigator.showAlert(
          title: anyTitle(),
          message: anyMessage(),
        ),
      ).thenAnswer((_) async => {});

      // WHEN
      await presenter.onLoginButtonPressed();

      // THEN
      verify(
        () => navigator.showAlert(
          title: anyTitle(),
          message: anyMessage(),
        ),
      );
    },
  );

  setUp(() {
    model = LoginPresentationModel.initial(const LoginInitialParams());
    navigator = MockLoginNavigator();
    presenter = LoginPresenter(
      model,
      navigator,
      AuthMocks.logInUseCase,
    );
  });
}
