import 'package:flutter_monster/blocs/bloc_base.dart';
import 'package:flutter_monster/utils/constants.dart';
import 'package:flutter_monster/utils/http_client.dart';
import 'package:flutter_monster/utils/local_storage.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class ProfileBloc implements BlocBase {

    void dispose() {}

    ProfileBloc();

    void clearStorage() {
        // clear storage
        HttpUtil().getDio().options.headers.remove('x-login-token');
        LocalStorage.setString(Constants.KEY_TOKEN, null);
        LocalStorage.setString(Constants.KEY_USER_NAME, '');
        LocalStorage.setString(Constants.KEY_PASSWORD, '');
        LocalStorage.setString(Constants.KEY_AVATAR, '');
        LocalStorage.setString(Constants.KEY_NICKNAME, '');
        LocalStorage.setString(Constants.KEY_SERVER_USER_DATA, '');
    }

    String getAccount() {
        return LocalStorage.getString(Constants.KEY_USER_NAME);
    }

    String getPassword() {
        return LocalStorage.getString(Constants.KEY_PASSWORD);
    }

}