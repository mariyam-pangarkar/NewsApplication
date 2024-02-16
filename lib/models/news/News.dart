class News {
  String status;
  int totalResults;
  List<Article> articles;

  News({required this.status, required this.totalResults, required this.articles});

  factory News.fromJson(Map<String, dynamic> json) {
    var articlesList = json['articles'] as List;
    List<Article> articles = articlesList.map((article) => Article.fromJson(article)).toList();

    return News(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: articles,
    );
  }
}

class Article {
  String? sourceId;
  String sourceName;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  Article({
    required this.sourceId,
    required this.sourceName,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      sourceId: json['source']['id'],
      sourceName: json['source']['name']??'',
      author: json['author'] ?? 'Unknown Author',
      title: json['title']??'',
      description: json['description']??'',
      url: json['url']??'',
      urlToImage: json['urlToImage']??'',
      publishedAt: json['publishedAt']??'',
      content: json['content']??'',
    );
  }
}
