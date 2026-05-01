// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Comment {

@IdJsonConverter() Id get id;@TextJsonConverter() Text get content;@DeviceJsonConverter() Device? get device;@AdminJsonConverter() Admin? get admin;@NumberOfSubTermsJsonConverter() NumberOfSubTerms get numberOfComments;
/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentCopyWith<Comment> get copyWith => _$CommentCopyWithImpl<Comment>(this as Comment, _$identity);

  /// Serializes this Comment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Comment&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.device, device) || other.device == device)&&(identical(other.admin, admin) || other.admin == admin)&&(identical(other.numberOfComments, numberOfComments) || other.numberOfComments == numberOfComments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,device,admin,numberOfComments);

@override
String toString() {
  return 'Comment(id: $id, content: $content, device: $device, admin: $admin, numberOfComments: $numberOfComments)';
}


}

/// @nodoc
abstract mixin class $CommentCopyWith<$Res>  {
  factory $CommentCopyWith(Comment value, $Res Function(Comment) _then) = _$CommentCopyWithImpl;
@useResult
$Res call({
@IdJsonConverter() Id id,@TextJsonConverter() Text content,@DeviceJsonConverter() Device? device,@AdminJsonConverter() Admin? admin,@NumberOfSubTermsJsonConverter() NumberOfSubTerms numberOfComments
});


$IdCopyWith<$Res> get id;$TextCopyWith<$Res> get content;$DeviceCopyWith<$Res>? get device;$AdminCopyWith<$Res>? get admin;$NumberOfSubTermsCopyWith<$Res> get numberOfComments;

}
/// @nodoc
class _$CommentCopyWithImpl<$Res>
    implements $CommentCopyWith<$Res> {
  _$CommentCopyWithImpl(this._self, this._then);

  final Comment _self;
  final $Res Function(Comment) _then;

/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? content = null,Object? device = freezed,Object? admin = freezed,Object? numberOfComments = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as Id,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as Text,device: freezed == device ? _self.device : device // ignore: cast_nullable_to_non_nullable
as Device?,admin: freezed == admin ? _self.admin : admin // ignore: cast_nullable_to_non_nullable
as Admin?,numberOfComments: null == numberOfComments ? _self.numberOfComments : numberOfComments // ignore: cast_nullable_to_non_nullable
as NumberOfSubTerms,
  ));
}
/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IdCopyWith<$Res> get id {
  
  return $IdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TextCopyWith<$Res> get content {
  
  return $TextCopyWith<$Res>(_self.content, (value) {
    return _then(_self.copyWith(content: value));
  });
}/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeviceCopyWith<$Res>? get device {
    if (_self.device == null) {
    return null;
  }

  return $DeviceCopyWith<$Res>(_self.device!, (value) {
    return _then(_self.copyWith(device: value));
  });
}/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdminCopyWith<$Res>? get admin {
    if (_self.admin == null) {
    return null;
  }

  return $AdminCopyWith<$Res>(_self.admin!, (value) {
    return _then(_self.copyWith(admin: value));
  });
}/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NumberOfSubTermsCopyWith<$Res> get numberOfComments {
  
  return $NumberOfSubTermsCopyWith<$Res>(_self.numberOfComments, (value) {
    return _then(_self.copyWith(numberOfComments: value));
  });
}
}


