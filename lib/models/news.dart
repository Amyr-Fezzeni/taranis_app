import 'dart:convert';

class News {
  final String title;
  final String link;
  final String date;
  final String source;
  final String sourceLink;
  String details;
  final List<String> tags;
  News({
    required this.title,
    required this.link,
    required this.date,
    required this.source,
    required this.sourceLink,
    required this.tags,
    this.details = ""
  });

  @override
  String toString() {
    return 'News(title: $title, link: $link, date: $date, source: $source, sourceLink: $sourceLink, tags: $tags, details:$details)\n';
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'link': link,
      'date': date,
      'source': source,
      'details':details,
      'sourceLink': sourceLink,
      'tags': tags,
    };
  }

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      title: map['title'] ?? "",
      link: map['link'] ?? "",
      date: map['date'] ?? "",
      details: map['details']??"",
      source: map['source'] ?? "",
      sourceLink: map['sourceLink'] ?? "",
      tags: List<String>.from(map['tags'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory News.fromJson(String source) => News.fromMap(json.decode(source));
}
