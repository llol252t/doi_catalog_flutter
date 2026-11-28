// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'works_message_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorksMessageDto _$WorksMessageDtoFromJson(Map<String, dynamic> json) =>
    WorksMessageDto(
      totalResults: (json['total-results'] as num).toInt(),
      items: (json['items'] as List<dynamic>)
          .map((e) => ArticleDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextCursor: json['next-cursor'] as String?,
    );

Map<String, dynamic> _$WorksMessageDtoToJson(WorksMessageDto instance) =>
    <String, dynamic>{
      'total-results': instance.totalResults,
      'items': instance.items,
      'next-cursor': instance.nextCursor,
    };
