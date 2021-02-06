class PostModel {
  String description;
  String imageUrl;
  String title;
  String key;

  PostModel({this.description, this.imageUrl, this.title});

  PostModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    imageUrl = json['imageUrl'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['title'] = title;
    return data;
  }
}
