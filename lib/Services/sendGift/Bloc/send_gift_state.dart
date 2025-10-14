import 'package:equatable/equatable.dart';
import 'package:grabber_app/Services/sendGift/Models/gift_model.dart';
import 'package:grabber_app/Services/sendGift/Models/notification_model.dart';

// Base abstract class for all states
abstract class GiftState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial
class GiftInitial extends GiftState {}

// Loading
class GiftLoading extends GiftState {}

// Gifts stream updates
class GiftStreamUpdated extends GiftState {
  final List<GiftModel> gifts;
  GiftStreamUpdated(this.gifts);

  @override
  List<Object?> get props => [gifts];
}

// Notifications stream updates
class NotificationStreamUpdated extends GiftState {
  final List<NotificationModel> notifications;
  NotificationStreamUpdated(this.notifications);

  @override
  List<Object?> get props => [notifications];
}

// Notifications loaded once
class NotificationsLoaded extends GiftState {
  final List<NotificationModel> notifications;
  NotificationsLoaded(this.notifications);

  @override
  List<Object?> get props => [notifications];
}

// Send gift success
class SendGiftSuccess extends GiftState {}

// Send gift failure
class SendGiftFailure extends GiftState {
  final String message;
  SendGiftFailure(this.message);

  @override
  List<Object?> get props => [message];
}

// General error
class GiftError extends GiftState {
  final String message;
  GiftError(this.message);

  @override
  List<Object?> get props => [message];
}
