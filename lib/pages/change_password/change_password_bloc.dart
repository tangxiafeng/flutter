import 'package:flutter_monster/blocs/bloc_base.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_monster/repositories/network/user_repository.dart';
import 'package:flutter_monster/utils/constants.dart';
import 'package:flutter_monster/utils/local_storage.dart';
import 'package:flutter_monster/utils/http_client.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class ChangePasswordBloc implements BlocBase {


    String _password = '';
    bool _iconButtonHidden = false;

    BehaviorSubject<bool> _changePasswordController = BehaviorSubject<bool>();
    Sink<bool> get _getIsAvailable => _changePasswordController.sink;
    Stream<bool> get outIsAvailable => _changePasswordController.stream;

    PublishSubject<String> _passwordChangeController = PublishSubject<String>();
    Sink<String> get getPassword => _passwordChangeController.sink;

    BehaviorSubject<bool> _passwordHiddenChangeController = BehaviorSubject<bool>();
    Sink<bool> get _getIsHidden => _passwordHiddenChangeController.sink;
    Stream<bool> get outIsHidden => _passwordHiddenChangeController.stream;

    PublishSubject<String> _iconButtonHiddenChangeController = PublishSubject<String>();
    Sink<String> get getHidden => _iconButtonHiddenChangeController.sink;



    void dispose() {
	    _changePasswordController.close();
	    _passwordChangeController.close();
	    _passwordHiddenChangeController.close();
	    _iconButtonHiddenChangeController.close();
    }

    resetPassword(String account, String verifyCodeToken, String verifyCode) async {
	    return UserRepository().resetPassword(account, _password, _password, verifyCodeToken, verifyCode);
    }

    setLocalPassword(){
	    return LocalStorage.setString(Constants.KEY_PASSWORD, _password);
    }

    changePassword() async {
        HttpUtil().getDio().options.baseUrl = LocalStorage.getString(Constants.KEY_USER_CENTER_ADDRESS);
        return UserRepository().changePassword(LocalStorage.getString(Constants.KEY_PASSWORD), _password);
    }


    /// Constructor
    ChangePasswordBloc() {
	    _passwordChangeController.listen(_handleChangePassword);
	    _iconButtonHiddenChangeController.listen(_handleHiddenIcon);
    }

    /// 修改按钮状态
    _handleChangePassword(String text) {
	    _password = text;
	    _getIsAvailable.add(_password.isEmpty);
    }

    /// 是否隐藏密码
    _handleHiddenIcon(String text) {
	    _iconButtonHidden = !_iconButtonHidden;
	    _getIsHidden.add(_iconButtonHidden);
    }

}