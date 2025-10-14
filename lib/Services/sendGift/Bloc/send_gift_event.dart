part of "send_gift_bloc.dart";

abstract class GiftEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Real-time listening
class ListenToGifts extends GiftEvent {
  final String userId;

  ListenToGifts(this.userId);
}

class ListenToNotifications extends GiftEvent {
  final String userId;

  ListenToNotifications(this.userId);
}

// One-time fetch
class LoadNotifications extends GiftEvent {
  final String userId;

  LoadNotifications(this.userId);
}

// Sending gift
class SendGift extends GiftEvent {
  final String receiverEmail;

  SendGift(this.receiverEmail);
}
