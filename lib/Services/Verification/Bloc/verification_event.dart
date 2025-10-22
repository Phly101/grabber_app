// ignore: prefer_double_quotes
part of 'verification_bloc.dart';

// @immutable
// sealed class VerficationEvent {}

abstract class VerificationEvent extends Equatable{
  @override
  List<Object?> get props => [];
}
class SendVerificationEmail extends VerificationEvent{}
class CheckEmailVerification  extends VerificationEvent{}
class StartAutoCheck extends VerificationEvent {}
class StopAutoCheck extends VerificationEvent {}