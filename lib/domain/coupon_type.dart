import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/layer.dart';
import 'package:beta/domain/value/number_of_objects.dart';
import 'package:beta/domain/value/root_term_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coupon_type.freezed.dart';
part 'coupon_type.g.dart';

@freezed
abstract class CouponType with _$CouponType {
  factory CouponType(
      {@IdJsonConverter() required Id id,
      @LayerJsonConverter() required Layer layer,
      @RootTermIdJsonConverter() required RootTermId rootTermId,
      @NumberOfObjectsJsonConverter()
      required NumberOfObjects numberOfObjects}) = _CouponType;

  factory CouponType.fromJson(Map<String, dynamic> json) =>
      _$CouponTypeFromJson(json);

  // static Map<String, dynamic> toJson(CouponType instance) =>
  //     _$CouponTypeToJson(instance);
}
