part of "auth_bloc.dart";

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];

}

final class AuthInitial extends AuthState {}

final class AuthStart extends AuthState {}

final class AuthLoading extends AuthState {}


final class AuthSignInLoading extends AuthState {}

final class AuthSignOutLoading extends AuthState {}


final class AuthSignUpLoading extends AuthState {}
final class AuthUpdatePasswordLoading extends AuthState {}


final class AuthForgotPasswordLoading extends AuthState {}

final class AuthAuthenticated extends AuthState {
  final User user;

  AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

final class AuthError extends AuthState {
  final String error;

  AuthError(this.error);

  @override
  List<Object?> get props => [error];
}

final class AuthForgotPassword extends AuthState {}
final class AuthUpdatePassword extends AuthState{
  final String message;

  AuthUpdatePassword({this.message = "Password changed successfully"});

  @override
  List<Object?> get props => [message];
}

