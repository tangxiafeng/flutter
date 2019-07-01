import 'package:flutter/material.dart';
import 'package:flutter_monster/blocs/bloc_provider.dart';
import 'package:flutter_monster/pages/retrieve_password/retrieve_password_bloc.dart';
import 'package:flutter_monster/utils/styles.dart';
import 'package:flutter_monster/widgets/back_button.dart';
import 'package:flutter_monster/widgets/button.dart';
import 'package:flutter_monster/widgets/monster_scaffold.dart';
import 'package:flutter_monster/widgets/text_field.dart';
import 'package:flutter_monster/widgets/register_page_button.dart';
import 'package:flutter_monster/utils/monstor_navigator.dart';
import 'package:flutter_monster/generated/i18n.dart';
import 'package:flutter_monster/utils/utils.dart';
import 'package:flutter_monster/utils/toast.dart';
import 'package:flutter_monster/models/gee_test.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class RetrievePasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RetrievePasswordBloc bloc = BlocProvider.of<RetrievePasswordBloc>(context);

    return MonsterScaffold(
      leftButton: MBackButton(),
      title: S.of(context).resetPassword,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: Dimens.width_text_field,
                  child: _buildButton(context, bloc),
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

  Widget _buildButton(BuildContext context, RetrievePasswordBloc bloc) {
    return StreamBuilder<bool>(
        stream: bloc.outAvailable,
        initialData: true,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              MRegisterPageButton(
                text: S.of(context).phone,
                onPressed: () {
                  bloc.getType.add('phone');
                },
                setTextColor: snapshot.data,
              ),
              MRegisterPageButton(
                text: S.of(context).email,
                onPressed: () {
                  bloc.getType.add('email');
                },
                setTextColor: !snapshot.data,
              ),
            ],
          );
        });
  }

  Widget _buildMTextField(BuildContext context, RetrievePasswordBloc bloc) {
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

  Widget _buildIconButton(BuildContext context, RetrievePasswordBloc bloc) {
    return StreamBuilder<bool>(
        stream: bloc.outHidden,
        initialData: true,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return IconButton(
              icon: Image.asset(
                Utils.image('delete'),
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

  Widget _buildRegisterButton(BuildContext context, RetrievePasswordBloc bloc) {
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
                              obj["geetest_validate"]), false);
                    }).catchError((error) {
                    	print('error====>${error.response}');
                      Toast.show(S.of(context).accountAlreadyExists);
                    });
                  },
          );
        });
  }
}
