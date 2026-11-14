import 'package:json_annotation/json_annotation.dart';

part 'issued_dto.g.dart';

@JsonSerializable()
class IssuedDto {
  @JsonKey(name: 'date-parts')
  final List<List<int>>? dateParts;
  @JsonKey(name: 'date-time')
  final String? dateTime;

  const IssuedDto({this.dateParts, this.dateTime});

  factory IssuedDto.fromJson(Map<String, dynamic> json) =>
      _$IssuedDtoFromJson(json);

  Map<String, dynamic> toJson() => _$IssuedDtoToJson(this);
}