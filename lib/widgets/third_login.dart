import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_monster/generated/i18n.dart';
import 'package:flutter_monster/utils/styles.dart';
import 'package:flutter_monster/utils/utils.dart';
import 'package:flutter_monster/utils/login.dart';
import 'package:flutter_monster/utils/constants.dart';
import 'package:flutter_monster/repositories/network/user_repository.dart';
import 'package:flutter_monster/utils/toast.dart';
import 'package:flutter_monster/utils/local_storage.dart';
import 'package:flutter_monster/utils/monstor_navigator.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class ThirdLogin extends StatelessWidget {
  const ThirdLogin({this.isInternational, Key key}) : super(key: key);

  final bool isInternational;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Image.asset(
                  Utils.image(isInternational ? Constants.LOGIN_FACEBOOK : Constants.LOGIN_WE_CHAT),
                  color: MColor.text_gray,
                  width: Dimens.width_third_logo,
                  height: Dimens.height_third_logo),
              onPressed: () async {
                var obj = isInternational
                    ? await login.authToFacebook(context)
                    : await login.authToWechat(context);
                print('obj=====>$obj');
                if(obj == null) return Toast.show(S.of(context).sharedLoginError);
                UserRepository().sharedAppLogin(isInternational ? Constants.LOGIN_FACEBOOK : Constants.LOGIN_WE_CHAT, obj).then((user){
                  print('======>${user.toString()}');
                  LocalStorage.setString(Constants.KEY_TOKEN, user?.loginToken);
                  LocalStorage.setString(Constants.KEY_AVATAR, 'https:' + user?.avatar);
                  LocalStorage.setString(Constants.KEY_NICKNAME, user?.nickname);
                  MonstorNavigator.gotoProjectsList(context);
                }).catchError((error) {
                  print('======>${error.response.toString()}');
                  Toast.show(S.of(context).sharedLoginError);
                });
              },
            ),
            Gaps.hGap30,
            IconButton(
              icon: Image.asset(
                  Utils.image(isInternational ? Constants.LOGIN_TWITTER : Constants.LOGIN_WEI_BO),
                  color: MColor.text_gray,
                  width: Dimens.width_third_logo,
                  height: Dimens.height_third_logo),
              onPressed: () async {
                var obj = isInternational
                    ? await login.authToTwitter(context)
                    : await login.authToSina(context);
                if(obj == null) return Toast.show(S.of(context).sharedLoginError);
                UserRepository().sharedAppLogin(isInternational ? Constants.LOGIN_TWITTER : Constants.LOGIN_WEI_BO, obj).then((user){
                  print('======>${user.toString()}');
                  LocalStorage.setString(Constants.KEY_TOKEN, user?.loginToken);
                  LocalStorage.setString(Constants.KEY_AVATAR, 'https:' + user?.avatar);
                  LocalStorage.setString(Constants.KEY_NICKNAME, user?.nickname);
                  MonstorNavigator.gotoProjectsList(context);
                }).catchError((error) {
                  print('======>${error.response.toString()}');
                  Toast.show(S.of(context).sharedLoginError);
                });
              },
            ),
          ],
        ),
        Gaps.vGap15,
        Text(
          S.of(context).welcomePrivacy,
          style: TextStyles.littleContent,
        ),
      ],
    );
  }
}
