// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'term_print.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TermPrint {

@GiftTypeJsonConverter() GiftType get gift;@OtherGiftJsonConverter() OtherGift get otherGift;
/// Create a copy of TermPrint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TermPrintCopyWith<TermPrint> get copyWith => _$TermPrintCopyWithImpl<TermPrint>(this as TermPrint, _$identity);

  /// Serializes this TermPrint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TermPrint&&(identical(other.gift, gift) || other.gift == gift)&&(identical(other.otherGift, otherGift) || other.otherGift == otherGift));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gift,otherGift);

@override
String toString() {
  return 'TermPrint(gift: $gift, otherGift: $otherGift)';
}


}

/// @nodoc
abstract mixin class $TermPrintCopyWith<$Res>  {
  factory $TermPrintCopyWith(TermPrint value, $Res Function(TermPrint) _then) = _$TermPrintCopyWithImpl;
@useResult
$Res call({
@GiftTypeJsonConverter() GiftType gift,@OtherGiftJsonConverter() OtherGift otherGift
});


$GiftTypeCopyWith<$Res> get gift;$OtherGiftCopyWith<$Res> get otherGift;

}
/// @nodoc
class _$TermPrintCopyWithImpl<$Res>
    implements $TermPrintCopyWith<$Res> {
  _$TermPrintCopyWithImpl(this._self, this._then);

  final TermPrint _self;
  final $Res Function(TermPrint) _then;

/// Create a copy of TermPrint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? gift = null,Object? otherGift = null,}) {
  return _then(_self.copyWith(
gift: null == gift ? _self.gift : gift // ignore: cast_nullable_to_non_nullable
as GiftType,otherGift: null == otherGift ? _self.otherGift : otherGift // ignore: cast_nullable_to_non_nullable
as OtherGift,
  ));
}
/// Create a copy of TermPrint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GiftTypeCopyWith<$Res> get gift {
  
  return $GiftTypeCopyWith<$Res>(_self.gift, (value) {
    return _then(_self.copyWith(gift: value));
  });
}/// Create a copy of TermPrint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OtherGiftCopyWith<$Res> get otherGift {
  
  return $OtherGiftCopyWith<$Res>(_self.otherGift, (value) {
    return _then(_self.copyWith(otherGift: value));
  });
}
}


/// Adds pattern-matching-related methods to [TermPrint].
extension TermPrintPatterns on TermPrint {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TermPrint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TermPrint() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TermPrint value)  $default,){
final _that = this;
switch (_that) {
case _TermPrint():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TermPrint value)?  $default,){
final _that = this;
switch (_that) {
case _TermPrint() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@GiftTypeJsonConverter()  GiftType gift, @OtherGiftJsonConverter()  OtherGift otherGift)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TermPrint() when $default != null:
return $default(_that.gift,_that.otherGift);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@GiftTypeJsonConverter()  GiftType gift, @OtherGiftJsonConverter()  OtherGift otherGift)  $default,) {final _that = this;
switch (_that) {
case _TermPrint():
return $default(_that.gift,_that.otherGift);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@GiftTypeJsonConverter()  GiftType gift, @OtherGiftJsonConverter()  OtherGift otherGift)?  $default,) {final _that = this;
switch (_that) {
case _TermPrint() when $default != null:
return $default(_that.gift,_that.otherGift);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TermPrint implements TermPrint {
   _TermPrint({@GiftTypeJsonConverter() required this.gift, @OtherGiftJsonConverter() required this.otherGift});
  factory _TermPrint.fromJson(Map<String, dynamic> json) => _$TermPrintFromJson(json);

@override@GiftTypeJsonConverter() final  GiftType gift;
@override@OtherGiftJsonConverter() final  OtherGift otherGift;

/// Create a copy of TermPrint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TermPrintCopyWith<_TermPrint> get copyWith => __$TermPrintCopyWithImpl<_TermPrint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TermPrintToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TermPrint&&(identical(other.gift, gift) || other.gift == gift)&&(identical(other.otherGift, otherGift) || other.otherGift == otherGift));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gift,otherGift);

@override
String toString() {
  return 'TermPrint(gift: $gift, otherGift: $otherGift)';
}


}

/// @nodoc
abstract mixin class _$TermPrintCopyWith<$Res> implements $TermPrintCopyWith<$Res> {
  factory _$TermPrintCopyWith(_TermPrint value, $Res Function(_TermPrint) _then) = __$TermPrintCopyWithImpl;
@override @useResult
$Res call({
@GiftTypeJsonConverter() GiftType gift,@OtherGiftJsonConverter() OtherGift otherGift
});


@override $GiftTypeCopyWith<$Res> get gift;@override $OtherGiftCopyWith<$Res> get otherGift;

}
/// @nodoc
class __$TermPrintCopyWithImpl<$Res>
    implements _$TermPrintCopyWith<$Res> {
  __$TermPrintCopyWithImpl(this._self, this._then);

  final _TermPrint _self;
  final $Res Function(_TermPrint) _then;

/// Create a copy of TermPrint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? gift = null,Object? otherGift = null,}) {
  return _then(_TermPrint(
gift: null == gift ? _self.gift : gift // ignore: cast_nullable_to_non_nullable
as GiftType,otherGift: null == otherGift ? _self.otherGift : otherGift // ignore: cast_nullable_to_non_nullable
as OtherGift,
  ));
}

/// Create a copy of TermPrint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GiftTypeCopyWith<$Res> get gift {
  
  return $GiftTypeCopyWith<$Res>(_self.gift, (value) {
    return _then(_self.copyWith(gift: value));
  });
}/// Create a copy of TermPrint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OtherGiftCopyWith<$Res> get otherGift {
  
  return $OtherGiftCopyWith<$Res>(_self.otherGift, (value) {
    return _then(_self.copyWith(otherGift: value));
  });
}
}

// dart format on
