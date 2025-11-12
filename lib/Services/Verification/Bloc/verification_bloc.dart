import "dart:async";


import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Services/Verification/verification_service.dart";

part "verification_event.dart";
part "verification_state.dart";

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  final VerificationService _verificationService;
  Timer? _timer; // Timer for polling
  VerificationBloc(this._verificationService) : super(VerificationInitial()) {
    on<SendVerificationEmail>(_onSendVerificationEmail);
    on<CheckEmailVerification>(_onCheckEmailVerification);
    on<StartAutoCheck>(_onStartAutoCheck);
    on<StopAutoCheck>(_onStopAutoCheck);
  }

  Future<void> _onSendVerificationEmail(
      SendVerificationEmail event,
      Emitter<VerificationState> emit,
      ) async {
    emit(VerificationLoading());
    try {
      await _verificationService.sendEmailVerification();
      emit(VerificationEmailSent());
      emit(VerificationEmailCooldown());
      await Future.delayed(const Duration(seconds: 10));
      emit(VerificationInitial()); // b3d 10 sec the button will reappear
    } catch (e) {
      emit(VerificationError(e.toString()));
    }
  }


  Future<void> _onCheckEmailVerification(
      CheckEmailVerification event,
      Emitter<VerificationState> emit
      ) async {
    emit(VerificationLoading());
    try {
      final isVerified = await _verificationService.checkEmailVerified();
      emit(VerificationChecked(isVerified));
    } catch (e) {
      emit(VerificationError(e.toString()));
    }
  }

  Future<void> _onStartAutoCheck(
      StartAutoCheck event,
      Emitter<VerificationState> emit
      ) async {
    if (_timer != null) return; // Prevent multiple timers
    emit(VerificationLoading()); // Indicate polling is starting
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      add(CheckEmailVerification()); // Trigger verification check
      if (state is VerificationChecked && (state as VerificationChecked).isVerified) {
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
    emit(VerificationInitial());
  }
}

