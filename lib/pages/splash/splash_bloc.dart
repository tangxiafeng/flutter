import 'package:flutter_monster/blocs/bloc_base.dart';
import 'package:flutter_monster/utils/constants.dart';
import 'package:flutter_monster/utils/local_storage.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class SplashBloc implements BlocBase {

    void dispose() {}

    SplashBloc();

    bool isLogin() {
        return !(LocalStorage.getString(Constants.KEY_TOKEN) == null);
    }
}