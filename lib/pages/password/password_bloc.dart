import 'package:flutter_monster/blocs/bloc_base.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_monster/repositories/network/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_monster/models/user_info.dart';
import 'package:flutter_monster/utils/local_storage.dart';
import 'package:flutter_monster/utils/constants.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class PasswordBloc implements BlocBase {

  String _password = '';
  bool _iconButtonHidden = false;

  BehaviorSubject<bool> _passwordButtonController = BehaviorSubject<bool>();
  Sink<bool> get _getIsAvailable => _passwordButtonController.sink;
  Stream<bool> get outIsAvailable => _passwordButtonController.stream;

  PublishSubject<String>  _passwordButtonChangeController = PublishSubject<String>();
  Sink<String> get getPassword => _passwordButtonChangeController.sink;

  BehaviorSubject<bool> _passwordHiddenChangeController = BehaviorSubject<bool>();
  Sink<bool> get _getIsHidden => _passwordHiddenChangeController.sink;
  Stream<bool> get outIsHidden => _passwordHiddenChangeController.stream;

  PublishSubject<String> _iconButtonHiddenChangeController = PublishSubject<String>();
  Sink<String> get getHidden => _iconButtonHiddenChangeController.sink;

  void dispose() {
    _passwordButtonController.close();
    _passwordHiddenChangeController.close();
    _passwordButtonChangeController.close();
    _iconButtonHiddenChangeController.close();
  }

  PasswordBloc() {
    _passwordButtonChangeController.listen(_handleChangePassword);
    _iconButtonHiddenChangeController.listen(_handleHiddenIcon);
  }

  Future registerOrResetPassword(String account, String verifyCode, String verifyCodeToken, bool isRegister) async{
    if (!isRegister) return UserRepository().resetPassword(account, _password, _password, verifyCode, verifyCodeToken);
    else return UserRepository().register(account, _password, verifyCode, verifyCodeToken);
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

  Future login(String account) async{
    UserInfo user = await UserRepository().login(account, _password);
    if (user != null) {
      LocalStorage.setString(Constants.KEY_TOKEN, user.loginToken);
      LocalStorage.setString(Constants.KEY_USER_NAME, account);
      LocalStorage.setString(Constants.KEY_PASSWORD, _password);
      LocalStorage.setString(Constants.KEY_AVATAR, 'https:' + user.avatar);
      LocalStorage.setString(Constants.KEY_NICKNAME, user.nickname);
    }
  }
}