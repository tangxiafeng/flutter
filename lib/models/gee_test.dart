
class Gt {
  String challenge;
  String seccode;
  String validate;

  Gt(this.challenge, this.seccode, this.validate);

  Gt.fromJson(Map<String, dynamic> json) : challenge = json['challenge'],
        seccode = json['seccode'],
        validate = json['validate'];

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write('\"challenge\":\"$challenge\"');
    sb.write(',\"seccode\":\"$seccode\"');
    sb.write(',\"validate\":\"$validate\"');
    sb.write('}');
    return sb.toString();
  }
}

