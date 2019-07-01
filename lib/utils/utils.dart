import 'package:flutter_monster/utils/constants.dart';
import 'package:flutter_monster/utils/local_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class Utils {
    static String image(String name, {String format: 'png'}) {
        return 'assets/images/$name.$format';
    }

    static bool isEmailAccount() {
        String account = LocalStorage.getString(Constants.KEY_USER_NAME);
        return account.contains('@') ? true : false;
    }

    static double setWidth(double width) {
        return ScreenUtil().setWidth(width.toInt());
    }

    static double setHeight(double height) {
        return ScreenUtil().setHeight(height.toInt());
    }

    static double setFontSize(double sp) {
        return ScreenUtil().setSp(sp.toInt());
    }

    static bool isPhone(String str) {
        return new RegExp('^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$').hasMatch(str);
    }

    static bool isEmail(String str) {
        return new RegExp("^[_a-z0-9-]+(\\.[_a-z0-9-]+)*@[a-z0-9-]+(\\.[a-z0-9-]+)*(\\.[a-z]{2,})\$").hasMatch(str);
    }

    static Map gt3(String str) {
        var array = str.split('&');
        Map result = new Map();
        for (String index in array){
            if(index == "") break;
            var keyValue = index.split('=');
            result[keyValue[0]] = keyValue[1];
        }
        return result;
    }
}