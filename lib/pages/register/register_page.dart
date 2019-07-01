import 'package:flutter/material.dart';
import 'package:flutter_monster/blocs/bloc_provider.dart';
import 'package:flutter_monster/pages/register/register_bloc.dart';
import 'package:flutter_monster/utils/styles.dart';
import 'package:flutter_monster/widgets/back_button.dart';
import 'package:flutter_monster/widgets/button.dart';
import 'package:flutter_monster/widgets/monster_scaffold.dart';
import 'package:flutter_monster/widgets/text_field.dart';
import 'package:flutter_monster/utils/monstor_navigator.dart';
import 'package:flutter_monster/generated/i18n.dart';
import 'package:flutter_monster/utils/utils.dart';
import 'package:flutter_monster/utils/toast.dart';
import 'package:flutter_monster/models/gee_test.dart';
import 'package:flutter_monster/models/page_view_title.dart';
import 'package:flutter_monster/widgets/page_view.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final RegisterBloc bloc = BlocProvider.of<RegisterBloc>(context);

    return MonsterScaffold(
      leftButton: MBackButton(),
      title: S.of(context).registerTitle,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: Dimens.width_text_field,
                  child: MyPageView(tabList:[
                      new TabTitle(S.of(context).phone, 'phone'),
                      new TabTitle(S.of(context).email, 'email')
                  ], sink: bloc.getType),
                ),
                Gaps.vGap30,
                _buildMTextField(context, bloc),
                Gaps.vGap50,
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[_buildRegisterButton(context, bloc)],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMTextField(BuildContext context, RegisterBloc bloc) {
    return StreamBuilder<bool>(
        stream: bloc.outAvailable,
        initialData: true,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return MTextField(
              icon: snapshot.data ? Icons.phone_iphone : Icons.mail_outline,
              controller: bloc.controller,
              hint: snapshot.data
                  ? S.of(context).pleaseInputPhone
                  : S.of(context).pleaseInputEmail,
              sink: bloc.getAccount,
              suffix: _buildIconButton(context, bloc));
        });
  }

  Widget _buildIconButton(BuildContext context, RegisterBloc bloc) {
    return StreamBuilder<bool>(
        stream: bloc.outHidden,
        initialData: true,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return IconButton(
              icon: Image.asset(
                  snapshot.data ? '' : Utils.image('delete'),
                  width: Dimens.width_third_logo,
                  height: Dimens.height_third_logo,
                  color: MColor.text_gray,
              ),
              onPressed: snapshot.data
                  ? null
                  : () {
                      bloc.controller.clear();
                      bloc.getAccount.add('');
                    });
        });
  }

  Widget _buildRegisterButton(BuildContext context, RegisterBloc bloc) {
    return StreamBuilder<bool>(
        stream: bloc.outIsAvailable,
        initialData: true,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return MButton(
            text: S.of(context).sendCode,
            onPressed: snapshot.data
                ? null
                : () async {
                    String gt3Result = await bloc.showGt3();
                    Map obj = Utils.gt3(gt3Result);
                    bloc
                        .sendVerifyCode(obj["geetest_challenge"],
                            obj["geetest_seccode"], obj["geetest_validate"])
                        .then((result) {
                      MonstorNavigator.gotoVerifyCode(
                          context,
                          bloc.account,
                          result,
                          Gt(obj["geetest_challenge"], obj["geetest_seccode"],
                              obj["geetest_validate"]), true);
                    }).catchError((error) {
                        Toast.show(S.of(context).accountAlreadyExists);
                    });
                  },
          );
        });
  }
}
