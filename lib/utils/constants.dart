/*
 * Created by gloria on 2018/1/9.
 */

class Constants {

    static const String KEY_USER_CENTER_ADDRESS = 'key_user_center_address';
    static const String KEY_PROJECTS_ADDRESS = 'key_projects_address';
    static const String KEY_LANGUAGE = 'key_language';
    static const String KEY_USER_NAME = 'key_user_name';
    static const String KEY_PASSWORD = 'key_password';
    static const String KEY_NICKNAME = 'key_nickname';
    static const String KEY_AVATAR = 'key_avatar';
    static const String KEY_TOKEN = 'key_user_token';
    static const String KEY_CURRENT_KIT = 'key_current_kit';
    static const String KEY_SERVER_USER_DATA = 'key_server_user_data';

    static const String KIT_MCOOKIE = 'mCookie';
    static const String KIT_BUGGY = 'IBB';
    static const String KIT_IDEABOX = 'ideaBox';
    static const String KIT_IRONMAN = 'ideaBot';

    static const List<String> LIST_SUPPORTED_KITS =
        [KIT_MCOOKIE, KIT_BUGGY, KIT_IDEABOX, KIT_IRONMAN];

    static const String CONNECT_STATE_CONNECTED = 'connected';
    static const String CONNECT_STATE_DISCONNECT = 'disconnected';
    static const String CONNECT_STATE_READY = 'ready';

    static const String LOGIN_WE_CHAT = 'wechat';
    static const String LOGIN_FACEBOOK = 'facebook';
    static const String LOGIN_WEI_BO = 'weibo';
    static const String LOGIN_TWITTER = 'twitter';

    static const String PATH_IMAGES = 'assets/images/';

    static const String USER_CENTER_INTERNATIONAL = 'https://accounts.microduino.cc';
    static const String USER_CENTER_LOCAL = 'https://accounts.microduino.cn';
    // static const String USER_CENTER_LOCAL = 'http://user-center-api.office.microduino.cn/'; // test server

    static const String PROJECTS_INTERNATIONAL = 'https://project.ideaxlab.net';
    static const String PROJECTS_LOCAL = 'https://project.ideaxlab.cn';
    // static const String PROJECTS_LOCAL = 'http://project-api.office.microduino.cn'; // test server

    static const int STATUS_SUCCESS = 0;

    static const String HTTP_METHOD_GET = 'GET';
    static const String HTTP_METHOD_POST = 'POST';
    static const String HTTP_METHOD_PUT = 'PUT';
    static const String HTTP_METHOD_HEAD = 'HEAD';
    static const String HTTP_METHOD_DELETE = 'DELETE';
    static const String HTTP_METHOD_PATCH = 'PATCH';

    static const String URL_PATH_LOGIN = '/user/longLogin';
    static const String URL_PATH_PROJECTS = '/project/myLists?limit=%d&skip=%d';
    static const String URL_PATH_VERIFY_CODE = '/user/verifyCode?checkUsername=%s';              /// 发送验证码
    static const String URL_PATH_UPDATE_PROJECT = '/project/info/%s';
    static const String URL_PATH_DELETE_PROJECT = '/project/all/%s';
    static const String URL_PATH_CHECK_VERIFY_CODE = '/user/checkVerifyCode';                    /// 检验验证码是否正确
    static const String URL_PATH_CHECK_EXISTS = '/user/checkExists';                             /// 检验用户是否存在
	static const String URL_PATH_REGISTER = '/user/register/verifyCode';                         /// 注册
	static const String URL_PATH_RESET_PASSWORD = '/user/resetPassword';                         /// 重置密码
    static const String URL_PATH_CHANGE_PASSWORD = '/user/changePassword';                       /// 修改密码
    static const String URL_PATH_GT3 = '/base/captcha';                                          /// 极验
    static const String URL_PATH_SHARED_APP_LOGIN = '/Shared/app/login';                         /// 第三方登陆

    static const int CONNECT_TIMEOUT = 5000;
    static const int RECEIVE_TIMEOUT = 3000;
    static const int PAGE_LIMIT = 20;

    static const int GRID_AXIS_COUNT = 4;

    static const int MENU_ITEM_EDIT = 0;
    static const int MENU_ITEM_DELETE = 1;

    static const String DEFAULT_LOCALE = 'en-US';

}
