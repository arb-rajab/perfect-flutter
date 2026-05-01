// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Notification {

@IdJsonConverter() Id get id;@TitleJsonConverter() Title get title;@TextJsonConverter() Text get text;@DataJsonConverter() Data? get data;@BooleanConverter() bool? get seen;@DateTimeConverter() DateTime get creation;
/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationCopyWith<Notification> get copyWith => _$NotificationCopyWithImpl<Notification>(this as Notification, _$identity);

  /// Serializes this Notification to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Notification&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.text, text) || other.text == text)&&(identical(other.data, data) || other.data == data)&&(identical(other.seen, seen) || other.seen == seen)&&(identical(other.creation, creation) || other.creation == creation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,text,data,seen,creation);

@override
String toString() {
  return 'Notification(id: $id, title: $title, text: $text, data: $data, seen: $seen, creation: $creation)';
}


}

/// @nodoc
abstract mixin class $NotificationCopyWith<$Res>  {
  factory $NotificationCopyWith(Notification value, $Res Function(Notification) _then) = _$NotificationCopyWithImpl;
@useResult
$Res call({
@IdJsonConverter() Id id,@TitleJsonConverter() Title title,@TextJsonConverter() Text text,@DataJsonConverter() Data? data,@BooleanConverter() bool? seen,@DateTimeConverter() DateTime creation
});


$IdCopyWith<$Res> get id;$TitleCopyWith<$Res> get title;$TextCopyWith<$Res> get text;$DataCopyWith<$Res>? get data;

}
/// @nodoc
class _$NotificationCopyWithImpl<$Res>
    implements $NotificationCopyWith<$Res> {
  _$NotificationCopyWithImpl(this._self, this._then);

  final Notification _self;
  final $Res Function(Notification) _then;

/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? text = null,Object? data = freezed,Object? seen = freezed,Object? creation = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as Id,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as Title,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as Text,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Data?,seen: freezed == seen ? _self.seen : seen // ignore: cast_nullable_to_non_nullable
as bool?,creation: null == creation ? _self.creation : creation // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IdCopyWith<$Res> get id {
  
  return $IdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TitleCopyWith<$Res> get title {
  
  return $TitleCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TextCopyWith<$Res> get text {
  
  return $TextCopyWith<$Res>(_self.text, (value) {
    return _then(_self.copyWith(text: value));
  });
}/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $DataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [Notification].
extension NotificationPatterns on Notification {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Notification value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Notification() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Notification value)  $default,){
final _that = this;
switch (_that) {
case _Notification():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Notification value)?  $default,){
final _that = this;
switch (_that) {
case _Notification() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@IdJsonConverter()  Id id, @TitleJsonConverter()  Title title, @TextJsonConverter()  Text text, @DataJsonConverter()  Data? data, @BooleanConverter()  bool? seen, @DateTimeConverter()  DateTime creation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Notification() when $default != null:
return $default(_that.id,_that.title,_that.text,_that.data,_that.seen,_that.creation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@IdJsonConverter()  Id id, @TitleJsonConverter()  Title title, @TextJsonConverter()  Text text, @DataJsonConverter()  Data? data, @BooleanConverter()  bool? seen, @DateTimeConverter()  DateTime creation)  $default,) {final _that = this;
switch (_that) {
case _Notification():
return $default(_that.id,_that.title,_that.text,_that.data,_that.seen,_that.creation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@IdJsonConverter()  Id id, @TitleJsonConverter()  Title title, @TextJsonConverter()  Text text, @DataJsonConverter()  Data? data, @BooleanConverter()  bool? seen, @DateTimeConverter()  DateTime creation)?  $default,) {final _that = this;
switch (_that) {
case _Notification() when $default != null:
return $default(_that.id,_that.title,_that.text,_that.data,_that.seen,_that.creation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Notification implements Notification {
   _Notification({@IdJsonConverter() required this.id, @TitleJsonConverter() required this.title, @TextJsonConverter() required this.text, @DataJsonConverter() required this.data, @BooleanConverter() required this.seen, @DateTimeConverter() required this.creation});
  factory _Notification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);

@override@IdJsonConverter() final  Id id;
@override@TitleJsonConverter() final  Title title;
@override@TextJsonConverter() final  Text text;
@override@DataJsonConverter() final  Data? data;
@override@BooleanConverter() final  bool? seen;
@override@DateTimeConverter() final  DateTime creation;

/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationCopyWith<_Notification> get copyWith => __$NotificationCopyWithImpl<_Notification>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Notification&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.text, text) || other.text == text)&&(identical(other.data, data) || other.data == data)&&(identical(other.seen, seen) || other.seen == seen)&&(identical(other.creation, creation) || other.creation == creation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,text,data,seen,creation);

@override
String toString() {
  return 'Notification(id: $id, title: $title, text: $text, data: $data, seen: $seen, creation: $creation)';
}


}

/// @nodoc
abstract mixin class _$NotificationCopyWith<$Res> implements $NotificationCopyWith<$Res> {
  factory _$NotificationCopyWith(_Notification value, $Res Function(_Notification) _then) = __$NotificationCopyWithImpl;
@override @useResult
$Res call({
@IdJsonConverter() Id id,@TitleJsonConverter() Title title,@TextJsonConverter() Text text,@DataJsonConverter() Data? data,@BooleanConverter() bool? seen,@DateTimeConverter() DateTime creation
});


@override $IdCopyWith<$Res> get id;@override $TitleCopyWith<$Res> get title;@override $TextCopyWith<$Res> get text;@override $DataCopyWith<$Res>? get data;

}
/// @nodoc
class __$NotificationCopyWithImpl<$Res>
    implements _$NotificationCopyWith<$Res> {
  __$NotificationCopyWithImpl(this._self, this._then);

  final _Notification _self;
  final $Res Function(_Notification) _then;

/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? text = null,Object? data = freezed,Object? seen = freezed,Object? creation = null,}) {
  return _then(_Notification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as Id,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as Title,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as Text,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Data?,seen: freezed == seen ? _self.seen : seen // ignore: cast_nullable_to_non_nullable
as bool?,creation: null == creation ? _self.creation : creation // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IdCopyWith<$Res> get id {
  
  return $IdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TitleCopyWith<$Res> get title {
  
  return $TitleCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TextCopyWith<$Res> get text {
  
  return $TextCopyWith<$Res>(_self.text, (value) {
    return _then(_self.copyWith(text: value));
  });
}/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $DataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
