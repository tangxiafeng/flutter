import 'dart:async';

import 'package:flutter_monster/blocs/bloc_base.dart';
import 'package:flutter_monster/utils/constants.dart';
import 'package:rxdart/rxdart.dart';

class KitChooseBloc implements BlocBase {

    String kit;

    PublishSubject<String> _indexChangeController = PublishSubject<String>();
    Sink<String> get _getKitName => _indexChangeController.sink;
    Stream<String> get outKitName => _indexChangeController.stream;

    void dispose() {
        _indexChangeController.close();
    }

    KitChooseBloc(String kitName) {
        kit = kitName;
    }

    String getKitName(int index) {
        return Constants.LIST_SUPPORTED_KITS[index];
    }

    void onIndexChanged(int index) {
        // notify
        _getKitName.add(getKitName(index));
    }

    int getKitIndex(String name) {
        return Constants.LIST_SUPPORTED_KITS.indexOf(name);
    }

}