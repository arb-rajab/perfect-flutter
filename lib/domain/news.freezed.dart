// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$News {

@IdJsonConverter() Id get id;@TitleJsonConverter() Title get title;@DescriptionJsonConverter() Description get content;// ignore: invalid_annotation_target
@JsonKey(name: 'created_at')@DateTimeConverter() DateTime get createdAt;
/// Create a copy of News
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewsCopyWith<News> get copyWith => _$NewsCopyWithImpl<News>(this as News, _$identity);

  /// Serializes this News to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is News&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,content,createdAt);

@override
String toString() {
  return 'News(id: $id, title: $title, content: $content, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $NewsCopyWith<$Res>  {
  factory $NewsCopyWith(News value, $Res Function(News) _then) = _$NewsCopyWithImpl;
@useResult
$Res call({
@IdJsonConverter() Id id,@TitleJsonConverter() Title title,@DescriptionJsonConverter() Description content,@JsonKey(name: 'created_at')@DateTimeConverter() DateTime createdAt
});


$IdCopyWith<$Res> get id;$TitleCopyWith<$Res> get title;$DescriptionCopyWith<$Res> get content;

}
/// @nodoc
class _$NewsCopyWithImpl<$Res>
    implements $NewsCopyWith<$Res> {
  _$NewsCopyWithImpl(this._self, this._then);

  final News _self;
  final $Res Function(News) _then;

/// Create a copy of News
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? content = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as Id,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as Title,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as Description,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of News
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IdCopyWith<$Res> get id {
  
  return $IdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}/// Create a copy of News
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TitleCopyWith<$Res> get title {
  
  return $TitleCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of News
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DescriptionCopyWith<$Res> get content {
  
  return $DescriptionCopyWith<$Res>(_self.content, (value) {
    return _then(_self.copyWith(content: value));
  });
}
}


/// Adds pattern-matching-related methods to [News].
extension NewsPatterns on News {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _News value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _News() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _News value)  $default,){
final _that = this;
switch (_that) {
case _News():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _News value)?  $default,){
final _that = this;
switch (_that) {
case _News() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@IdJsonConverter()  Id id, @TitleJsonConverter()  Title title, @DescriptionJsonConverter()  Description content, @JsonKey(name: 'created_at')@DateTimeConverter()  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _News() when $default != null:
return $default(_that.id,_that.title,_that.content,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@IdJsonConverter()  Id id, @TitleJsonConverter()  Title title, @DescriptionJsonConverter()  Description content, @JsonKey(name: 'created_at')@DateTimeConverter()  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _News():
return $default(_that.id,_that.title,_that.content,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@IdJsonConverter()  Id id, @TitleJsonConverter()  Title title, @DescriptionJsonConverter()  Description content, @JsonKey(name: 'created_at')@DateTimeConverter()  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _News() when $default != null:
return $default(_that.id,_that.title,_that.content,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _News implements News {
   _News({@IdJsonConverter() required this.id, @TitleJsonConverter() required this.title, @DescriptionJsonConverter() required this.content, @JsonKey(name: 'created_at')@DateTimeConverter() required this.createdAt});
  factory _News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

@override@IdJsonConverter() final  Id id;
@override@TitleJsonConverter() final  Title title;
@override@DescriptionJsonConverter() final  Description content;
// ignore: invalid_annotation_target
@override@JsonKey(name: 'created_at')@DateTimeConverter() final  DateTime createdAt;

/// Create a copy of News
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewsCopyWith<_News> get copyWith => __$NewsCopyWithImpl<_News>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NewsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _News&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,content,createdAt);

@override
String toString() {
  return 'News(id: $id, title: $title, content: $content, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$NewsCopyWith<$Res> implements $NewsCopyWith<$Res> {
  factory _$NewsCopyWith(_News value, $Res Function(_News) _then) = __$NewsCopyWithImpl;
@override @useResult
$Res call({
@IdJsonConverter() Id id,@TitleJsonConverter() Title title,@DescriptionJsonConverter() Description content,@JsonKey(name: 'created_at')@DateTimeConverter() DateTime createdAt
});


@override $IdCopyWith<$Res> get id;@override $TitleCopyWith<$Res> get title;@override $DescriptionCopyWith<$Res> get content;

}
/// @nodoc
class __$NewsCopyWithImpl<$Res>
    implements _$NewsCopyWith<$Res> {
  __$NewsCopyWithImpl(this._self, this._then);

  final _News _self;
  final $Res Function(_News) _then;

/// Create a copy of News
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? content = null,Object? createdAt = null,}) {
  return _then(_News(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as Id,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as Title,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as Description,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of News
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IdCopyWith<$Res> get id {
  
  return $IdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}/// Create a copy of News
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TitleCopyWith<$Res> get title {
  
  return $TitleCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of News
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DescriptionCopyWith<$Res> get content {
  
  return $DescriptionCopyWith<$Res>(_self.content, (value) {
    return _then(_self.copyWith(content: value));
  });
}
}

// dart format on
