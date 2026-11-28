import 'package:json_annotation/json_annotation.dart';

part 'author_dto.g.dart';

@JsonSerializable()
class AuthorDto {
  final String? given;    // имя
  final String? family;   // фамилия

  const AuthorDto({this.given, this.family});

  factory AuthorDto.fromJson(Map<String, dynamic> json) =>
      _$AuthorDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorDtoToJson(this);
}