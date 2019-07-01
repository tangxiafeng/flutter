import 'package:flutter/widgets.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class Dimens {
    static const double font_sp10 = 10;
    static const double font_sp12 = 12;
    static const double font_sp14 = 14;
    static const double font_sp16 = 16;
    static const double font_sp18 = 18;
    static const double font_sp20 = 20;

    static const double gap_dp5 = 5;
    static const double gap_dp10 = 10;
    static const double gap_dp15 = 15;
    static const double gap_dp30 = 30;
    static const double gap_dp40 = 40;
    static const double gap_dp50 = 50;
    static const double gap_dp80 = 80;
    static const double gap_dp100 = 100;

    static const double height_Navigation = 56;

    static const double width_button = 400;
    static const double height_button = 50;

    static const double width_border_button = 120;
    static const double height_border_button = 50;

    static const double width_logo = 87;
    static const double height_logo = 78;

    static const double width_nav_button = 30;
    static const double height_nav_button = 30;

    static const double width_third_logo = 30;
    static const double height_third_logo = 24;

    static const double width_text_field = 399;

    static const double width_loading = 24;
    static const double height_loading = 24;

    static const double width_profile_avatar = 80;
    static const double height_profile_avatar = 80;

    static const double width_project_item = 200;
    static const double height_project_item = 200;

    static const double width_kit_item = 390;
    static const double height_kit_item = 370;

    static const double height_project_info = 40;

    static const double size_new_project_icon = 48;
    static const double size_blue_button = 42;
}

class MColor {
    static const Color background = Color(0xFFF8F8F8);

    static const Color app_main = Color(0xFFFFFFFF);

    static const Color button_normal = Color(0xFF4C97FF);
    static const Color button_disabled = Color(0xFFD8D8D8);

    static const Color text_gray = Color(0xFFADB1B5);
    static const Color text_black = Color(0xFF333333);

    static const Color divider = Color(0xFFe5e5e5);

    static const List<Color> connectState = [
        Color(0xFFFF0D0D), Color(0xFF4C97FF), Color(0xFF66E361)];
}

class TextStyles {
    static TextStyle mainContent = TextStyle(
        fontSize: Dimens.font_sp16,
        color: MColor.app_main,
    );

    static TextStyle mainBlackContent = TextStyle(
        fontSize: Dimens.font_sp16,
        color: MColor.text_black,
    );

    static TextStyle hintContent = TextStyle(
        fontSize: Dimens.font_sp16,
        color: MColor.text_gray,
    );

    static TextStyle blackContent = TextStyle(
        fontSize: Dimens.font_sp14,
        color: MColor.text_black,
    );

    static TextStyle littleContent = TextStyle(
        fontSize: Dimens.font_sp14,
        color: MColor.text_gray,
    );

    static TextStyle titleContent = TextStyle(
        fontSize: Dimens.font_sp20,
        color: MColor.text_black,
    );

    static TextStyle flatButtonContent = TextStyle(
        fontSize: Dimens.font_sp16,
        color: MColor.button_normal,
    );
}

class Decorations {
    static Decoration bottom = BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.33, color: MColor.divider)));
}

class Gaps {
    static Widget hGap5 = new SizedBox(width: Dimens.gap_dp5);
    static Widget hGap10 = new SizedBox(width: Dimens.gap_dp10);
    static Widget hGap15 = new SizedBox(width: Dimens.gap_dp15);
    static Widget hGap30 = new SizedBox(width: Dimens.gap_dp30);

    static Widget vGap5 = new SizedBox(height: Dimens.gap_dp5);
    static Widget vGap10 = new SizedBox(height: Dimens.gap_dp10);
    static Widget vGap15 = new SizedBox(height: Dimens.gap_dp15);
    static Widget vGap30 = new SizedBox(height: Dimens.gap_dp30);
    static Widget vGap40 = new SizedBox(height: Dimens.gap_dp40);
    static Widget vGap50 = new SizedBox(height: Dimens.gap_dp50);
    static Widget vGap80 = new SizedBox(height: Dimens.gap_dp80);
}
