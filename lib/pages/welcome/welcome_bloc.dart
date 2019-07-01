import 'dart:async';
import 'package:flutter_monster/blocs/bloc_base.dart';
import 'package:flutter_monster/utils/http_client.dart';
import 'package:flutter_monster/utils/local_storage.dart';
import 'package:flutter_monster/utils/constants.dart';
import 'package:flutter_monster/utils/log.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sharesdk/sharesdk.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class WelcomeBloc implements BlocBase {

    BehaviorSubject<bool> _serverChangeController = BehaviorSubject<bool>();
    Sink<bool> get _getIsInternational => _serverChangeController.sink;
    Stream<bool> get outIsInternational => _serverChangeController.stream;

    ///
    /// Constructor
    ///
    WelcomeBloc() {
        ShareSDKRegister register = ShareSDKRegister();

        register.setupWechat(
            "wx70ae63195d951329", "ea3431d950273750906fe3314b247fc8");
        register.setupSinaWeibo("206863495", "d64b22765519e722030f332d7f825ef5",
            "https://www.microduino.cn/3rd/weibo/callback");
        //register.setupQQ("100371282", "aed9b0303e3ed1e27bae87c33761161d");
        register.setupFacebook(
            "1412473428822331", "a42f4f3f867dc947b9ed6020c2e93558", "shareSDK");
        register.setupTwitter("viOnkeLpHBKs6KXV7MPpeGyzE",
            "NJEglQUy2rqZ9Io9FcAU9p17omFqbORknUpRrCDOK46aAbIiey", "http://mob.com");
        ShareSDK.regist(register);
        ShareSDK.listenNativeEvent();

        // init http
        HttpUtil().getDio().options.baseUrl = LocalStorage.getString(
            Constants.KEY_USER_CENTER_ADDRESS);
    }

    void dispose() {
        _serverChangeController.close();
    }

    void changeServer() {
        bool type = isInternational();
        LocalStorage.setString(Constants.KEY_USER_CENTER_ADDRESS,
            !type ? Constants.USER_CENTER_INTERNATIONAL : Constants.USER_CENTER_LOCAL);
        LocalStorage.setString(Constants.KEY_PROJECTS_ADDRESS,
            !type ? Constants.PROJECTS_INTERNATIONAL : Constants.PROJECTS_LOCAL);

        // update http
        HttpUtil().getDio().options.baseUrl = LocalStorage.getString(Constants.KEY_USER_CENTER_ADDRESS);

        // notify
        _getIsInternational.add(isInternational());
    }

    bool isInternational() {
        return LocalStorage.getString(Constants.KEY_USER_CENTER_ADDRESS) == Constants.USER_CENTER_INTERNATIONAL;
    }

}