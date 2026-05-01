// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Admin {

@IdJsonConverter() Id get id;@TitleJsonConverter() Title get username;
/// Create a copy of Admin
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminCopyWith<Admin> get copyWith => _$AdminCopyWithImpl<Admin>(this as Admin, _$identity);

  /// Serializes this Admin to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Admin&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username);

@override
String toString() {
  return 'Admin(id: $id, username: $username)';
}


}

/// @nodoc
abstract mixin class $AdminCopyWith<$Res>  {
  factory $AdminCopyWith(Admin value, $Res Function(Admin) _then) = _$AdminCopyWithImpl;
@useResult
$Res call({
@IdJsonConverter() Id id,@TitleJsonConverter() Title username
});


$IdCopyWith<$Res> get id;$TitleCopyWith<$Res> get username;

}
/// @nodoc
class _$AdminCopyWithImpl<$Res>
    implements $AdminCopyWith<$Res> {
  _$AdminCopyWithImpl(this._self, this._then);

  final Admin _self;
  final $Res Function(Admin) _then;

/// Create a copy of Admin
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as Id,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as Title,
  ));
}
/// Create a copy of Admin
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IdCopyWith<$Res> get id {
  
  return $IdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}/// Create a copy of Admin
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TitleCopyWith<$Res> get username {
  
  return $TitleCopyWith<$Res>(_self.username, (value) {
    return _then(_self.copyWith(username: value));
  });
}
}


/// Adds pattern-matching-related methods to [Admin].
extension AdminPatterns on Admin {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Admin value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Admin() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Admin value)  $default,){
final _that = this;
switch (_that) {
case _Admin():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Admin value)?  $default,){
final _that = this;
switch (_that) {
case _Admin() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@IdJsonConverter()  Id id, @TitleJsonConverter()  Title username)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Admin() when $default != null:
return $default(_that.id,_that.username);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@IdJsonConverter()  Id id, @TitleJsonConverter()  Title username)  $default,) {final _that = this;
switch (_that) {
case _Admin():
return $default(_that.id,_that.username);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@IdJsonConverter()  Id id, @TitleJsonConverter()  Title username)?  $default,) {final _that = this;
switch (_that) {
case _Admin() when $default != null:
return $default(_that.id,_that.username);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Admin implements Admin {
  const _Admin({@IdJsonConverter() required this.id, @TitleJsonConverter() required this.username});
  factory _Admin.fromJson(Map<String, dynamic> json) => _$AdminFromJson(json);

@override@IdJsonConverter() final  Id id;
@override@TitleJsonConverter() final  Title username;

/// Create a copy of Admin
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminCopyWith<_Admin> get copyWith => __$AdminCopyWithImpl<_Admin>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdminToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Admin&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username);

@override
String toString() {
  return 'Admin(id: $id, username: $username)';
}


}

/// @nodoc
abstract mixin class _$AdminCopyWith<$Res> implements $AdminCopyWith<$Res> {
  factory _$AdminCopyWith(_Admin value, $Res Function(_Admin) _then) = __$AdminCopyWithImpl;
@override @useResult
$Res call({
@IdJsonConverter() Id id,@TitleJsonConverter() Title username
});


@override $IdCopyWith<$Res> get id;@override $TitleCopyWith<$Res> get username;

}
/// @nodoc
class __$AdminCopyWithImpl<$Res>
    implements _$AdminCopyWith<$Res> {
  __$AdminCopyWithImpl(this._self, this._then);

  final _Admin _self;
  final $Res Function(_Admin) _then;

/// Create a copy of Admin
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,}) {
  return _then(_Admin(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as Id,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as Title,
  ));
}

/// Create a copy of Admin
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IdCopyWith<$Res> get id {
  
  return $IdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}/// Create a copy of Admin
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TitleCopyWith<$Res> get username {
  
  return $TitleCopyWith<$Res>(_self.username, (value) {
    return _then(_self.copyWith(username: value));
  });
}
}

// dart format on
