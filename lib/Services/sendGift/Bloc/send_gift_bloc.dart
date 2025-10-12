import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'send_gift_event.dart';
part 'send_gift_state.dart';

class SendGiftBloc extends Bloc<SendGiftEvent, SendGiftState> {
  SendGiftBloc() : super(SendGiftInitial()) {
    on<SendGiftEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
