import "package:bloc_test/bloc_test.dart";
import "package:flutter_test/flutter_test.dart";
import "package:grabber_app/Services/Verification/Bloc/verification_bloc.dart";
import "package:grabber_app/Services/Verification/verification_service.dart";
import "package:mocktail/mocktail.dart";

class MockVerificationService extends Mock implements VerificationService{}
void main(){
  late VerificationBloc verificationBloc;
  late MockVerificationService mockService;
  setUp((){
    mockService = MockVerificationService();
    verificationBloc = VerificationBloc(mockService);
  });
  tearDown((){
    verificationBloc.close();
  });
  group("VerificationBloc Tests",(){
    blocTest<VerificationBloc, VerificationState>(
      "emits [Loading, EmailSent, EmailCooldown, Initial] when SendVerificationEmail succeeds",
      build: () {
        when(() => mockService.sendEmailVerification()).thenAnswer((_) async {});
        return verificationBloc;
      },
      act: (bloc) => bloc.add(SendVerificationEmail()),
      wait: const Duration(seconds: 11),
      expect: () => [
        isA<VerificationLoading>(),
        isA<VerificationEmailSent>(),
        isA<VerificationEmailCooldown>(),
        isA<VerificationInitial>(),
      ],
    );
    blocTest<VerificationBloc, VerificationState>(
      "emits [Loading, Error] when SendVerificationEmail throws",
      build: () {
        when(() => mockService.sendEmailVerification())
            .thenThrow(Exception("Failed to send"));
        return verificationBloc;
      },
      act: (bloc) => bloc.add(SendVerificationEmail()),
      expect: () => [
        isA<VerificationLoading>(),
        predicate<VerificationError>((state) => state.message.contains("Failed to send")),
      ],
    );
    blocTest<VerificationBloc, VerificationState>(
      "emits [Loading, Checked(true)] when CheckEmailVerification returns true",
      build: () {
        when(() => mockService.checkEmailVerified()).thenAnswer((_) async => true);
        return verificationBloc;
      },
      act: (bloc) => bloc.add(CheckEmailVerification()),
      expect: () => [
        isA<VerificationLoading>(),
        VerificationChecked(true),
      ],
    );
    blocTest<VerificationBloc, VerificationState>(
      "emits [Loading, Checked(false)] when CheckEmailVerification returns false",
      build: () {
        when(() => mockService.checkEmailVerified()).thenAnswer((_) async => false);
        return verificationBloc;
      },
      act: (bloc) => bloc.add(CheckEmailVerification()),
      expect: () => [
        isA<VerificationLoading>(),
        VerificationChecked(false),
      ],
    );
  });
}