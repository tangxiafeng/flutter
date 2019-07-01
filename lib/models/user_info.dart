class UserInfo {
    String openId;
    String app;
    String nickname;
    String avatar;
    Map<String, dynamic> phone;
    Map<String, dynamic> email;
    String loginToken;

    UserInfo(
        this.openId, this.app, this.nickname, this.avatar, this.loginToken,
        {this.phone, this.email});

    UserInfo.fromJson(Map<String, dynamic> json) :
            openId = json['openId'],
            app = json['app'],
            nickname = json['nickname'],
            avatar = json['avatar'],
            email = json['email'],
            phone = json['phone'],
            loginToken = json['loginToken'];

    String toString() {
        StringBuffer sb = new StringBuffer('{');
        sb.write('\"openId\":\"$openId\"');
        sb.write(',\"app\":\"$app\"');
        sb.write(',\"nickname\":\"$nickname\"');
        sb.write(',\"avatar\":\"$avatar\"');
        sb.write(',\"loginToken\":\"$loginToken\"');
        sb.write(',\"phone\":$phone');
        sb.write(',\"email\":$email');
        sb.write('}');
        return sb.toString();
    }
}
// phone: {name: 15300178737, verified: true}
// email: {name: 425997031@qq.com, verified: true}
// profile: {nickname: shi, trueName: , email: shilixin@microduino.cc, phone: , signature: , gender: 0, school: []}