import 'dart:async';
import 'dart:convert';

import 'package:flutter_monster/models/user_info.dart';
import 'package:flutter_monster/models/verify_code_token.dart';
import 'package:flutter_monster/utils/constants.dart';
import 'package:flutter_monster/utils/http_client.dart';
import 'package:flutter_monster/utils/local_storage.dart';
import 'package:dio/dio.dart';
import 'package:sprintf/sprintf.dart';

class UserRepository {

    Future<UserInfo> login(String username, String password) async {
        BaseResponse<Map<String, dynamic>> response = await HttpUtil().request<Map<String, dynamic>>(
            Constants.HTTP_METHOD_POST,
            Constants.URL_PATH_LOGIN,
            data: {
                'app': 'mdesignerpad',
                'username': username,
                'password': password,
            }
        );

        UserInfo userInfo;
        if (response.data != null) {
            LocalStorage.setString(Constants.KEY_SERVER_USER_DATA, json.encode(response.data));
            userInfo = UserInfo.fromJson(response.data);
        }
        return userInfo;
    }

    Future<String> sendVerifyCode(String username, String challenge, String seccode, String validate, bool checkUsername) async {
      BaseResponse response = await HttpUtil().request(
          Constants.HTTP_METHOD_POST,
          sprintf(Constants.URL_PATH_VERIFY_CODE, [checkUsername.toString()]),
          data: {
            'username': username,
            'seccode': seccode,
            'challenge': challenge,
            'validate': validate,
          }
      );
      VerifyCodeToken token;
      if (response.data != null) {
        token = VerifyCodeToken.fromJson(response.data);
      }
      return token?.verifyCodeToken;
    }

    Future<String> checkVerifyCode(String account, String verifyCode, String verifyCodeToken) async {
      BaseResponse response = await HttpUtil().request(
          Constants.HTTP_METHOD_POST,
          Constants.URL_PATH_CHECK_VERIFY_CODE,
          data: {
            'username': account,
            'verifyCode': verifyCode,
            'verifyCodeToken': [verifyCodeToken]
          }
      );
      return response.data.toString();
    }

    Future<String> register(String account, String password, String verifyCode, String verifyCodeToken) async {
      BaseResponse response = await HttpUtil().request(
          Constants.HTTP_METHOD_POST,
          Constants.URL_PATH_REGISTER,
          data: {
            'app':'mdesignerpad',
            'username': account,
            'password': password,
            'nickname': DateTime.now().toString(),
            'verifyCode': verifyCode,
            'verifyCodeToken': [verifyCodeToken]
          }
      );
      return response.data.toString();
    }

    /// 重置密码
    Future<String> resetPassword(String account, String password, String confirmPassword, String verifyCode, String verifyCodeToken) async {
        BaseResponse response = await HttpUtil().request(
            Constants.HTTP_METHOD_PATCH,
            Constants.URL_PATH_RESET_PASSWORD,
            data: {
                'app':'mdesignerpad',
	            'username': account,
                'password': password,
	            'confirmPassword': confirmPassword,
	            'verifyCodeToken': [verifyCodeToken],
	            'verifyCode': verifyCode

            }
        );
        return response.data.toString();
    }

    /// 修改密码
    Future<String> changePassword(String oldPassword, String password) async {
        BaseResponse response = await HttpUtil().request(
            Constants.HTTP_METHOD_PATCH,
            Constants.URL_PATH_CHANGE_PASSWORD,
            options: new Options(
                headers: {
                    "x-login-token" : LocalStorage.getString(Constants.KEY_TOKEN),
                }
            ),
            data: {
                'oldPassword': oldPassword,
                'password': password,
                'confirmPassword': password
            }
        );
        return response.data.toString();
    }

    /// 第三方登录
    Future<UserInfo> sharedAppLogin(String type, Map profile) async {
        BaseResponse response = await HttpUtil().request(
            Constants.HTTP_METHOD_POST,
            Constants.URL_PATH_SHARED_APP_LOGIN,
            data: {
                'app':'mdesignerpad',
                'type': type,
                'profile': profile
            }
        );
        UserInfo userInfo;
        if (response.data != null) {
            userInfo = UserInfo.fromJson(response.data);
        }
        return userInfo;
    }


//    Future<String> checkExists(String account) async {
//      BaseResponse response = await HttpUtil().request(
//          Constants.HTTP_METHOD_POST,
//          Constants.URL_PATH_CHECK_EXISTS,
//          data: {
//            'username': account
//          }
//      );
//      return response.data.toString();
//    }


}