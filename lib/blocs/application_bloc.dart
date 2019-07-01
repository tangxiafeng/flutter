import 'dart:convert';
import 'dart:async';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_monster/models/language.dart';
import 'package:flutter_monster/utils/constants.dart';
import 'package:flutter_monster/utils/event_bus.dart';
import 'package:flutter_monster/utils/local_storage.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc_base.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class ApplicationBloc implements BlocBase {

    EventBus eventBus;

    StreamSubscription connectionController;
    PublishSubject<bool> closeController = PublishSubject<bool>();
    Sink<bool> get _getCloseState => closeController.sink;

    PublishSubject<bool> isBleOnController = PublishSubject<bool>();
    Sink<bool> get _getIsBleOn => isBleOnController.sink;

    PublishSubject<bool> _disconnectStateController = PublishSubject<bool>();
    Sink<bool> get getDisconnectState => _disconnectStateController.sink;
    Stream<bool> get outDisconnectState => _disconnectStateController.stream;

    PublishSubject<int> _flashProcessController = PublishSubject<int>();
    Sink<int> get getFlashProcess => _flashProcessController.sink;
    Stream<int> get outFlashProcess => _flashProcessController.stream;

    ApplicationBloc() {
        eventBus = EventBus();
    }

    void dispose() {
        connectionController.cancel();
        closeController.close();
        isBleOnController.close();
        _disconnectStateController.close();
        _flashProcessController.close();
        EventBus().unregister();
    }

    Language getCurrentLanguage() {
        String language = LocalStorage.getString(Constants.KEY_LANGUAGE);
        if (language != null) {
            Map map = json.decode(language);
            return Language.fromJson(map);
        }
        return null;
    }

    void checkIsOn() {
        Timer.periodic(Duration(milliseconds: 500), (Timer timer) async {
            bool isOn = await FlutterBlue.instance.isOn;
            _getIsBleOn.add(isOn);
            if (isOn) {
                timer.cancel();
            }
        });
    }

    void handleDisconnect() {
        _getCloseState.add(true);
    }

}