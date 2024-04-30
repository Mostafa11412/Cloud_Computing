class UrlModel {
  String id;
  String? url;

  UrlModel({this.id = "" , required this.url});

  UrlModel.fromJson(Map<String, dynamic> json)
      : this(
          url: json['url'],
          id: json['id'],
        );

  Map<String, dynamic> toJson() {
    return {"id": id, "url": url};
  }
}
