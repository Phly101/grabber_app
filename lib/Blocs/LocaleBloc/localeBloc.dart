import "dart:ui";
import "package:flutter_bloc/flutter_bloc.dart";
import "localeEvent.dart";
import "localeState.dart";

class LocaleBloc extends Bloc<LocaleEvent,LocaleState>{
  LocaleBloc():super(LocalInitial(const Locale("en"))){
    on<ChangeLang>((event, emit) {
    emit(LocaleUpdated(event.locale));
  });
}
}