import 'package:equatable/equatable.dart';

class Credentials extends Equatable {
  const Credentials({
    required this.username,
    required this.password,
  });

  const Credentials.empty()
      : username = '',
        password = '';

  final String username;
  final String password;

  @override
  List<Object> get props => [
        username,
        password,
      ];

  Credentials copyWith({
    String? username,
    String? password,
  }) {
    return Credentials(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  bool areNotEmpty() => username.isNotEmpty && password.isNotEmpty;
}
