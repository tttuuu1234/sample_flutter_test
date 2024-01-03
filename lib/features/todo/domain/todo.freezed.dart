// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TodoDomain _$TodoDomainFromJson(Map<String, dynamic> json) {
  return _TodoDomain.fromJson(json);
}

/// @nodoc
mixin _$TodoDomain {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get date => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodoDomainCopyWith<TodoDomain> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoDomainCopyWith<$Res> {
  factory $TodoDomainCopyWith(
          TodoDomain value, $Res Function(TodoDomain) then) =
      _$TodoDomainCopyWithImpl<$Res, TodoDomain>;
  @useResult
  $Res call({String id, String title, @TimestampConverter() DateTime date});
}

/// @nodoc
class _$TodoDomainCopyWithImpl<$Res, $Val extends TodoDomain>
    implements $TodoDomainCopyWith<$Res> {
  _$TodoDomainCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? date = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TodoDomainImplCopyWith<$Res>
    implements $TodoDomainCopyWith<$Res> {
  factory _$$TodoDomainImplCopyWith(
          _$TodoDomainImpl value, $Res Function(_$TodoDomainImpl) then) =
      __$$TodoDomainImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, @TimestampConverter() DateTime date});
}

/// @nodoc
class __$$TodoDomainImplCopyWithImpl<$Res>
    extends _$TodoDomainCopyWithImpl<$Res, _$TodoDomainImpl>
    implements _$$TodoDomainImplCopyWith<$Res> {
  __$$TodoDomainImplCopyWithImpl(
      _$TodoDomainImpl _value, $Res Function(_$TodoDomainImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? date = null,
  }) {
    return _then(_$TodoDomainImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TodoDomainImpl implements _TodoDomain {
  const _$TodoDomainImpl(
      {this.id = '',
      required this.title,
      @TimestampConverter() required this.date});

  factory _$TodoDomainImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodoDomainImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  final String title;
  @override
  @TimestampConverter()
  final DateTime date;

  @override
  String toString() {
    return 'TodoDomain(id: $id, title: $title, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoDomainImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, date);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoDomainImplCopyWith<_$TodoDomainImpl> get copyWith =>
      __$$TodoDomainImplCopyWithImpl<_$TodoDomainImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodoDomainImplToJson(
      this,
    );
  }
}

abstract class _TodoDomain implements TodoDomain {
  const factory _TodoDomain(
      {final String id,
      required final String title,
      @TimestampConverter() required final DateTime date}) = _$TodoDomainImpl;

  factory _TodoDomain.fromJson(Map<String, dynamic> json) =
      _$TodoDomainImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  @TimestampConverter()
  DateTime get date;
  @override
  @JsonKey(ignore: true)
  _$$TodoDomainImplCopyWith<_$TodoDomainImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
