import 'package:json_annotation/json_annotation.dart';
import 'works_message_dto.dart';

part 'works_response_dto.g.dart';

@JsonSerializable()
class WorksResponseDto {
  final String status;                 // "ok"
  final WorksMessageDto message;

  const WorksResponseDto({required this.status, required this.message});

  factory WorksResponseDto.fromJson(Map<String, dynamic> json) =>
      _$WorksResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WorksResponseDtoToJson(this);
}