import 'package:json_annotation/json_annotation.dart';
import 'author_dto.dart';
import 'issued_dto.dart';

part 'article_dto.g.dart';

@JsonSerializable()
class ArticleDto {
  final String? doi;
  final List<String>? title;
  final List<AuthorDto>? author;
  final IssuedDto? issued;
  @JsonKey(name: 'container-title')
  final List<String>? containerTitle;
  final String? type;
  @JsonKey(name: 'abstract')
  final String? abstractText;

  const ArticleDto({
    this.doi,
    this.title,
    this.author,
    this.issued,
    this.containerTitle,
    this.type,
    this.abstractText,
  });

  factory ArticleDto.fromJson(Map<String, dynamic> json) =>
      _$ArticleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleDtoToJson(this);
}