// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkResponseDto _$WorkResponseDtoFromJson(Map<String, dynamic> json) =>
    WorkResponseDto(
      status: json['status'] as String,
      message: ArticleDto.fromJson(json['message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WorkResponseDtoToJson(WorkResponseDto instance) =>
    <String, dynamic>{'status': instance.status, 'message': instance.message};
