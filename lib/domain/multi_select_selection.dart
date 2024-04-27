import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/title.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'multi_select_selection.freezed.dart';
part 'multi_select_selection.g.dart';

@freezed
@JsonSerializable()
class MultiSelectSelection with _$MultiSelectSelection {
  factory MultiSelectSelection({
    @IdJsonConverter() required Id id,
    @TitleJsonConverter() required Title title,
  }) = _MultiSelectSelection;

  static MultiSelectSelection fromJson(Map<String, dynamic> json) =>
      _$MultiSelectSelectionFromJson(json);
}
