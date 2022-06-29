class ArticleModel {
  String imageUrl;
  String title;
  String url;

  ArticleModel({required this.imageUrl, required this.title, required this.url});

  ArticleModel.fromJson(Map<String, dynamic> json)
      : imageUrl = json['imageUrl'],
        title = json['title'],
        url = json['url'];

  toJson() => {
        'imageUrl': imageUrl,
        'title': title,
        'url': url,
      };
}
