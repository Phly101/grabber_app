// import "package:bloc_test/bloc_test.dart";
// import "package:equatable/equatable.dart";
// import "package:flutter_test/flutter_test.dart";
// import "package:grabber_app/Services/sendGift/Bloc/send_gift_bloc.dart";
// import "package:grabber_app/Services/sendGift/Models/gift_model.dart";
// import "package:grabber_app/Services/sendGift/Models/notification_model.dart";
// import "package:grabber_app/Services/sendGift/Service/gift_listener_service.dart";
// import "package:grabber_app/Services/sendGift/Service/result.dart";
// import "package:grabber_app/Services/sendGift/Service/send_gift_service.dart";
// import "package:mockito/annotations.dart";
// import "package:mockito/mockito.dart";
//
// @GenerateMocks([GiftListenerService, SendGiftService])
// import "gift_bloc_test.mocks.dart";
//
// class FakeGiftModel extends Equatable implements GiftModel {
//   final String id;
//   const FakeGiftModel({required this.id});
//
//   @override
//   List<Object?> get props => [id];
//
//   @override
//   List<dynamic> get items => [];
//
//   @override
//   String get message => "fake message";
//
//   @override
//   String get senderEmail => "fake@email.com";
//
//   @override
//   String get senderName => "Fake Sender";
//
//   @override
//   String get senderUID => "fakeUID";
//
//   @override
//   DateTime? get timestamp => null;
// }
//
// class FakeNotificationModel extends Equatable implements NotificationModel {
//   final String id;
//   const FakeNotificationModel({required this.id});
//
//   @override
//   List<Object?> get props => [id];
//
//   @override
//   String get message => "fake notification";
//
//   @override
//   bool get read => false;
//
//   @override
//   String get senderEmail => "fake@email.com";
//
//   @override
//   String get senderName => "Fake Sender";
//
//   @override
//   String get senderUID => "fakeUID";
//
//   @override
//   DateTime? get timestamp => null;
//
//   @override
//   String get type => "gift";
// }
//
// void main() {
//   group("GiftBloc", () {
//     late GiftBloc giftBloc;
//     late MockGiftListenerService mockGiftListenerService;
//     late MockSendGiftService mockSendGiftService;
//
//     setUp(() {
//       mockGiftListenerService = MockGiftListenerService();
//       mockSendGiftService = MockSendGiftService();
//       giftBloc = GiftBloc(
//         giftListenerService: mockGiftListenerService,
//         sendGiftService: mockSendGiftService,
//       );
//     });
//
//     tearDown(() {
//       giftBloc.close();
//     });
//
//     test("initial state is GiftInitial", () {
//       expect(giftBloc.state, equals(GiftInitial()));
//     });
//
//     group("SendGift Event", () {
//       blocTest<GiftBloc, SendGiftState>(
//         "emits [GiftLoading, SendGiftSuccess] when sendGift is successful",
//         build: () {
//           when(
//             mockSendGiftService.sendGift(any),
//           ).thenAnswer((_) async => Result.success(null));
//           return giftBloc;
//         },
//         act: (bloc) => bloc.add(SendGift("receiver@example.com")),
//         expect: () => [
//           GiftLoading(),
//           SendGiftSuccess(),
//         ],
//         verify: (_) {
//           verify(
//             mockSendGiftService.sendGift("receiver@example.com"),
//           ).called(1);
//         },
//       );
//
//       blocTest<GiftBloc, SendGiftState>(
//         "emits [GiftLoading, SendGiftFailure] when sendGift fails",
//         build: () {
//           when(
//             mockSendGiftService.sendGift(any),
//           ).thenAnswer((_) async => Result.failure("user_not_found"));
//           return giftBloc;
//         },
//         act: (bloc) => bloc.add(SendGift("receiver@example.com")),
//         expect: () => [
//           GiftLoading(),
//           SendGiftFailure("user_not_found"),
//         ],
//       );
//     });
//
//     group("LoadNotifications Event", () {
//       final mockNotifications = [const FakeNotificationModel(id: "1")];
//
//       blocTest<GiftBloc, SendGiftState>(
//         "emits [NotificationsLoading, NotificationsLoaded] when successful",
//         build: () {
//           when(
//             mockGiftListenerService.getNotifications(any),
//           ).thenAnswer((_) async => Result.success(mockNotifications));
//           return giftBloc;
//         },
//         act: (bloc) => bloc.add(LoadNotifications("userId")),
//         expect: () => [
//           NotificationsLoading(),
//           NotificationsLoaded(mockNotifications),
//         ],
//       );
//
//       blocTest<GiftBloc, SendGiftState>(
//         "emits [NotificationsLoading, NotificationError] when it fails",
//         build: () {
//           when(
//             mockGiftListenerService.getNotifications(any),
//           ).thenAnswer((_) async => Result.failure("Failed to load"));
//           return giftBloc;
//         },
//         act: (bloc) => bloc.add(LoadNotifications("userId")),
//         expect: () => [
//           NotificationsLoading(),
//           NotificationError("Failed to load"),
//         ],
//       );
//     });
//
//     group("ListenToGifts Event", () {
//       final mockGifts = [const FakeGiftModel(id: "g1")];
//
//       blocTest<GiftBloc, SendGiftState>(
//         "emits [GiftLoading, GiftStreamUpdated] on new gift data",
//         build: () {
//           when(
//             mockGiftListenerService.listenToIncomingGifts(any),
//           ).thenAnswer((_) => Stream.value(mockGifts));
//           return giftBloc;
//         },
//         act: (bloc) => bloc.add(ListenToGifts("userId")),
//         expect: () => [
//           GiftLoading(),
//           GiftStreamUpdated(mockGifts),
//         ],
//       );
//
//       blocTest<GiftBloc, SendGiftState>(
//         "emits [GiftLoading, GiftError] on stream error",
//         build: () {
//           when(
//             mockGiftListenerService.listenToIncomingGifts(any),
//           ).thenAnswer((_) => Stream.error("Connection failed"));
//           return giftBloc;
//         },
//         act: (bloc) => bloc.add(ListenToGifts("userId")),
//         expect: () => [
//           GiftLoading(),
//           GiftError("Connection failed"),
//         ],
//       );
//     });
//     group("ListenToNotifications Event", () {
//       final mockNotifications = [const FakeNotificationModel(id: "n1")];
//
//       blocTest<GiftBloc, SendGiftState>(
//         "emits [NotificationStreamUpdated] on new notification data",
//         build: () {
//           when(
//             mockGiftListenerService.listenToNotifications(any),
//           ).thenAnswer((_) => Stream.value(mockNotifications));
//           return giftBloc;
//         },
//         act: (bloc) => bloc.add(ListenToNotifications("userId")),
//         expect: () => [
//           NotificationStreamUpdated(mockNotifications),
//         ],
//       );
//
//       blocTest<GiftBloc, SendGiftState>(
//         "emits [NotificationError] on stream error",
//         build: () {
//           when(
//             mockGiftListenerService.listenToNotifications(any),
//           ).thenAnswer((_) => Stream.error("Stream error"));
//           return giftBloc;
//         },
//         act: (bloc) => bloc.add(ListenToNotifications("userId")),
//         expect: () => [
//           NotificationError("Notification stream error: Stream error"),
//         ],
//       );
//     });
//
//     group("Simple State Emitters", () {
//       blocTest<GiftBloc, SendGiftState>(
//         "emits [GiftModeEnabled] when EnableGiftMode is added",
//         build: () => giftBloc,
//         act: (bloc) => bloc.add(EnableGiftMode()),
//         expect: () => [GiftModeEnabled()],
//       );
//
//       blocTest<GiftBloc, SendGiftState>(
//         "emits [GiftModeDisabled] when DisableGiftMode is added",
//         build: () => giftBloc,
//         act: (bloc) => bloc.add(DisableGiftMode()),
//         expect: () => [GiftModeDisabled()],
//       );
//
//       blocTest<GiftBloc, SendGiftState>(
//         "emits [GiftPaymentActive] when StartGiftPayment is added",
//         build: () => giftBloc,
//         act: (bloc) => bloc.add(StartGiftPayment("test@test.com", "gift123")),
//         expect: () => [
//           GiftPaymentActive(receiverEmail: "test@test.com", giftId: "gift123"),
//         ],
//       );
//
//       blocTest<GiftBloc, SendGiftState>(
//         "emits [GiftInitial] when CancelGiftPayment is added",
//         build: () {
//           giftBloc.emit(
//             GiftPaymentActive(
//               receiverEmail: "test@test.com",
//               giftId: "gift123",
//             ),
//           );
//           return giftBloc;
//         },
//         act: (bloc) => bloc.add(CancelGiftPayment()),
//         expect: () => [GiftInitial()],
//       );
//     });
//   });
// }
