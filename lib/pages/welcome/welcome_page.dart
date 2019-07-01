import 'package:flutter/material.dart';
import 'package:flutter_monster/blocs/bloc_provider.dart';
import 'package:flutter_monster/generated/i18n.dart';
import 'package:flutter_monster/pages/welcome/welcome_bloc.dart';
import 'package:flutter_monster/utils/styles.dart';
import 'package:flutter_monster/widgets/monster_scaffold.dart';
import 'package:flutter_monster/widgets/third_login.dart';
import 'package:flutter_monster/widgets/welcome.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final WelcomeBloc bloc = BlocProvider.of<WelcomeBloc>(context);

    return StreamBuilder<bool>(
        stream: bloc.outIsInternational,
        initialData: bloc.isInternational(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            return MonsterScaffold(
                title: '',
                rightButton: FlatButton(
                    onPressed: () {
                        bloc.changeServer();
                    },
                    child: Text(
                        snapshot.data ? S.of(context).local
                            : S.of(context).international,
                        style: TextStyles.flatButtonContent,
                    )),
                child: Column(children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Welcome(),
                  ),
                  Expanded(
                      flex: 0,
                      child: ThirdLogin(isInternational: snapshot.data),
                  ),
                ]),
            );
        });
    }
}