/// Adds pattern-matching-related methods to [Comment].
extension CommentPatterns on Comment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Comment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Comment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Comment value)  $default,){
final _that = this;
switch (_that) {
case _Comment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Comment value)?  $default,){
final _that = this;
switch (_that) {
case _Comment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@IdJsonConverter()  Id id, @TextJsonConverter()  Text content, @DeviceJsonConverter()  Device? device, @AdminJsonConverter()  Admin? admin, @NumberOfSubTermsJsonConverter()  NumberOfSubTerms numberOfComments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Comment() when $default != null:
return $default(_that.id,_that.content,_that.device,_that.admin,_that.numberOfComments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@IdJsonConverter()  Id id, @TextJsonConverter()  Text content, @DeviceJsonConverter()  Device? device, @AdminJsonConverter()  Admin? admin, @NumberOfSubTermsJsonConverter()  NumberOfSubTerms numberOfComments)  $default,) {final _that = this;
switch (_that) {
case _Comment():
return $default(_that.id,_that.content,_that.device,_that.admin,_that.numberOfComments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@IdJsonConverter()  Id id, @TextJsonConverter()  Text content, @DeviceJsonConverter()  Device? device, @AdminJsonConverter()  Admin? admin, @NumberOfSubTermsJsonConverter()  NumberOfSubTerms numberOfComments)?  $default,) {final _that = this;
switch (_that) {
case _Comment() when $default != null:
return $default(_that.id,_that.content,_that.device,_that.admin,_that.numberOfComments);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Comment implements Comment {
   _Comment({@IdJsonConverter() required this.id, @TextJsonConverter() required this.content, @DeviceJsonConverter() this.device, @AdminJsonConverter() this.admin, @NumberOfSubTermsJsonConverter() required this.numberOfComments});
  factory _Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

@override@IdJsonConverter() final  Id id;
@override@TextJsonConverter() final  Text content;
@override@DeviceJsonConverter() final  Device? device;
@override@AdminJsonConverter() final  Admin? admin;
@override@NumberOfSubTermsJsonConverter() final  NumberOfSubTerms numberOfComments;

/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentCopyWith<_Comment> get copyWith => __$CommentCopyWithImpl<_Comment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Comment&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.device, device) || other.device == device)&&(identical(other.admin, admin) || other.admin == admin)&&(identical(other.numberOfComments, numberOfComments) || other.numberOfComments == numberOfComments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,device,admin,numberOfComments);

@override
String toString() {
  return 'Comment(id: $id, content: $content, device: $device, admin: $admin, numberOfComments: $numberOfComments)';
}


}

/// @nodoc
abstract mixin class _$CommentCopyWith<$Res> implements $CommentCopyWith<$Res> {
  factory _$CommentCopyWith(_Comment value, $Res Function(_Comment) _then) = __$CommentCopyWithImpl;
@override @useResult
$Res call({
@IdJsonConverter() Id id,@TextJsonConverter() Text content,@DeviceJsonConverter() Device? device,@AdminJsonConverter() Admin? admin,@NumberOfSubTermsJsonConverter() NumberOfSubTerms numberOfComments
});


@override $IdCopyWith<$Res> get id;@override $TextCopyWith<$Res> get content;@override $DeviceCopyWith<$Res>? get device;@override $AdminCopyWith<$Res>? get admin;@override $NumberOfSubTermsCopyWith<$Res> get numberOfComments;

}
/// @nodoc
class __$CommentCopyWithImpl<$Res>
    implements _$CommentCopyWith<$Res> {
  __$CommentCopyWithImpl(this._self, this._then);

  final _Comment _self;
  final $Res Function(_Comment) _then;

/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? content = null,Object? device = freezed,Object? admin = freezed,Object? numberOfComments = null,}) {
  return _then(_Comment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as Id,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as Text,device: freezed == device ? _self.device : device // ignore: cast_nullable_to_non_nullable
as Device?,admin: freezed == admin ? _self.admin : admin // ignore: cast_nullable_to_non_nullable
as Admin?,numberOfComments: null == numberOfComments ? _self.numberOfComments : numberOfComments // ignore: cast_nullable_to_non_nullable
as NumberOfSubTerms,
  ));
}

/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IdCopyWith<$Res> get id {
  
  return $IdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TextCopyWith<$Res> get content {
  
  return $TextCopyWith<$Res>(_self.content, (value) {
    return _then(_self.copyWith(content: value));
  });
}/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeviceCopyWith<$Res>? get device {
    if (_self.device == null) {
    return null;
  }

  return $DeviceCopyWith<$Res>(_self.device!, (value) {
    return _then(_self.copyWith(device: value));
  });
}/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdminCopyWith<$Res>? get admin {
    if (_self.admin == null) {
    return null;
  }

  return $AdminCopyWith<$Res>(_self.admin!, (value) {
    return _then(_self.copyWith(admin: value));
  });
}/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NumberOfSubTermsCopyWith<$Res> get numberOfComments {
  
  return $NumberOfSubTermsCopyWith<$Res>(_self.numberOfComments, (value) {
    return _then(_self.copyWith(numberOfComments: value));
  });
}
}

// dart format on
