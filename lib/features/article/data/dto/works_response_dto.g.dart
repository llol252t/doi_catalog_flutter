// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'works_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorksResponseDto _$WorksResponseDtoFromJson(Map<String, dynamic> json) =>
    WorksResponseDto(
      status: json['status'] as String,
      message: WorksMessageDto.fromJson(
        json['message'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$WorksResponseDtoToJson(WorksResponseDto instance) =>
    <String, dynamic>{'status': instance.status, 'message': instance.message};
