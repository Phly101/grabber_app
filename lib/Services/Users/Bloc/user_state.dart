part of "user_bloc.dart";

class User extends Equatable {
  final String name;
  final String email;
  final String phoneNumber;

  const User({
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  User copyWith({
    String? name,
    String? email,
    String? phoneNumber,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  List<Object?> get props => [name, email, phoneNumber];
}

@immutable
sealed class UserState extends Equatable {
  final User user;

  const UserState({required this.user});

  @override
  List<Object?> get props => [user];
}

final class UserInitial extends UserState {
  const UserInitial()
    : super(
        user: const User(
          name: "",
          email: "",
          phoneNumber: "",
        ),
      );
}

class UserLoading extends UserState {
  const UserLoading({required super.user});
}

class UserDataLoaded extends UserState {
  const UserDataLoaded({required super.user});
}

class UserUpdateSuccess extends UserState {
  const UserUpdateSuccess({required super.user});
}

class UserUpdateError extends UserState {
  final String error;

  const UserUpdateError({
    required super.user,
    required this.error,
  });

  @override
  List<Object?> get props => [user, error];
}
