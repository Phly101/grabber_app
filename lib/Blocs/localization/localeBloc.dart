
import "dart:ui";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Blocs/localization/localEvent.dart";
import "package:grabber_app/Blocs/localization/localState.dart";


class LocaleBloc extends Bloc<LocaleEvent,LocaleState>{
  LocaleBloc():super(LocalInitial(const Locale("en"))){
    on<ChangeLang>((event, emit) {
      emit(LocaleUpdated(event.locale));
    });
  }
}