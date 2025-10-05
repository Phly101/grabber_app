import "dart:async";

import 'package:bloc/bloc.dart';
import "package:equatable/equatable.dart";
import "package:grabber_app/Services/Verification/verification_service.dart";
import 'package:meta/meta.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  final VerificationService _verificationService;
  Timer? _timer; // Timer for polling
  VerificationBloc(this._verificationService) : super(VerficationInitial()) {
    on<SendVerificationEmail>(_onSendVerficationEmail);
    on<CheckEmailVerification>(_onCheckEmailVerfication);
    on<StartAutoCheck>(_onStartAutoCheck);
    on<StopAutoCheck>(_onStopAutoCheck);
  }

  // Future<void> _onSendVerficationEmail(
  //     SendVerificationEmail event,
  //     Emitter<VerificationState> emit,
  //     ) async {
  //   emit(VerficationLoading());
  //   try {
  //     await _verificationService.sendEmailVerification();
  //     emit(VerficationEmailSent());
  //   } catch (e) {
  //     emit(VerficationError(e.toString()));
  //   }
  // }
  Future<void> _onSendVerficationEmail(
      SendVerificationEmail event,
      Emitter<VerificationState> emit,
      ) async {
    emit(VerficationLoading());
    try {
      await _verificationService.sendEmailVerification();
      emit(VerficationEmailSent());
      emit(VerficationEmailCooldown());
      await Future.delayed(const Duration(seconds: 10));
      emit(VerficationInitial()); // After 10 seconds the button will reappear.
    } catch (e) {
      emit(VerficationError(e.toString()));
    }
  }


  Future<void> _onCheckEmailVerfication(
      CheckEmailVerification event,
      Emitter<VerificationState> emit
      ) async {
    emit(VerficationLoading());
    try {
      final isVerified = await _verificationService.checkEmailVerified();
      emit(VerficationChecked(isVerified));
    } catch (e) {
      emit(VerficationError(e.toString()));
    }
  }

  Future<void> _onStartAutoCheck(
      StartAutoCheck event,
      Emitter<VerificationState> emit
      ) async {
    if (_timer != null) return; // Prevent multiple timers
    emit(VerficationLoading()); // Indicate polling is starting
    _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      add(CheckEmailVerification()); // Trigger verification check
      if (state is VerficationChecked && (state as VerficationChecked).isVerified) {
        timer.cancel();
        _timer = null; // Clear timer
      }
    });
  }

  Future<void> _onStopAutoCheck(
      StopAutoCheck event,
      Emitter<VerificationState> emit
      ) async {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    emit(VerficationInitial());
  }
}

