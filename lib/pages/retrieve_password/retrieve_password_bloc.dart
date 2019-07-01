import 'package:flutter_monster/blocs/bloc_base.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_monster/utils/utils.dart';
import 'package:flutter_monster/repositories/network/user_repository.dart';
import 'package:flutter_monster/repositories/network/gee_test.dart';
import 'package:flutter/material.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class RetrievePasswordBloc implements BlocBase {
  String account = '';
  String _type = 'phone';
  final TextEditingController controller =
  new TextEditingController.fromValue(new TextEditingValue(text: ""));

  BehaviorSubject<bool> _registerAvailableController = BehaviorSubject<bool>();
  Sink<bool> get _getIsAvailable => _registerAvailableController.sink;
  Stream<bool> get outIsAvailable => _registerAvailableController.stream;

  PublishSubject<String> _accountChangeController = PublishSubject<String>();
  Sink<String> get getAccount => _accountChangeController.sink;

  BehaviorSubject<bool> _registerButtonController = BehaviorSubject<bool>();
  Sink<bool> get _getAvailable => _registerButtonController.sink;
  Stream<bool> get outAvailable => _registerButtonController.stream;

  PublishSubject<String> _typeChangeController = PublishSubject<String>();
  Sink<String> get getType => _typeChangeController.sink;


  BehaviorSubject<bool> _textIconButtonController = BehaviorSubject<bool>();
  Sink<bool> get _getHidden => _textIconButtonController.sink;
  Stream<bool> get outHidden => _textIconButtonController.stream;

  PublishSubject<String> _iconChangeButton = PublishSubject<String>();
  Sink<String> get getHidden => _iconChangeButton.sink;

  void dispose() {
    _registerAvailableController.close();
    _accountChangeController.close();

    _registerButtonController.close();
    _typeChangeController.close();

    _textIconButtonController.close();
    _iconChangeButton.close();
  }



  RetrievePasswordBloc() {
    _accountChangeController.listen(_handleChangeAccount);
    _typeChangeController.listen(_handleType);
    _iconChangeButton.listen(_handleType);
  }

  /// 发送验证码
  Future sendVerifyCode(String challenge, String seccode, String validate) async {
    return UserRepository().sendVerifyCode(account, challenge, seccode, validate, true);
  }

//  /// 检验用户是否存在
//  Future checkExists() async {
//    return UserRepository().checkExists(account);
//  }

  _handleChangeAccount(String text) {
    account = text;
    _getHidden.add((text == '')); /// 修改文本删除按钮状态
    _getIsAvailable.add((_type == 'phone'
        ? !Utils.isPhone(account)
        : !Utils.isEmail(account)));   /// 修改按钮状态
  }


  /// 修改输入框文本
  _handleType(String text) {
    _type = text;
    _getAvailable.add((_type == 'phone'));
  }

  /// 极验
  showGt3() {
    return GeeTest().show();

  }
}
