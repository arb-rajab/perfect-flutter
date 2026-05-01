// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'text.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Text {

 String? get value;
/// Create a copy of Text
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextCopyWith<Text> get copyWith => _$TextCopyWithImpl<Text>(this as Text, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Text&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'Text(value: $value)';
}


}

/// @nodoc
abstract mixin class $TextCopyWith<$Res>  {
  factory $TextCopyWith(Text value, $Res Function(Text) _then) = _$TextCopyWithImpl;
@useResult
$Res call({
 String? value
});




}
/// @nodoc
class _$TextCopyWithImpl<$Res>
    implements $TextCopyWith<$Res> {
  _$TextCopyWithImpl(this._self, this._then);

  final Text _self;
  final $Res Function(Text) _then;

/// Create a copy of Text
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = freezed,}) {
  return _then(_self.copyWith(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Text].
extension TextPatterns on Text {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Text value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Text() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Text value)  $default,){
final _that = this;
switch (_that) {
case _Text():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Text value)?  $default,){
final _that = this;
switch (_that) {
case _Text() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Text() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? value)  $default,) {final _that = this;
switch (_that) {
case _Text():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? value)?  $default,) {final _that = this;
switch (_that) {
case _Text() when $default != null:
return $default(_that.value);case _:
  return null;

}
}

}

/// @nodoc


class _Text implements Text {
  const _Text([this.value]);
  

@override final  String? value;

/// Create a copy of Text
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TextCopyWith<_Text> get copyWith => __$TextCopyWithImpl<_Text>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Text&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'Text(value: $value)';
}


}

/// @nodoc
abstract mixin class _$TextCopyWith<$Res> implements $TextCopyWith<$Res> {
  factory _$TextCopyWith(_Text value, $Res Function(_Text) _then) = __$TextCopyWithImpl;
@override @useResult
$Res call({
 String? value
});




}
/// @nodoc
class __$TextCopyWithImpl<$Res>
    implements _$TextCopyWith<$Res> {
  __$TextCopyWithImpl(this._self, this._then);

  final _Text _self;
  final $Res Function(_Text) _then;

/// Create a copy of Text
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = freezed,}) {
  return _then(_Text(
freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
