import 'package:json_annotation/json_annotation.dart';
import 'article_dto.dart';

part 'work_response_dto.g.dart';

@JsonSerializable()
class WorkResponseDto {
  final String status;
  final ArticleDto message;   // здесь message — ОДНА статья, без items

  const WorkResponseDto({required this.status, required this.message});

  factory WorkResponseDto.fromJson(Map<String, dynamic> json) =>
      _$WorkResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WorkResponseDtoToJson(this);
}