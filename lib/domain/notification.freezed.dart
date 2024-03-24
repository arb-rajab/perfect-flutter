// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Notification {
  @IdJsonConverter()
  Id get id => throw _privateConstructorUsedError;
  @TitleJsonConverter()
  Title get title => throw _privateConstructorUsedError;
  @TextJsonConverter()
  Text get text => throw _privateConstructorUsedError;
  @DataJsonConverter()
  Data get data => throw _privateConstructorUsedError;
  @BooleanConverter()
  bool? get seen => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get creation => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NotificationCopyWith<Notification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationCopyWith<$Res> {
  factory $NotificationCopyWith(
          Notification value, $Res Function(Notification) then) =
      _$NotificationCopyWithImpl<$Res, Notification>;
  @useResult
  $Res call(
      {@IdJsonConverter() Id id,
      @TitleJsonConverter() Title title,
      @TextJsonConverter() Text text,
      @DataJsonConverter() Data data,
      @BooleanConverter() bool? seen,
      @DateTimeConverter() DateTime creation});

  $IdCopyWith<$Res> get id;
  $TitleCopyWith<$Res> get title;
  $TextCopyWith<$Res> get text;
  $DataCopyWith<$Res> get data;
}

/// @nodoc
class _$NotificationCopyWithImpl<$Res, $Val extends Notification>
    implements $NotificationCopyWith<$Res> {
  _$NotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? text = null,
    Object? data = null,
    Object? seen = freezed,
    Object? creation = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as Id,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as Title,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as Text,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Data,
      seen: freezed == seen
          ? _value.seen
          : seen // ignore: cast_nullable_to_non_nullable
              as bool?,
      creation: null == creation
          ? _value.creation
          : creation // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
  $TitleCopyWith<$Res> get title {
    return $TitleCopyWith<$Res>(_value.title, (value) {
      return _then(_value.copyWith(title: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TextCopyWith<$Res> get text {
    return $TextCopyWith<$Res>(_value.text, (value) {
      return _then(_value.copyWith(text: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DataCopyWith<$Res> get data {
    return $DataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NotificationImplCopyWith<$Res>
    implements $NotificationCopyWith<$Res> {
  factory _$$NotificationImplCopyWith(
          _$NotificationImpl value, $Res Function(_$NotificationImpl) then) =
      __$$NotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@IdJsonConverter() Id id,
      @TitleJsonConverter() Title title,
      @TextJsonConverter() Text text,
      @DataJsonConverter() Data data,
      @BooleanConverter() bool? seen,
      @DateTimeConverter() DateTime creation});

  @override
  $IdCopyWith<$Res> get id;
  @override
  $TitleCopyWith<$Res> get title;
  @override
  $TextCopyWith<$Res> get text;
  @override
  $DataCopyWith<$Res> get data;
}

/// @nodoc
class __$$NotificationImplCopyWithImpl<$Res>
    extends _$NotificationCopyWithImpl<$Res, _$NotificationImpl>
    implements _$$NotificationImplCopyWith<$Res> {
  __$$NotificationImplCopyWithImpl(
      _$NotificationImpl _value, $Res Function(_$NotificationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? text = null,
    Object? data = null,
    Object? seen = freezed,
    Object? creation = null,
  }) {
    return _then(_$NotificationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as Id,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as Title,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as Text,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Data,
      seen: freezed == seen
          ? _value.seen
          : seen // ignore: cast_nullable_to_non_nullable
              as bool?,
      creation: null == creation
          ? _value.creation
          : creation // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$NotificationImpl implements _Notification {
  _$NotificationImpl(
      {@IdJsonConverter() required this.id,
      @TitleJsonConverter() required this.title,
      @TextJsonConverter() required this.text,
      @DataJsonConverter() required this.data,
      @BooleanConverter() required this.seen,
      @DateTimeConverter() required this.creation});

  @override
  @IdJsonConverter()
  final Id id;
  @override
  @TitleJsonConverter()
  final Title title;
  @override
  @TextJsonConverter()
  final Text text;
  @override
  @DataJsonConverter()
  final Data data;
  @override
  @BooleanConverter()
  final bool? seen;
  @override
  @DateTimeConverter()
  final DateTime creation;

  @override
  String toString() {
    return 'Notification(id: $id, title: $title, text: $text, data: $data, seen: $seen, creation: $creation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.seen, seen) || other.seen == seen) &&
            (identical(other.creation, creation) ||
                other.creation == creation));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, text, data, seen, creation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationImplCopyWith<_$NotificationImpl> get copyWith =>
      __$$NotificationImplCopyWithImpl<_$NotificationImpl>(this, _$identity);
}

abstract class _Notification implements Notification {
  factory _Notification(
          {@IdJsonConverter() required final Id id,
          @TitleJsonConverter() required final Title title,
          @TextJsonConverter() required final Text text,
          @DataJsonConverter() required final Data data,
          @BooleanConverter() required final bool? seen,
          @DateTimeConverter() required final DateTime creation}) =
      _$NotificationImpl;

  @override
  @IdJsonConverter()
  Id get id;
  @override
  @TitleJsonConverter()
  Title get title;
  @override
  @TextJsonConverter()
  Text get text;
  @override
  @DataJsonConverter()
  Data get data;
  @override
  @BooleanConverter()
  bool? get seen;
  @override
  @DateTimeConverter()
  DateTime get creation;
  @override
  @JsonKey(ignore: true)
  _$$NotificationImplCopyWith<_$NotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
