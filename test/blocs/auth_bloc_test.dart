import "package:bloc_test/bloc_test.dart";
import "package:flutter_test/flutter_test.dart";
import "package:grabber_app/Services/Authentication/bloc/auth_bloc.dart";
import "package:mocktail/mocktail.dart";
import "package:grabber_app/Services/Authentication/auth_service.dart";
import "package:firebase_auth/firebase_auth.dart";

// Mock Classes
class MockAuthService extends Mock implements AuthService {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

void main() {
  late AuthBloc authBloc;
  late MockAuthService mockAuthService;
  late MockUser mockUser;
  late MockFirebaseAuth mockFirebaseAuth;

  setUp(() {
    mockAuthService = MockAuthService();
    mockUser = MockUser();
    mockFirebaseAuth = MockFirebaseAuth();
    authBloc = AuthBloc(
      authService: mockAuthService,
      firebaseAuth: mockFirebaseAuth,
    );
  });

  tearDown(() async {
    await authBloc.close();
  });

  group("AuthBloc Tests", () {
    // AppStarted
    blocTest<AuthBloc, AuthState>(
      "emits [AuthAuthenticated] when user is logged in",
      build: () {
        when(
          () => mockAuthService.isUserLoggedIn(),
        ).thenAnswer((_) async => true);

        when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);

        return authBloc;
      },
      act: (bloc) => bloc.add(AppStarted()),
      expect: () => [isA<AuthAuthenticated>()],
    );

    blocTest<AuthBloc, AuthState>(
      "emits [AuthUnauthenticated] when user is not logged in",
      build: () {
        when(
          () => mockAuthService.isUserLoggedIn(),
        ).thenAnswer((_) async => false);

        when(() => mockFirebaseAuth.currentUser).thenReturn(null);

        return authBloc;
      },
      act: (bloc) => bloc.add(AppStarted()),
      expect: () => [isA<AuthUnauthenticated>()],
    );

    //  SignInRequested
    blocTest<AuthBloc, AuthState>(
      "emits [AuthSignInLoading, AuthAuthenticated] on successful sign in",
      build: () {
        when(
          () => mockAuthService.signIn(
            email: any(named: "email"),
            password: any(named: "password"),
          ),
        ).thenAnswer((_) async => AuthResult(user: mockUser));

        when(
          () => mockAuthService.saveUserLocally(mockUser),
        ).thenAnswer((_) async => {});
        return authBloc;
      },
      act: (bloc) => bloc.add(
        SignInRequested(email: "test@test.com", password: "123456"),
      ),
      expect: () => [isA<AuthSignInLoading>(), isA<AuthAuthenticated>()],
    );

    blocTest<AuthBloc, AuthState>(
      "emits [AuthSignInLoading, AuthError] on failed sign in",
      build: () {
        when(
          () => mockAuthService.signIn(
            email: any(named: "email"),
            password: any(named: "password"),
          ),
        ).thenAnswer((_) async => AuthResult(error: "Invalid credentials"));
        return authBloc;
      },
      act: (bloc) => bloc.add(
        SignInRequested(email: "wrong@test.com", password: "wrong"),
      ),
      expect: () => [
        isA<AuthSignInLoading>(),
        isA<AuthError>().having((e) => e.error, "message", contains("Invalid")),
      ],
    );

    //  SignUpRequested
    blocTest<AuthBloc, AuthState>(
      "emits [AuthSignUpLoading, AuthAuthenticated] on successful sign up",
      build: () {
        when(
          () => mockAuthService.signUp(
            email: any(named: "email"),
            password: any(named: "password"),
            name: any(named: "name"),
            phone: any(named: "phone"),
            city: any(named: "city"),
          ),
        ).thenAnswer((_) async => AuthResult(user: mockUser));

        when(
          () => mockAuthService.saveUserLocally(mockUser),
        ).thenAnswer((_) async => {});
        return authBloc;
      },
      act: (bloc) => bloc.add(
        SignUpRequested(
          email: "new@user.com",
          password: "password",
          name: "New User",
          phone: "123456789",
          city: "Cairo",
        ),
      ),
      expect: () => [isA<AuthSignUpLoading>(), isA<AuthAuthenticated>()],
    );

    blocTest<AuthBloc, AuthState>(
      "emits [AuthSignUpLoading, AuthError] on failed sign up",
      build: () {
        when(
          () => mockAuthService.signUp(
            email: any(named: "email"),
            password: any(named: "password"),
            name: any(named: "name"),
            phone: any(named: "phone"),
            city: any(named: "city"),
          ),
        ).thenAnswer((_) async => AuthResult(error: "Email already exists"));
        return authBloc;
      },
      act: (bloc) => bloc.add(
        SignUpRequested(
          email: "existing@user.com",
          password: "123456",
          name: "Existing",
          phone: "000000",
          city: "Giza",
        ),
      ),
      expect: () => [
        isA<AuthSignUpLoading>(),
        isA<AuthError>().having((e) => e.error, "message", contains("exists")),
      ],
    );

    //  SignOutRequested
    blocTest<AuthBloc, AuthState>(
      "emits [AuthSignOutLoading, AuthUnauthenticated] on successful sign out",
      build: () {
        when(() => mockAuthService.signOut()).thenAnswer((_) async => {});
        return authBloc;
      },
      act: (bloc) => bloc.add(SignOutRequested()),
      expect: () => [isA<AuthSignOutLoading>(), isA<AuthUnauthenticated>()],
    );

    //  ForgotPasswordRequested
    blocTest<AuthBloc, AuthState>(
      "emits [AuthForgotPasswordLoading, AuthForgotPassword] when password reset succeeds",
      build: () {
        when(
          () => mockAuthService.forgotPassword(any()),
        ).thenAnswer((_) async => AuthResult(message: "Email sent"));
        return authBloc;
      },
      act: (bloc) => bloc.add(ForgotPasswordRequested(email: "test@test.com")),
      expect: () => [
        isA<AuthForgotPasswordLoading>(),
        isA<AuthForgotPassword>(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      "emits [AuthForgotPasswordLoading, AuthError] when password reset fails",
      build: () {
        when(
          () => mockAuthService.forgotPassword(any()),
        ).thenAnswer((_) async => AuthResult(error: "No such user"));
        return authBloc;
      },
      act: (bloc) => bloc.add(ForgotPasswordRequested(email: "fail@test.com")),
      expect: () => [
        isA<AuthForgotPasswordLoading>(),
        isA<AuthError>().having((e) => e.error, "message", contains("No such")),
      ],
    );

    //  UpdatePasswordRequested
    blocTest<AuthBloc, AuthState>(
      "emits [AuthUpdatePasswordLoading, AuthUpdatePassword] on successful password update",
      build: () {
        when(
          () => mockAuthService.updatePassword(
            newPassword: any(named: "newPassword"),
            currentPassword: any(named: "currentPassword"),
          ),
        ).thenAnswer(
          (_) async => AuthResult(message: "Password changed successfully"),
        );
        return authBloc;
      },
      act: (bloc) => bloc.add(
        UpdatePasswordRequested(
          currentEmail: "currentEmail@User.com",
          currentPassword: "oldpass",
          newPassword: "newpass",
        ),
      ),
      expect: () => [
        isA<AuthUpdatePasswordLoading>(),
        isA<AuthUpdatePassword>(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      "emits [AuthUpdatePasswordLoading, AuthError] on failed password update",
      build: () {
        when(
          () => mockAuthService.updatePassword(
            newPassword: any(named: "newPassword"),
            currentPassword: any(named: "currentPassword"),
          ),
        ).thenAnswer((_) async => AuthResult(error: "Wrong current password"));
        return authBloc;
      },
      act: (bloc) => bloc.add(
        UpdatePasswordRequested(
          currentEmail: "currentEmail@User.com",
          currentPassword: "wrong",
          newPassword: "newpass",
        ),
      ),
      expect: () => [
        isA<AuthUpdatePasswordLoading>(),
        isA<AuthError>().having((e) => e.error, "message", contains("Wrong")),
      ],
    );
  });
}
