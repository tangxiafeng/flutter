import 'package:flutter_monster/blocs/bloc_base.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_monster/repositories/network/user_repository.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class VerifyCodeBloc implements BlocBase {
  int _codeLength = 4;
  int codeLength = 4;
  Timer _timer;
  int seconds = 60;
  String verifyCodeToken;

  BehaviorSubject<bool> _codeAvailableController = BehaviorSubject<bool>();

  Sink<bool> get _getIsAvailable => _codeAvailableController.sink;

  Stream<bool> get outIsAvailable => _codeAvailableController.stream;

  PublishSubject<String> _codeController = PublishSubject<String>();

  Sink<String> get getCode => _codeController.sink;

  void dispose() {
    _codeAvailableController.close();
    _codeController.close();
    _timer?.cancel();
  }


  /// 启动倒计时的计时器。
  void _startTimer() {
    if(seconds == 0) seconds = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds == 0) {
        _handleCode('1234');
        _timer?.cancel();
        return;
      }
      seconds--;
      _handleCode('1');
    });
  }

  VerifyCodeBloc() {
    _codeController.listen(_handleCode);
    _startTimer();
  }

  /// 发送验证码
  Future sendVerifyCode(String account, String challenge, String seccode, String validate) async {
    _startTimer();
    return UserRepository().sendVerifyCode(account, challenge, seccode, validate, true);
  }

  /// 检验验证码
  /// code 验证码
  Future checkVerifyCode(String account, String code) async {
    return UserRepository().checkVerifyCode(account, code, verifyCodeToken);
  }

  /// 发送按钮状态
  _handleCode(String text) async {
    _getIsAvailable.add((text.length != _codeLength));
  }
}
