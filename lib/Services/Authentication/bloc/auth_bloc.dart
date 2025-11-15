import "package:equatable/equatable.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Services/Authentication/auth_service.dart";
part "auth_event.dart";
part "auth_state.dart";

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  final FirebaseAuth firebaseAuth;

  AuthBloc({
    required this.authService,
    FirebaseAuth? firebaseAuth,
  })  : firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignInRequested>(_onSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<ForgotPasswordRequested>(_onForgotPasswordRequested);
    on<UpdatePasswordRequested>(_onUpdatePasswordRequested);
  }

  Future<void> _onAppStarted(
    AppStarted event,
    Emitter<AuthState> emit,
  ) async {

    final isLoggedIn = await authService.isUserLoggedIn();
    final currentUser = firebaseAuth.currentUser;
    if (isLoggedIn && currentUser != null) {
      emit(AuthAuthenticated(currentUser));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthSignUpLoading());
    final result = await authService.signUp(
      email: event.email,
      password: event.password,
      name: event.name,
      phone: event.phone,
      city: event.city,
    );
    if (result?.isSuccess ?? false) {
      emit(AuthAuthenticated(result!.user!));
    } else {
      emit(AuthError(result?.error ?? "Unknown Error"));
    }
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthSignInLoading());
    final result = await authService.signIn(
      email: event.email,
      password: event.password,
    );
    if (result.isSuccess) {
      await authService.saveUserLocally(result.user!);
      emit(AuthAuthenticated(result.user!));
    } else {
      emit(AuthError(result.error ?? "Unknown error"));
    }
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthSignOutLoading());
      await authService.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError("Failed to sign out: $e"));
    }
  }

  Future<void> _onForgotPasswordRequested(
      ForgotPasswordRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthForgotPasswordLoading());

    try {
      final result = await authService.forgotPassword(event.email);

      if (result.error != null) {

        emit(AuthError(result.error!));
      } else {

        emit(AuthForgotPassword());
      }
    } catch (e) {

      emit(AuthError("Failed to send password reset request"));
    }
  }
  Future<void> _onUpdatePasswordRequested(
      UpdatePasswordRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthUpdatePasswordLoading());

    try {
      final result = await authService.updatePassword(newPassword: event.newPassword, currentPassword: event.currentPassword);

      if (result.error != null) {

        emit(AuthError(result.error!));
      } else {

        emit(AuthUpdatePassword(message: result.message ?? "Password changed successfully"));
      }
    } catch (e) {

      emit(AuthError("Failed to Update password."));
    }
  }
}
