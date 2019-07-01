import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_monster/blocs/bloc_provider.dart';
import 'package:flutter_monster/models/ble_device.dart';
import 'package:flutter_monster/models/project.dart';
import 'package:flutter_monster/pages/change_password/change_password_bloc.dart';
import 'package:flutter_monster/pages/change_password/change_password_page.dart';
import 'package:flutter_monster/pages/kit_choose/kit_choose_bloc.dart';
import 'package:flutter_monster/pages/kit_choose/kit_choose_page.dart';
import 'package:flutter_monster/pages/kit_connector/kit_connector_bloc.dart';
import 'package:flutter_monster/pages/kit_connector/kit_connector_page.dart';
import 'package:flutter_monster/pages/login/login_bloc.dart';
import 'package:flutter_monster/pages/login/login_page.dart';
import 'package:flutter_monster/pages/profile/profile_bloc.dart';
import 'package:flutter_monster/pages/profile/profile_page.dart';
import 'package:flutter_monster/pages/project/project_bloc.dart';
import 'package:flutter_monster/pages/project/project_page.dart';
import 'package:flutter_monster/pages/projects_list/projects_list_bloc.dart';
import 'package:flutter_monster/pages/projects_list/projects_list_page.dart';
import 'package:flutter_monster/pages/settings/settings_bloc.dart';
import 'package:flutter_monster/pages/settings/settings_page.dart';
import 'package:flutter_monster/pages/welcome/welcome_bloc.dart';
import 'package:flutter_monster/pages/welcome/welcome_page.dart';
import 'package:flutter_monster/pages/register/register_bloc.dart';
import 'package:flutter_monster/pages/register/register_page.dart';
import 'package:flutter_monster/pages/verify_code/verify_code_bloc.dart';
import 'package:flutter_monster/pages/verify_code/verify_code_page.dart';

import 'package:flutter_monster/pages/password/password_bloc.dart';
import 'package:flutter_monster/pages/password/password_page.dart';
import 'package:flutter_monster/pages/retrieve_password/retrieve_password_bloc.dart';
import 'package:flutter_monster/pages/retrieve_password/retrieve_password_page.dart';
import 'package:flutter_monster/models/gee_test.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';
import 'log.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class MonstorNavigator {
    static Future pushPage(BuildContext context, Widget page) {
        return Navigator.push(context,
            new CupertinoPageRoute<void>(
                builder: (BuildContext context) => page));
    }

    static void pushReplacePage(BuildContext context, Widget page) {
        if (context == null || page == null) return;
        Navigator.pushAndRemoveUntil(
            context,
            new CupertinoPageRoute<void>(
                builder: (BuildContext context) => page),
                (Route<dynamic> route) => false);
    }

    static void pushReplacePageNoRemove(BuildContext context, Widget page) {
        if (context == null || page == null) return;
        Navigator.pushReplacement(
            context,
            new CupertinoPageRoute<void>(
                builder: (BuildContext context) => page));
    }

    static Future<Null> launchInBrowser(String url, {String title}) async {
        if (await canLaunch(url)) {
            await launch(url, forceSafariVC: false, forceWebView: false);
        } else {
            throw 'Could not launch $url';
        }
    }


    static void popPage(BuildContext context, {bool ret}) {
        Navigator.pop(context, ret);
    }

    static void gotoWelcome(BuildContext context) {
        pushReplacePage(
            context,
            BlocProvider<WelcomeBloc>(
                bloc: WelcomeBloc(),
                child: WelcomePage(),
            ));
    }

    static void gotoLogin(BuildContext context) {
        pushPage(
            context,
            BlocProvider<LoginBloc>(
                bloc: LoginBloc(),
                child: LoginPage(),
            ));
    }

    static void gotoProjectsList(BuildContext context) {
        pushReplacePage(
            context,
            BlocProvider<ProjectsListBloc>(
                bloc: ProjectsListBloc(),
                child: ProjectsListPage(),
            ));
    }

    static void gotoProject(BuildContext context, Project project) {
        pushPage(
            context,
            BlocProvider<ProjectBloc>(
                bloc: ProjectBloc(
                    project.id
                ),
                child: ProjectPage(
                    title: project.title
                ),
            ));
    }

    static void gotoProfile(BuildContext context) {
        pushPage(
            context,
            BlocProvider<ProfileBloc>(
                bloc: ProfileBloc(),
                child: ProfilePage(),
            ));
    }

    static void gotoSettings(BuildContext context) {
        pushPage(
            context,
            BlocProvider<SettingsBloc>(
                bloc: SettingsBloc(),
                child: SettingsPage(),
            ));
    }

    static void gotoChangePwd(BuildContext context) {
        pushPage(
            context,
            BlocProvider<ChangePasswordBloc>(
                bloc: ChangePasswordBloc(),
                child: ChangePasswordPage(),
            ));
    }

    static void gotoChangeRegister(BuildContext context) {
        pushPage(
            context,
            BlocProvider<RegisterBloc>(
                bloc: RegisterBloc(),
                child: RegisterPage(),
            ));
    }

    static void gotoChangeRetrievePassword(BuildContext context) {
        pushPage(
            context,
            BlocProvider<RetrievePasswordBloc>(
                bloc: RetrievePasswordBloc(),
                child: RetrievePasswordPage(),
            ));
    }

    static void gotoVerifyCode(BuildContext context, String account,
        String verifyCodeToken, Gt gt, bool isRegister) {
        pushPage(
            context,
            BlocProvider<VerifyCodeBloc>(
                bloc: VerifyCodeBloc(),
                child: VerifyCodePage(account: account,
                    verifyCodeToken: verifyCodeToken,
                    gt: gt,
                    isRegister: isRegister),
            ));
    }

    static void gotoSetPassword(BuildContext context, String account,
        String verifyCode, String verifyCodeToken, bool isRegister) {
        pushPage(
            context,
            BlocProvider<PasswordBloc>(
                bloc: PasswordBloc(),
                child: PasswordPage(account: account,
                    verifyCode: verifyCode,
                    verifyCodeToken: verifyCodeToken,
                    isRegister: isRegister),
            ));
    }

    static Future gotoKitChoosePage(BuildContext context, String kit) {
        return pushPage(
            context,
            BlocProvider<KitChooseBloc>(
                bloc: KitChooseBloc(kit),
                child: KitChoosePage(),
            ));
    }

    static Future gotoKitConnect(BuildContext context, String kit,
        {String state, BleDevice device}) {
        return pushPage(
            context,
            BlocProvider<KitConnectorBloc>(
                bloc: KitConnectorBloc(
                    kit,
                    state?? Constants.CONNECT_STATE_DISCONNECT,
                    device: device),
                child: KitConnectorPage(),
            ));
    }

}
