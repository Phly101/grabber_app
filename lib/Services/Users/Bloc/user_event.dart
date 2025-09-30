part of "user_bloc.dart";

@immutable
sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class FetchUserData extends UserEvent {
  const FetchUserData();
}

class UpdateUserName extends UserEvent {
  final String newName;

  const UpdateUserName({required this.newName});

  @override
  List<Object?> get props => [newName];
}

class UpdatePhoneNum extends UserEvent {
  final String newNum;

  const UpdatePhoneNum({required this.newNum});

  @override
  List<Object?> get props => [newNum];
}

