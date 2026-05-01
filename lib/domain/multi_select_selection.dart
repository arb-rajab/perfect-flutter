import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/title.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'multi_select_selection.freezed.dart';
part 'multi_select_selection.g.dart';

@freezed
abstract class MultiSelectSelection with _$MultiSelectSelection {
  factory MultiSelectSelection({
    @IdJsonConverter() required Id id,
    @TitleJsonConverter() required Title title,
  }) = _MultiSelectSelection;

  factory MultiSelectSelection.fromJson(Map<String, dynamic> json) =>
      _$MultiSelectSelectionFromJson(json);
      
}

class MultiSelectSelectionJsonConverter
    extends JsonConverter<MultiSelectSelection, Map<String, dynamic>> {
  const MultiSelectSelectionJsonConverter();

  @override
  MultiSelectSelection fromJson(Map<String, dynamic> json) {
    return MultiSelectSelection.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(MultiSelectSelection object) {
    return object.toJson();
  }
}
