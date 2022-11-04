import 'package:flutter_demo/features/auth/domain/model/credentials.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LoginPresentationModel implements LoginViewModel {
  /// Creates the initial state
  LoginPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    LoginInitialParams initialParams,
  ) : credentials = const Credentials.empty();

  /// Used for the copyWith method
  LoginPresentationModel._({
    required this.credentials,
  });

  final Credentials credentials;

  @override
  bool get isLoginEnabled => credentials.areNotEmpty();

  LoginPresentationModel copyWith({
    Credentials? credentials,
  }) =>
      LoginPresentationModel._(
        credentials: credentials ?? this.credentials,
      );
}

/// Interface to expose fields used by the view (page).
abstract class LoginViewModel {
  bool get isLoginEnabled;
}
