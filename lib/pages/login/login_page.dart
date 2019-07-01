import 'package:flutter/material.dart';
import 'package:flutter_monster/generated/i18n.dart';
import 'package:flutter_monster/utils/constants.dart';
import 'package:flutter_monster/utils/local_storage.dart';
import 'package:flutter_monster/utils/log.dart';
import 'package:flutter_monster/utils/toast.dart';
import 'package:flutter_monster/blocs/bloc_provider.dart';
import 'package:flutter_monster/pages/login/login_bloc.dart';
import 'package:flutter_monster/utils/monstor_navigator.dart';
import 'package:flutter_monster/utils/styles.dart';
import 'package:flutter_monster/widgets/back_button.dart';
import 'package:flutter_monster/widgets/button.dart';
import 'package:flutter_monster/widgets/flat_button.dart';
import 'package:flutter_monster/widgets/monster_scaffold.dart';
import 'package:flutter_monster/widgets/text_field.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class LoginPage extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
        final LoginBloc bloc = BlocProvider.of<LoginBloc>(context);

        return MonsterScaffold(
            leftButton: MBackButton(),
            title: S.of(context).login,
            child: Column(
                children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                                MTextField(
                                    icon: Icons.phone_iphone,
                                    hint: S.of(context).account,
                                    sink: bloc.getAccount,
                                ),
                                Gaps.vGap10,
                                MTextField(
                                    icon: Icons.lock_outline,
                                    hint: S.of(context).password,
                                    sink: bloc.getPassword,
                                    obscure: true,
                                ),
                                Gaps.vGap40,
                            ],
                        ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                                _buildLoginButton(context, bloc),
                                MFlatButton(
                                    text: S.of(context).forgotPassword,
                                    onPressed: () {
                                        MonstorNavigator.gotoChangeRetrievePassword(context);
                                    },
                                )
                            ],
                        ),
                    )
                ],
            ),
        );
    }

    Widget _buildLoginButton(BuildContext context, LoginBloc bloc) {
        return StreamBuilder<bool>(
            stream: bloc.outIsAvailable,
            initialData: true,
            builder:(BuildContext context, AsyncSnapshot<bool> snapshot) {
                return MButton(
                    text: S.of(context).login,
                    onPressed: snapshot.data ? null : () async {
                        try {
                            await bloc.login();
                            MonstorNavigator.gotoProjectsList(context);
                        } catch(error) {
                            Toast.show(S.of(context).errorPassword);
                        }
                    },
                );
            }
        );
    }
}