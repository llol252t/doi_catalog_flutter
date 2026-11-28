import 'package:json_annotation/json_annotation.dart';

part 'issued_dto.g.dart';

@JsonSerializable()
class IssuedDto {
  @JsonKey(name: 'date-parts', fromJson: _parseDateParts)
  final List<List<int>>? dateParts;
  @JsonKey(name: 'date-time')
  final String? dateTime;

  const IssuedDto({this.dateParts, this.dateTime});

  factory IssuedDto.fromJson(Map<String, dynamic> json) =>
      _$IssuedDtoFromJson(json);

  Map<String, dynamic> toJson() => _$IssuedDtoToJson(this);

  static List<List<int>>? _parseDateParts(Object? value) {
    if (value is! List) return null;

    final dates = <List<int>>[];
    for (final entry in value) {
      if (entry is! List) continue;

      final parts = <int>[];
      for (final part in entry) {
        if (part is! num || !part.isFinite) break;
        parts.add(part.toInt());
      }
      if (parts.isNotEmpty) dates.add(parts);
    }
    return dates;
  }
}
