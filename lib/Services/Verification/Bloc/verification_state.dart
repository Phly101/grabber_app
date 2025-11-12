part of "verification_bloc.dart";

abstract class VerificationState extends Equatable{
  @override
  List<Object?> get props => [];
}
class VerificationInitial extends VerificationState{}
class VerificationLoading extends VerificationState{}
class VerificationEmailCooldown extends VerificationState {}
class VerificationError extends VerificationState {
  final String message;
  VerificationError(this.message);
  @override
  List<Object?> get props => [message];
}
class VerificationEmailSent extends VerificationState {}
class VerificationChecked extends VerificationState {
  final bool isVerified;
  VerificationChecked(this.isVerified);
  @override
  List<Object?> get props => [isVerified];
}
