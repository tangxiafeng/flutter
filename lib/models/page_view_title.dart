class TabTitle {
	String title;
	String sinkStr;

	TabTitle(this.title, this.sinkStr);

	TabTitle.fromJson(Map<String, dynamic> json) {
		title = json['title'];
		sinkStr = json['sinkStr'];
	}

	@override
	String toString() {
		StringBuffer sb = new StringBuffer('{');
		sb.write(',\"title\":\"$title\"');
		sb.write(',\"sinkStr\":\"$sinkStr\"');
		sb.write('}');
		return sb.toString();
	}
}