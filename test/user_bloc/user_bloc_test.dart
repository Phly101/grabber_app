import "package:bloc_test/bloc_test.dart";
import "package:flutter_test/flutter_test.dart";
import "package:grabber_app/Services/Users/Bloc/user_bloc.dart";
import "package:grabber_app/Services/Users/user_services.dart";
import "package:mocktail/mocktail.dart";

class MockUserService extends Mock implements UserServices {}

void main() {
  late MockUserService mockUserService;
  late UserBloc userBloc;

  setUp(() {
    mockUserService = MockUserService();
    userBloc = UserBloc(userServices: mockUserService);
  });

  tearDown(() => userBloc.close());

  group("UserBloc", () {
    test("initial state is UserInitial", () {
      expect(userBloc.state, const UserInitial());
    });

    blocTest(
      "emits [UserLoading, UserDataLoaded] when FetchUserData succeeds",
      build: () {
        when(() => mockUserService.getCurrentUserData()).thenAnswer(
          (_) async => {
            "name": "test",
            "email": "test@example.com",
            "phoneNumber": "123456789",
          },
        );
        return userBloc;
      },
      act: (bloc) => bloc.add(const FetchUserData()),
      expect: () => [
        isA<UserLoading>(),
        predicate<UserDataLoaded>(
          (state) =>
              state.user.name == "test" &&
              state.user.email == "test@example.com" &&
              state.user.phoneNumber == "123456789",
        ),
      ],
    );

    blocTest(
      "emits [UserLoading, UserUpdateError] when FetchUserData fails",
      build: () {
        when(
          () => mockUserService.getCurrentUserData(),
        ).thenThrow(Exception("Failed to fetch user data"));
        return userBloc;
      },
      act: (bloc) => bloc.add(const FetchUserData()),
      expect: () => [
        isA<UserLoading>(),
        isA<UserUpdateError>(),
      ],
    );

    blocTest(
      "emits UserUpdateSuccess when UpdateUserName succeeds",
      build: () {
        when(
          () => mockUserService.updateUserName(any()),
        ).thenAnswer((_) async {});
        return userBloc;
      },
      seed: () => const UserDataLoaded(
        user: User(
          name: "old",
          email: "old@example.com",
          phoneNumber: "123",
        ),
      ),
      act: (bloc) => bloc.add(const UpdateUserName(newName: "new name")),
      expect: () => [
        predicate<UserUpdateSuccess>(
          (state) => state.user.name == "new name",
        ),
      ],
    );

    blocTest(
      "emits UserUpdateError when UpdateUserName fails",
      build: () {
        when(
          () => mockUserService.updateUserName(any()),
        ).thenThrow(Exception("Failed to update user name"));
        return userBloc;
      },
      seed: () => const UserDataLoaded(
        user: User(
          name: "old",
          email: "old@example.com",
          phoneNumber: "123",
        ),
      ),
      act: (bloc) => bloc.add(const UpdateUserName(newName: "new name")),
      expect: () => [isA<UserUpdateError>()],
    );

    blocTest(
      "emits UserUpdateSuccess when UpdatePhoneNum succeeds",
      build: () {
        when(
          () => mockUserService.updatePhoneNum(any()),
        ).thenAnswer((_) async {});
        return userBloc;
      },
      seed: () => const UserDataLoaded(
        user: User(
          name: "old",
          email: "old@example.com",
          phoneNumber: "123",
        ),
      ),
      act: (bloc) => bloc.add(const UpdatePhoneNum(newNum: "234")),
      expect: () => [
        predicate<UserUpdateSuccess>(
          (state) => state.user.phoneNumber == "234",
        ),
      ],
    );

    blocTest(
      "emits UserUpdateError when UpdatePhoneNum fails",
      build: () {
        when(
          () => mockUserService.updatePhoneNum(any()),
        ).thenThrow(Exception("Failed to update phone number"));
        return userBloc;
      },
      seed: () => const UserDataLoaded(
        user: User(
          name: "old",
          email: "old@example.com",
          phoneNumber: "123",
        ),
      ),
      act: (bloc) => bloc.add(const UpdateUserName(newName: "234")),
      expect: () => [isA<UserUpdateError>()],
    );
  });
}
