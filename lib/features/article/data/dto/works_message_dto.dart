import 'package:json_annotation/json_annotation.dart';
import 'article_dto.dart';

part 'works_message_dto.g.dart';

@JsonSerializable()
class WorksMessageDto {
  @JsonKey(name: 'total-results')
  final int totalResults;          // сколько всего записей (для пагинации)
  final List<ArticleDto> items;    // сами статьи
  @JsonKey(name: 'next-cursor')
  final String? nextCursor;        // курсор следующей страницы

  const WorksMessageDto({
    required this.totalResults,
    required this.items,
    this.nextCursor,
  });

  factory WorksMessageDto.fromJson(Map<String, dynamic> json) =>
      _$WorksMessageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WorksMessageDtoToJson(this);
}