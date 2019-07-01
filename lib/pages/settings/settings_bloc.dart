import 'dart:async';

import 'package:flutter_monster/blocs/bloc_base.dart';
import 'package:flutter_monster/events/events.dart';
import 'package:flutter_monster/models/language.dart';
import 'package:flutter_monster/utils/constants.dart';
import 'package:flutter_monster/utils/event_bus.dart';
import 'package:flutter_monster/utils/local_storage.dart';
import 'package:rxdart/rxdart.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class SettingsBloc implements BlocBase {

    PublishSubject<Language> languageChangedController = PublishSubject<Language>();
    Sink<Language> get _getLanguage => languageChangedController.sink;
    Stream<Language> get outLanguage => languageChangedController.stream;

    void dispose() {
        languageChangedController.close();
    }

    SettingsBloc();

    void onLanguageChanged(Language model) {
        LocalStorage.setString(Constants.KEY_LANGUAGE, model.toString());
        // notify
        EventBus().post(LocalizationEvent(model));
        _getLanguage.add(model);
    }
}