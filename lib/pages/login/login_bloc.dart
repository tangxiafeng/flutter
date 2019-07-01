import 'dart:async';
import 'package:flutter_monster/blocs/bloc_base.dart';
import 'package:flutter_monster/models/user_info.dart';
import 'package:flutter_monster/repositories/network/user_repository.dart';
import 'package:flutter_monster/utils/constants.dart';
import 'package:flutter_monster/utils/local_storage.dart';
import 'package:rxdart/rxdart.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class LoginBloc implements BlocBase {

    String _account = '';
    String _password = '';

    BehaviorSubject<bool> _loginAvailableController = BehaviorSubject<bool>();
    Sink<bool> get _getIsAvailable => _loginAvailableController.sink;
    Stream<bool> get outIsAvailable => _loginAvailableController.stream;

    PublishSubject<String> _accountChangeController = PublishSubject<String>();
    Sink<String> get getAccount => _accountChangeController.sink;

    PublishSubject<String> _passwordChangeController = PublishSubject<String>();
    Sink<String> get getPassword => _passwordChangeController.sink;

    ///
    /// Constructor
    ///
    LoginBloc() {
        _accountChangeController.listen(_handleChangeAccount);
        _passwordChangeController.listen(_handleChangePassword);
    }

    void dispose() {
        _loginAvailableController.close();
        _accountChangeController.close();
        _passwordChangeController.close();
    }

    Future login() async{
        UserInfo user = await UserRepository().login(_account, _password);
        if (user != null) {
            LocalStorage.setString(Constants.KEY_TOKEN, user.loginToken);
            LocalStorage.setString(Constants.KEY_USER_NAME, _account);
            LocalStorage.setString(Constants.KEY_PASSWORD, _password);
            LocalStorage.setString(Constants.KEY_AVATAR, 'https:' + user.avatar);
            LocalStorage.setString(Constants.KEY_NICKNAME, user.nickname);
        }
    }

    _handleChangeAccount(String text) {
        _account = text;
        // notify
        _getIsAvailable.add(_account.isEmpty || _password.isEmpty);
    }

    _handleChangePassword(String text) {
        _password = text;
        // notify
        _getIsAvailable.add(_account.isEmpty || _password.isEmpty);
    }

}