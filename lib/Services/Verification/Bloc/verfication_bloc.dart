import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'verfication_event.dart';
part 'verfication_state.dart';

class VerficationBloc extends Bloc<VerficationEvent, VerficationState> {
  VerficationBloc() : super(VerficationInitial()) {
    on<VerficationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
