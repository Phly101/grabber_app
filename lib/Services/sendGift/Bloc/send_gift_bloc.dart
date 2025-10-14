import "dart:async";
import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Services/sendGift/Models/gift_model.dart";
import "package:grabber_app/Services/sendGift/Models/notification_model.dart";
import "package:grabber_app/Services/sendGift/Service/gift_listener_service.dart";
import "package:grabber_app/Services/sendGift/Service/send_gift_service.dart";

part "send_gift_event.dart";

part "send_gift_state.dart";

class GiftBloc extends Bloc<GiftEvent, SendGiftState> {
  final GiftListenerService giftListenerService;
  final SendGiftService sendGiftService;

  StreamSubscription<List<GiftModel>>? _giftSubscription;
  StreamSubscription<List<NotificationModel>>? _notificationSubscription;

  GiftBloc({
    required this.giftListenerService,
    required this.sendGiftService,
  }) : super(GiftInitial()) {
    on<ListenToGifts>(_onListenToGifts);
    on<ListenToNotifications>(_onListenToNotifications);
    on<LoadNotifications>(_onLoadNotifications);
    on<SendGift>(_onSendGift);
    on<EnableGiftMode>((event, emit) => emit(GiftModeEnabled()));
    on<DisableGiftMode>((event, emit) => emit(GiftModeDisabled()));
    on<StartGiftPayment>((event, emit) {
      emit(GiftPaymentActive(
        receiverEmail: event.receiverEmail,
        giftId: event.message,
      ));
    });

    on<CancelGiftPayment>((event, emit) {
      emit(GiftInitial());
    });
  }

  Future<void> _onListenToGifts(
    ListenToGifts event,
    Emitter<SendGiftState> emit,
  ) async {
    await _giftSubscription?.cancel();
    _giftSubscription = giftListenerService
        .listenToIncomingGifts(event.userId)
        .listen(
          (gifts) => emit(GiftStreamUpdated(gifts)),
          onError: (error) => emit(GiftError("Gift stream error: $error")),
        );
  }

  Future<void> _onListenToNotifications(
    ListenToNotifications event,
    Emitter<SendGiftState> emit,
  ) async {
    await _notificationSubscription?.cancel();
    _notificationSubscription = giftListenerService
        .listenToNotifications(event.userId)
        .listen(
          (notifications) => emit(NotificationStreamUpdated(notifications)),
          onError: (error) =>
              emit(NotificationError("Notification stream error: $error")),
        );
  }

  Future<void> _onLoadNotifications(
    LoadNotifications event,
    Emitter<SendGiftState> emit,
  ) async {
    emit(NotificationsLoading());
    final result = await giftListenerService.getNotifications(event.userId);
    if (result.isSuccess) {
      emit(NotificationsLoaded(result.data ?? []));
    } else {
      emit(NotificationError(result.message ?? "Failed to load notifications"));
    }
  }

  Future<void> _onSendGift(SendGift event, Emitter<SendGiftState> emit) async {
    emit(GiftLoading());
    final result = await sendGiftService.sendGift(event.receiverEmail);
    if (result.isSuccess) {
      emit(SendGiftSuccess());
    } else {
      emit(SendGiftFailure(result.message ?? "Failed to send gift"));
    }
  }

  @override
  Future<void> close() {
    _giftSubscription?.cancel();
    _notificationSubscription?.cancel();
    return super.close();
  }
}
