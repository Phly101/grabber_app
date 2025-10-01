
import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Services/Users/user_services.dart";



part "user_event.dart";

part "user_state.dart";

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserServices userServices = UserServices();

  UserBloc() : super(const UserInitial()) {
    on<FetchUserData>(_onFetchUserData);
    on<UpdateUserName>(_onUpdateUserName);
    on<UpdatePhoneNum>(_onUpdatePhoneNum);
  }

  Future<void> _onFetchUserData(
    FetchUserData event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading(user: state.user));

    try{
      final userData = await userServices.getCurrentUserData();
      final user = User(
        name: userData["name"],
        email: userData["email"],
        phoneNumber: userData["phoneNumber"],
      );
      emit(UserDataLoaded(user: user));
    }catch (e){
      emit(UserUpdateError(user: state.user, error: "failed to fetch user data: $e"));
    }
  }

  Future<void> _onUpdateUserName(
    UpdateUserName event,
    Emitter<UserState> emit,
  ) async {
    try {
      await userServices.updateUserName(event.newName);
      final updatedUser = state.user.copyWith(name: event.newName);
      emit(UserUpdateSuccess(user: updatedUser));
    } catch (e) {
      emit(UserUpdateError(user: state.user, error: "Failed To Update Name: $e"));
    }
  }

  Future<void> _onUpdatePhoneNum(
    UpdatePhoneNum event,
    Emitter<UserState> emit,
  ) async {
    try {
      await userServices.updatePhoneNum(event.newNum);
      final updatedUser = state.user.copyWith(phoneNumber: event.newNum);
      emit(UserUpdateSuccess(user: updatedUser));
    } catch (e) {
      emit(UserUpdateError(user: state.user, error: "Failed To Update Phone: $e"));
    }
  }
}
