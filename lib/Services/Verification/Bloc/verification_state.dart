part of "verification_bloc.dart";

abstract class VerificationState extends Equatable{
  @override
  List<Object?> get props => [];
}
class VerficationInitial extends VerificationState{}
class VerficationLoading extends VerificationState{}
class VerficationEmailCooldown extends VerificationState {}
class VerficationError extends VerificationState {
  final String message;
  VerficationError(this.message);
  @override
  List<Object?> get props => [message];
}
class VerficationEmailSent extends VerificationState {}
class VerficationChecked extends VerificationState {
  final bool isVerified;
  VerficationChecked(this.isVerified);
  @override
  List<Object?> get props => [isVerified];
}
