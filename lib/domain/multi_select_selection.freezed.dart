// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'multi_select_selection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MultiSelectSelection {

@IdJsonConverter() Id get id;@TitleJsonConverter() Title get title;
/// Create a copy of MultiSelectSelection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MultiSelectSelectionCopyWith<MultiSelectSelection> get copyWith => _$MultiSelectSelectionCopyWithImpl<MultiSelectSelection>(this as MultiSelectSelection, _$identity);

  /// Serializes this MultiSelectSelection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MultiSelectSelection&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title);

@override
String toString() {
  return 'MultiSelectSelection(id: $id, title: $title)';
}


}

/// @nodoc
abstract mixin class $MultiSelectSelectionCopyWith<$Res>  {
  factory $MultiSelectSelectionCopyWith(MultiSelectSelection value, $Res Function(MultiSelectSelection) _then) = _$MultiSelectSelectionCopyWithImpl;
@useResult
$Res call({
@IdJsonConverter() Id id,@TitleJsonConverter() Title title
});


$IdCopyWith<$Res> get id;$TitleCopyWith<$Res> get title;

}
/// @nodoc
class _$MultiSelectSelectionCopyWithImpl<$Res>
    implements $MultiSelectSelectionCopyWith<$Res> {
  _$MultiSelectSelectionCopyWithImpl(this._self, this._then);

  final MultiSelectSelection _self;
  final $Res Function(MultiSelectSelection) _then;

/// Create a copy of MultiSelectSelection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as Id,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as Title,
  ));
}
/// Create a copy of MultiSelectSelection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IdCopyWith<$Res> get id {
  
  return $IdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}/// Create a copy of MultiSelectSelection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TitleCopyWith<$Res> get title {
  
  return $TitleCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}
}


/// Adds pattern-matching-related methods to [MultiSelectSelection].
extension MultiSelectSelectionPatterns on MultiSelectSelection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MultiSelectSelection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MultiSelectSelection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MultiSelectSelection value)  $default,){
final _that = this;
switch (_that) {
case _MultiSelectSelection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MultiSelectSelection value)?  $default,){
final _that = this;
switch (_that) {
case _MultiSelectSelection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@IdJsonConverter()  Id id, @TitleJsonConverter()  Title title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MultiSelectSelection() when $default != null:
return $default(_that.id,_that.title);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@IdJsonConverter()  Id id, @TitleJsonConverter()  Title title)  $default,) {final _that = this;
switch (_that) {
case _MultiSelectSelection():
return $default(_that.id,_that.title);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@IdJsonConverter()  Id id, @TitleJsonConverter()  Title title)?  $default,) {final _that = this;
switch (_that) {
case _MultiSelectSelection() when $default != null:
return $default(_that.id,_that.title);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MultiSelectSelection implements MultiSelectSelection {
   _MultiSelectSelection({@IdJsonConverter() required this.id, @TitleJsonConverter() required this.title});
  factory _MultiSelectSelection.fromJson(Map<String, dynamic> json) => _$MultiSelectSelectionFromJson(json);

@override@IdJsonConverter() final  Id id;
@override@TitleJsonConverter() final  Title title;

/// Create a copy of MultiSelectSelection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MultiSelectSelectionCopyWith<_MultiSelectSelection> get copyWith => __$MultiSelectSelectionCopyWithImpl<_MultiSelectSelection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MultiSelectSelectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MultiSelectSelection&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title);

@override
String toString() {
  return 'MultiSelectSelection(id: $id, title: $title)';
}


}

/// @nodoc
abstract mixin class _$MultiSelectSelectionCopyWith<$Res> implements $MultiSelectSelectionCopyWith<$Res> {
  factory _$MultiSelectSelectionCopyWith(_MultiSelectSelection value, $Res Function(_MultiSelectSelection) _then) = __$MultiSelectSelectionCopyWithImpl;
@override @useResult
$Res call({
@IdJsonConverter() Id id,@TitleJsonConverter() Title title
});


@override $IdCopyWith<$Res> get id;@override $TitleCopyWith<$Res> get title;

}
/// @nodoc
class __$MultiSelectSelectionCopyWithImpl<$Res>
    implements _$MultiSelectSelectionCopyWith<$Res> {
  __$MultiSelectSelectionCopyWithImpl(this._self, this._then);

  final _MultiSelectSelection _self;
  final $Res Function(_MultiSelectSelection) _then;

/// Create a copy of MultiSelectSelection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,}) {
  return _then(_MultiSelectSelection(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as Id,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as Title,
  ));
}

/// Create a copy of MultiSelectSelection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IdCopyWith<$Res> get id {
  
  return $IdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}/// Create a copy of MultiSelectSelection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TitleCopyWith<$Res> get title {
  
  return $TitleCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}
}

// dart format on
