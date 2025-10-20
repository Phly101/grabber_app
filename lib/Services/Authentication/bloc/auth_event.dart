part of "auth_bloc.dart";

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String phone;
  final String city;

  SignUpRequested({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.city,
  });

  @override
  List<Object?> get props => [email, password, name, phone, city];
}

final class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

final class SignOutRequested extends AuthEvent {}

final class AppStarted extends AuthEvent {}

final class ForgotPasswordRequested extends AuthEvent {
  final String email;

  ForgotPasswordRequested({required this.email});
}
final class UpdatePasswordRequested extends AuthEvent {
  final String currentEmail;
  final String currentPassword;
  final String newPassword;

  UpdatePasswordRequested({required this.currentEmail, required this.currentPassword, required this.newPassword,});
}
