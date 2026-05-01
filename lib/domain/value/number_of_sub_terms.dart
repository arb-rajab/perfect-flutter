import 'package:freezed_annotation/freezed_annotation.dart';

part 'number_of_sub_terms.freezed.dart';

@freezed
abstract class NumberOfSubTerms with _$NumberOfSubTerms {
  @Assert("value==null||value>=0")
  const factory NumberOfSubTerms(int? value) = _NumberOfSubTerms;
}

class NumberOfSubTermsJsonConverter
    extends JsonConverter<NumberOfSubTerms, int?> {
  const NumberOfSubTermsJsonConverter();
  @override
  NumberOfSubTerms fromJson(int? json) => NumberOfSubTerms(json);

  @override
  int? toJson(NumberOfSubTerms object) => object.value;
}
