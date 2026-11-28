import '../../domain/article_model.dart';
import '../dto/article_dto.dart';

extension ArticleDtoMapper on ArticleDto {
  ArticleModel toModel() {
    return ArticleModel(
      doi: doi ?? '',
      title: _cleanText(title?.firstOrNull),
      authors: author
          ?.map((a) => '${a.given ?? ''} ${a.family ?? ''}'.trim())
          .where((name) => name.isNotEmpty)
          .toList() ??
          [],
      year: issued?.dateParts?.firstOrNull?.firstOrNull ?? 0,
      journal: _cleanText(containerTitle?.firstOrNull),
      type: type ?? '',
      abstractText: _cleanText(abstractText),
    );
  }

  String _cleanText(String? value) {
    if (value == null) return '';
    var text = value.replaceAll(RegExp(r'<[^>]*>'), '');
    text = text
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'");
    return text.replaceAll(RegExp(r'\s+'), ' ').trim();
  }
}
