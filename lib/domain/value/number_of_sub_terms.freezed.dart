// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'number_of_sub_terms.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NumberOfSubTerms {

 int? get value;
/// Create a copy of NumberOfSubTerms
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NumberOfSubTermsCopyWith<NumberOfSubTerms> get copyWith => _$NumberOfSubTermsCopyWithImpl<NumberOfSubTerms>(this as NumberOfSubTerms, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NumberOfSubTerms&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'NumberOfSubTerms(value: $value)';
}


}

/// @nodoc
abstract mixin class $NumberOfSubTermsCopyWith<$Res>  {
  factory $NumberOfSubTermsCopyWith(NumberOfSubTerms value, $Res Function(NumberOfSubTerms) _then) = _$NumberOfSubTermsCopyWithImpl;
@useResult
$Res call({
 int? value
});




}
/// @nodoc
class _$NumberOfSubTermsCopyWithImpl<$Res>
    implements $NumberOfSubTermsCopyWith<$Res> {
  _$NumberOfSubTermsCopyWithImpl(this._self, this._then);

  final NumberOfSubTerms _self;
  final $Res Function(NumberOfSubTerms) _then;

/// Create a copy of NumberOfSubTerms
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = freezed,}) {
  return _then(_self.copyWith(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [NumberOfSubTerms].
extension NumberOfSubTermsPatterns on NumberOfSubTerms {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NumberOfSubTerms value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NumberOfSubTerms() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NumberOfSubTerms value)  $default,){
final _that = this;
switch (_that) {
case _NumberOfSubTerms():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NumberOfSubTerms value)?  $default,){
final _that = this;
switch (_that) {
case _NumberOfSubTerms() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NumberOfSubTerms() when $default != null:
return $default(_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? value)  $default,) {final _that = this;
switch (_that) {
case _NumberOfSubTerms():
return $default(_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? value)?  $default,) {final _that = this;
switch (_that) {
case _NumberOfSubTerms() when $default != null:
return $default(_that.value);case _:
  return null;

}
}

}

/// @nodoc


class _NumberOfSubTerms implements NumberOfSubTerms {
  const _NumberOfSubTerms(this.value): assert(value==null||value>=0);
  

@override final  int? value;

/// Create a copy of NumberOfSubTerms
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NumberOfSubTermsCopyWith<_NumberOfSubTerms> get copyWith => __$NumberOfSubTermsCopyWithImpl<_NumberOfSubTerms>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NumberOfSubTerms&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'NumberOfSubTerms(value: $value)';
}


}

/// @nodoc
abstract mixin class _$NumberOfSubTermsCopyWith<$Res> implements $NumberOfSubTermsCopyWith<$Res> {
  factory _$NumberOfSubTermsCopyWith(_NumberOfSubTerms value, $Res Function(_NumberOfSubTerms) _then) = __$NumberOfSubTermsCopyWithImpl;
@override @useResult
$Res call({
 int? value
});




}
/// @nodoc
class __$NumberOfSubTermsCopyWithImpl<$Res>
    implements _$NumberOfSubTermsCopyWith<$Res> {
  __$NumberOfSubTermsCopyWithImpl(this._self, this._then);

  final _NumberOfSubTerms _self;
  final $Res Function(_NumberOfSubTerms) _then;

/// Create a copy of NumberOfSubTerms
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = freezed,}) {
  return _then(_NumberOfSubTerms(
freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
