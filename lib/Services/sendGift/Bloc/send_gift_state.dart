part of "send_gift_bloc.dart";

// Base abstract class for all states
abstract class SendGiftState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial
class GiftInitial extends SendGiftState {}

// Loading
class GiftLoading extends SendGiftState {}

class NotificationsLoading extends SendGiftState {}

// Gifts stream updates
class GiftStreamUpdated extends SendGiftState {
  final List<GiftModel> gifts;

  GiftStreamUpdated(this.gifts);

  @override
  List<Object?> get props => [gifts];
}

// Notifications stream updates
class NotificationStreamUpdated extends SendGiftState {
  final List<NotificationModel> notifications;

  NotificationStreamUpdated(this.notifications);

  @override
  List<Object?> get props => [notifications];
}

// Notifications loaded once
class NotificationsLoaded extends SendGiftState {
  final List<NotificationModel> notifications;

  NotificationsLoaded(this.notifications);

  @override
  List<Object?> get props => [notifications];
}

// Send gift success
class SendGiftSuccess extends SendGiftState {}
class DeleteGiftsAndNotifSuccess extends SendGiftState{}

class SendNotificationsSuccess extends SendGiftState {}

// Send notification failure
class SendNotificationFailure extends SendGiftState {
  final String message;

  SendNotificationFailure(this.message);

  @override
  List<Object?> get props => [message];
}

// General notification error
class NotificationError extends SendGiftState {
  final String message;

  NotificationError(this.message);

  @override
  List<Object?> get props => [message];
}

// Send gift failure
class SendGiftFailure extends SendGiftState {
  final String message;

  SendGiftFailure(this.message);

  @override
  List<Object?> get props => [message];
}
class GiftModeEnabled extends SendGiftState {}

class GiftModeDisabled extends SendGiftState {}
// General error
class GiftError extends SendGiftState {
  final String message;

  GiftError(this.message);

  @override
  List<Object?> get props => [message];
}
class GiftPaymentActive extends SendGiftState {
  final String receiverEmail;
  final String giftId;

  GiftPaymentActive({required this.receiverEmail, required this.giftId});

  @override
  List<Object?> get props => [receiverEmail, giftId];
}

