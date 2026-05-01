// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visible.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Visible {

 int get value;
/// Create a copy of Visible
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VisibleCopyWith<Visible> get copyWith => _$VisibleCopyWithImpl<Visible>(this as Visible, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Visible&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'Visible(value: $value)';
}


}

/// @nodoc
abstract mixin class $VisibleCopyWith<$Res>  {
  factory $VisibleCopyWith(Visible value, $Res Function(Visible) _then) = _$VisibleCopyWithImpl;
@useResult
$Res call({
 int value
});




}
/// @nodoc
class _$VisibleCopyWithImpl<$Res>
    implements $VisibleCopyWith<$Res> {
  _$VisibleCopyWithImpl(this._self, this._then);

  final Visible _self;
  final $Res Function(Visible) _then;

/// Create a copy of Visible
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Visible].
extension VisiblePatterns on Visible {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Visible value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Visible() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Visible value)  $default,){
final _that = this;
switch (_that) {
case _Visible():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Visible value)?  $default,){
final _that = this;
switch (_that) {
case _Visible() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Visible() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int value)  $default,) {final _that = this;
switch (_that) {
case _Visible():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int value)?  $default,) {final _that = this;
switch (_that) {
case _Visible() when $default != null:
return $default(_that.value);case _:
  return null;

}
}

}

/// @nodoc


class _Visible implements Visible {
  const _Visible(this.value): assert(value==0||value==1);
  

@override final  int value;

/// Create a copy of Visible
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VisibleCopyWith<_Visible> get copyWith => __$VisibleCopyWithImpl<_Visible>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Visible&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'Visible(value: $value)';
}


}

/// @nodoc
abstract mixin class _$VisibleCopyWith<$Res> implements $VisibleCopyWith<$Res> {
  factory _$VisibleCopyWith(_Visible value, $Res Function(_Visible) _then) = __$VisibleCopyWithImpl;
@override @useResult
$Res call({
 int value
});




}
/// @nodoc
class __$VisibleCopyWithImpl<$Res>
    implements _$VisibleCopyWith<$Res> {
  __$VisibleCopyWithImpl(this._self, this._then);

  final _Visible _self;
  final $Res Function(_Visible) _then;

/// Create a copy of Visible
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_Visible(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
