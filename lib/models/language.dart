/*
 * Created by gloria on 2018/1/9.
 */
class Language {
    String languageCode;
    String countryCode;

    Language(this.languageCode, this.countryCode);

    Language.fromJson(Map<String, dynamic> json)
        : languageCode = json['languageCode'],
            countryCode = json['countryCode'];

    @override
    String toString() {
        StringBuffer sb = new StringBuffer('{');
        sb.write("\"languageCode\":\"$languageCode\"");
        sb.write(",\"countryCode\":\"$countryCode\"");
        sb.write('}');
        return sb.toString();
    }
}