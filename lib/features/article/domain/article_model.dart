class ArticleModel {
  final String doi;
  final String title;
  final List<String> authors;
  final int year;
  final String journal;
  final String type;
  final String abstractText;

  const ArticleModel({
    required this.doi,
    required this.title,
    required this.authors,
    required this.year,
    required this.journal,
    required this.type,
    required this.abstractText,
  });
}