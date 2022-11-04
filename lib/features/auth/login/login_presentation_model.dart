import 'package:dartz/dartz.dart';
import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/features/auth/domain/model/credentials.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LoginPresentationModel implements LoginViewModel {
  /// Creates the initial state
  LoginPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    LoginInitialParams initialParams,
  )   : logInResult = const FutureResult.empty(),
        credentials = const Credentials.empty();

  /// Used for the copyWith method
  LoginPresentationModel._({
    required this.logInResult,
    required this.credentials,
  });

  final FutureResult<Either<LogInFailure, User>> logInResult;
  final Credentials credentials;

  @override
  bool get isLoginEnabled => credentials.areNotEmpty();

  @override
  bool get isLoading => logInResult.isPending();

  LoginPresentationModel copyWith({
    FutureResult<Either<LogInFailure, User>>? logInResult,
    Credentials? credentials,
  }) =>
      LoginPresentationModel._(
        logInResult: logInResult ?? this.logInResult,
        credentials: credentials ?? this.credentials,
      );
}

/// Interface to expose fields used by the view (page).
abstract class LoginViewModel {
  bool get isLoginEnabled;

  bool get isLoading;
}
