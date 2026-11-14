// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleDto _$ArticleDtoFromJson(Map<String, dynamic> json) => ArticleDto(
  doi: json['doi'] as String?,
  title: (json['title'] as List<dynamic>?)?.map((e) => e as String).toList(),
  author: (json['author'] as List<dynamic>?)
      ?.map((e) => AuthorDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  issued: json['issued'] == null
      ? null
      : IssuedDto.fromJson(json['issued'] as Map<String, dynamic>),
  containerTitle: (json['container-title'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  type: json['type'] as String?,
  abstractText: json['abstract'] as String?,
);

Map<String, dynamic> _$ArticleDtoToJson(ArticleDto instance) =>
    <String, dynamic>{
      'doi': instance.doi,
      'title': instance.title,
      'author': instance.author,
      'issued': instance.issued,
      'container-title': instance.containerTitle,
      'type': instance.type,
      'abstract': instance.abstractText,
    };
