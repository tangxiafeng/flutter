import 'package:sharesdk/sharesdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


/*
 * Created by gloria on 2018/1/9.
 */

class login {

  static Map authToWechat(BuildContext context) {
    ShareSDK.auth(
        ShareSDKPlatforms.wechatSession, null, (SSDKResponseState state,
        Map user, SSDKError error) {
      showAlert(state, user != null ? user : error.rawData, context);
      return user;
    });
  }

  static Map authToSina(BuildContext context) {
    ShareSDK.auth(
        ShareSDKPlatforms.sina, null, (SSDKResponseState state, Map user,
        SSDKError error) {
      showAlert(state, user != null ? user : error.rawData, context);
      return user;
    });
  }

  static Map authToTwitter(BuildContext context) {
    ShareSDK.auth(
        ShareSDKPlatforms.twitter, null, (SSDKResponseState state,
        Map user, SSDKError error) {
          showAlert(state, user != null ? user : error.rawData, context);
          return user;
    });
  }

  static Map authToFacebook(BuildContext context) {
    ShareSDK.auth(
        ShareSDKPlatforms.facebook, null, (SSDKResponseState state,
        Map user, SSDKError error) {
      showAlert(state, user != null ? user : error.rawData, context);
      return user;
    });
  }

  static void authToQQ(BuildContext context) {
    ShareSDK.auth(
        ShareSDKPlatforms.qq, null, (SSDKResponseState state,
        Map user, SSDKError error) {

      showAlert(state, user != null ? user : error.rawData, context);
    });
  }
}

void showAlert(SSDKResponseState state, Map content, BuildContext context) {
  print("--------------------------> state:" + state.toString());
  print("--------------------------> content:" + content.toString());
  print("--------------------------> context:" + context.toString());
  String title = "失败";
  switch (state) {
    case SSDKResponseState.Success:
      title = "成功";
      break;
    case SSDKResponseState.Fail:
      title = "失败";
      break;
    case SSDKResponseState.Cancel:
      title = "取消";
      break;
    default:
      title = state.toString();
      break;
  }

  showDialog(
      context: context,
      builder: (BuildContext context) =>
          CupertinoAlertDialog(
              title: new Text(title),
              content: new Text(content != null ? content.toString() : ""),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ]
          ));
}