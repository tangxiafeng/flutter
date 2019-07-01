import 'package:flutter/material.dart';
import 'package:flutter_monster/generated/i18n.dart';
import 'package:flutter_monster/widgets/back_button.dart';
import 'package:flutter_monster/widgets/monster_scaffold.dart';
import 'package:flutter_monster/pages/change_password/change_password_bloc.dart';
import 'package:flutter_monster/blocs/bloc_provider.dart';
import 'package:flutter_monster/widgets/text_field.dart';
import 'package:flutter_monster/utils/styles.dart';
import 'package:flutter_monster/widgets/button.dart';
import 'package:flutter_monster/utils/toast.dart';
import 'package:flutter_monster/utils/utils.dart';
import 'package:flutter_monster/utils/monstor_navigator.dart';

class ChangePasswordPage extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
	    final ChangePasswordBloc bloc = BlocProvider.of<ChangePasswordBloc>(context);



	    return MonsterScaffold(
		    leftButton: MBackButton(),
		    title: S.of(context).changePassword,
		    child: Column(
			    children: <Widget>[
				    Expanded(
					    flex: 1,
					    child: Column(
						    mainAxisAlignment: MainAxisAlignment.end,
						    children: <Widget>[
							    _buildMTextField(context, bloc),
							    Gaps.vGap50,
						    ],
					    ),
				    ),
				    Expanded(
					    flex: 1,
					    child: Column(
						    mainAxisAlignment: MainAxisAlignment.start,
						    children: <Widget>[
							    _buildSaveButton(context, bloc)
						    ],
					    ),
				    )
			    ],
		    ),
	    );
    }

    Widget _buildMTextField(BuildContext context, ChangePasswordBloc bloc) {
	    return StreamBuilder<bool>(
		    stream: bloc.outIsHidden,
		    initialData: true,
		    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
			    return MTextField(
				    icon: Icons.lock_outline,
				    hint: S
					    .of(context)
					    .password,
				    sink: bloc.getPassword,
				    obscure: snapshot.data,
				    suffix: IconButton(
					    icon: snapshot.data
						    ? (Image.asset(
						    Utils.image('eye'),
						    width: Dimens.width_third_logo,
						    height: Dimens.height_third_logo,
						    color: MColor.text_gray,
					    ))
						    : Icon(Icons.remove_red_eye),
					    onPressed: () {
						    bloc.getHidden.add('');
					    }));
		    });
    }

    Widget _buildSaveButton(BuildContext context, ChangePasswordBloc bloc) {
	    return StreamBuilder<bool>(
		    stream: bloc.outIsAvailable,
		    initialData: true,
		    builder:(BuildContext context, AsyncSnapshot<bool> snapshot) {
			    return MButton(
				    text: S.of(context).confirmTheChange,
				    onPressed: snapshot.data ? null : () {
					    bloc.changePassword().then((result) {
						    Toast.show(S.of(context).editPasswordSuccess);
						    bloc.setLocalPassword();
						    MonstorNavigator.gotoProjectsList(context);///作品列表页
					    }).catchError((error) {
						    print('error====>${error.response}');
						    Toast.show(error.response.toString());
					    });
				    },
			    );
		    }
	    );
    }
}