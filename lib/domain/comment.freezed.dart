// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Comment {
  @IdJsonConverter()
  Id get id => throw _privateConstructorUsedError;
  @TextJsonConverter()
  Text get content => throw _privateConstructorUsedError;
  @DeviceJsonConverter()
  Device? get device => throw _privateConstructorUsedError;
  @AdminJsonConverter()
  Admin? get admin => throw _privateConstructorUsedError;
  @NumberOfSubTermsJsonConverter()
  NumberOfSubTerms get numberOfComments => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CommentCopyWith<Comment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentCopyWith<$Res> {
  factory $CommentCopyWith(Comment value, $Res Function(Comment) then) =
      _$CommentCopyWithImpl<$Res, Comment>;
  @useResult
  $Res call(
      {@IdJsonConverter() Id id,
      @TextJsonConverter() Text content,
      @DeviceJsonConverter() Device? device,
      @AdminJsonConverter() Admin? admin,
      @NumberOfSubTermsJsonConverter() NumberOfSubTerms numberOfComments});

  $IdCopyWith<$Res> get id;
  $TextCopyWith<$Res> get content;
  $DeviceCopyWith<$Res>? get device;
  $AdminCopyWith<$Res>? get admin;
  $NumberOfSubTermsCopyWith<$Res> get numberOfComments;
}

/// @nodoc
class _$CommentCopyWithImpl<$Res, $Val extends Comment>
    implements $CommentCopyWith<$Res> {
  _$CommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? device = freezed,
    Object? admin = freezed,
    Object? numberOfComments = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as Id,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as Text,
      device: freezed == device
          ? _value.device
          : device // ignore: cast_nullable_to_non_nullable
              as Device?,
      admin: freezed == admin
          ? _value.admin
          : admin // ignore: cast_nullable_to_non_nullable
              as Admin?,
      numberOfComments: null == numberOfComments
          ? _value.numberOfComments
          : numberOfComments // ignore: cast_nullable_to_non_nullable
              as NumberOfSubTerms,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $IdCopyWith<$Res> get id {
    return $IdCopyWith<$Res>(_value.id, (value) {
      return _then(_value.copyWith(id: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TextCopyWith<$Res> get content {
    return $TextCopyWith<$Res>(_value.content, (value) {
      return _then(_value.copyWith(content: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DeviceCopyWith<$Res>? get device {
    if (_value.device == null) {
      return null;
    }

    return $DeviceCopyWith<$Res>(_value.device!, (value) {
      return _then(_value.copyWith(device: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AdminCopyWith<$Res>? get admin {
    if (_value.admin == null) {
      return null;
    }

    return $AdminCopyWith<$Res>(_value.admin!, (value) {
      return _then(_value.copyWith(admin: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NumberOfSubTermsCopyWith<$Res> get numberOfComments {
    return $NumberOfSubTermsCopyWith<$Res>(_value.numberOfComments, (value) {
      return _then(_value.copyWith(numberOfComments: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CommentImplCopyWith<$Res> implements $CommentCopyWith<$Res> {
  factory _$$CommentImplCopyWith(
          _$CommentImpl value, $Res Function(_$CommentImpl) then) =
      __$$CommentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@IdJsonConverter() Id id,
      @TextJsonConverter() Text content,
      @DeviceJsonConverter() Device? device,
      @AdminJsonConverter() Admin? admin,
      @NumberOfSubTermsJsonConverter() NumberOfSubTerms numberOfComments});

  @override
  $IdCopyWith<$Res> get id;
  @override
  $TextCopyWith<$Res> get content;
  @override
  $DeviceCopyWith<$Res>? get device;
  @override
  $AdminCopyWith<$Res>? get admin;
  @override
  $NumberOfSubTermsCopyWith<$Res> get numberOfComments;
}

/// @nodoc
class __$$CommentImplCopyWithImpl<$Res>
    extends _$CommentCopyWithImpl<$Res, _$CommentImpl>
    implements _$$CommentImplCopyWith<$Res> {
  __$$CommentImplCopyWithImpl(
      _$CommentImpl _value, $Res Function(_$CommentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? device = freezed,
    Object? admin = freezed,
    Object? numberOfComments = null,
  }) {
    return _then(_$CommentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as Id,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as Text,
      device: freezed == device
          ? _value.device
          : device // ignore: cast_nullable_to_non_nullable
              as Device?,
      admin: freezed == admin
          ? _value.admin
          : admin // ignore: cast_nullable_to_non_nullable
              as Admin?,
      numberOfComments: null == numberOfComments
          ? _value.numberOfComments
          : numberOfComments // ignore: cast_nullable_to_non_nullable
              as NumberOfSubTerms,
    ));
  }
}

/// @nodoc

class _$CommentImpl implements _Comment {
  _$CommentImpl(
      {@IdJsonConverter() required this.id,
      @TextJsonConverter() required this.content,
      @DeviceJsonConverter() this.device,
      @AdminJsonConverter() this.admin,
      @NumberOfSubTermsJsonConverter() required this.numberOfComments});

  @override
  @IdJsonConverter()
  final Id id;
  @override
  @TextJsonConverter()
  final Text content;
  @override
  @DeviceJsonConverter()
  final Device? device;
  @override
  @AdminJsonConverter()
  final Admin? admin;
  @override
  @NumberOfSubTermsJsonConverter()
  final NumberOfSubTerms numberOfComments;

  @override
  String toString() {
    return 'Comment(id: $id, content: $content, device: $device, admin: $admin, numberOfComments: $numberOfComments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.device, device) || other.device == device) &&
            (identical(other.admin, admin) || other.admin == admin) &&
            (identical(other.numberOfComments, numberOfComments) ||
                other.numberOfComments == numberOfComments));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, content, device, admin, numberOfComments);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentImplCopyWith<_$CommentImpl> get copyWith =>
      __$$CommentImplCopyWithImpl<_$CommentImpl>(this, _$identity);
}

abstract class _Comment implements Comment {
  factory _Comment(
      {@IdJsonConverter() required final Id id,
      @TextJsonConverter() required final Text content,
      @DeviceJsonConverter() final Device? device,
      @AdminJsonConverter() final Admin? admin,
      @NumberOfSubTermsJsonConverter()
      required final NumberOfSubTerms numberOfComments}) = _$CommentImpl;

  @override
  @IdJsonConverter()
  Id get id;
  @override
  @TextJsonConverter()
  Text get content;
  @override
  @DeviceJsonConverter()
  Device? get device;
  @override
  @AdminJsonConverter()
  Admin? get admin;
  @override
  @NumberOfSubTermsJsonConverter()
  NumberOfSubTerms get numberOfComments;
  @override
  @JsonKey(ignore: true)
  _$$CommentImplCopyWith<_$CommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
