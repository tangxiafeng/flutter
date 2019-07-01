
class Project {
    String id;
    String title;
    String image;

    Project(this.id, {this.title, this.image});

    Project.fromJson(Map<String, dynamic> json) {
        id = json['_id'];
        title = json['title'];
        image = json['image'];
        if (image != null) {
            image = 'https:' + image;
        }
    }

    @override
    String toString() {
        StringBuffer sb = new StringBuffer('{');
        sb.write('\"id\":\"$id\"');
        sb.write(',\"title\":\"$title\"');
        sb.write(',\"image\":\"$image\"');
        sb.write('}');
        return sb.toString();
    }
}