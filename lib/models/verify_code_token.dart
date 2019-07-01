class VerifyCodeToken {
	String verifyCodeToken;

	VerifyCodeToken(this.verifyCodeToken);

	VerifyCodeToken.fromJson(Map<String, dynamic> json) : verifyCodeToken = json['verifyCodeToken'];

	@override
	String toString() {
		StringBuffer sb = new StringBuffer('{');
		sb.write('\"verifyCodeToken\":\"$verifyCodeToken\"');
		sb.write('}');
		return sb.toString();
	}

}