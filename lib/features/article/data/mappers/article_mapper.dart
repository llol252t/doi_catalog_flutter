import '../../domain/article_model.dart';
import '../dto/article_dto.dart';

extension ArticleDtoMapper on ArticleDto {
  ArticleModel toModel() {
    return ArticleModel(
      doi: doi ?? '',
      title: title?.firstOrNull ?? '',
      authors: author
          ?.map((a) => '${a.given ?? ''} ${a.family ?? ''}'.trim())
          .toList() ??
          [],
      year: issued?.dateParts?.firstOrNull?.firstOrNull ?? 0,
      journal: containerTitle?.firstOrNull ?? '',
      type: type ?? '',
      abstractText: abstractText
          ?.replaceAll(RegExp(r'<[^>]*>'), '')
          .replaceAll(RegExp(r'\s+'), ' ')
          .trim() ??
          '',
    );
  }
}