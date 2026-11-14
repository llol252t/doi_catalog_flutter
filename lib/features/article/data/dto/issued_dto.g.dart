// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issued_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssuedDto _$IssuedDtoFromJson(Map<String, dynamic> json) => IssuedDto(
  dateParts: (json['date-parts'] as List<dynamic>?)
      ?.map((e) => (e as List<dynamic>).map((e) => (e as num).toInt()).toList())
      .toList(),
  dateTime: json['date-time'] as String?,
);

Map<String, dynamic> _$IssuedDtoToJson(IssuedDto instance) => <String, dynamic>{
  'date-parts': instance.dateParts,
  'date-time': instance.dateTime,
};
