// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'recorder_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RecorderState {
  RecorderStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecorderStateCopyWith<RecorderState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecorderStateCopyWith<$Res> {
  factory $RecorderStateCopyWith(
          RecorderState value, $Res Function(RecorderState) then) =
      _$RecorderStateCopyWithImpl<$Res>;
  $Res call({RecorderStatus status});
}

/// @nodoc
class _$RecorderStateCopyWithImpl<$Res>
    implements $RecorderStateCopyWith<$Res> {
  _$RecorderStateCopyWithImpl(this._value, this._then);

  final RecorderState _value;
  // ignore: unused_field
  final $Res Function(RecorderState) _then;

  @override
  $Res call({
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RecorderStatus,
    ));
  }
}

/// @nodoc
abstract class _$$_RecorderStateCopyWith<$Res>
    implements $RecorderStateCopyWith<$Res> {
  factory _$$_RecorderStateCopyWith(
          _$_RecorderState value, $Res Function(_$_RecorderState) then) =
      __$$_RecorderStateCopyWithImpl<$Res>;
  @override
  $Res call({RecorderStatus status});
}

/// @nodoc
class __$$_RecorderStateCopyWithImpl<$Res>
    extends _$RecorderStateCopyWithImpl<$Res>
    implements _$$_RecorderStateCopyWith<$Res> {
  __$$_RecorderStateCopyWithImpl(
      _$_RecorderState _value, $Res Function(_$_RecorderState) _then)
      : super(_value, (v) => _then(v as _$_RecorderState));

  @override
  _$_RecorderState get _value => super._value as _$_RecorderState;

  @override
  $Res call({
    Object? status = freezed,
  }) {
    return _then(_$_RecorderState(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RecorderStatus,
    ));
  }
}

/// @nodoc

class _$_RecorderState implements _RecorderState {
  const _$_RecorderState({required this.status});

  @override
  final RecorderStatus status;

  @override
  String toString() {
    return 'RecorderState(status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RecorderState &&
            const DeepCollectionEquality().equals(other.status, status));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(status));

  @JsonKey(ignore: true)
  @override
  _$$_RecorderStateCopyWith<_$_RecorderState> get copyWith =>
      __$$_RecorderStateCopyWithImpl<_$_RecorderState>(this, _$identity);
}

abstract class _RecorderState implements RecorderState {
  const factory _RecorderState({required final RecorderStatus status}) =
      _$_RecorderState;

  @override
  RecorderStatus get status => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_RecorderStateCopyWith<_$_RecorderState> get copyWith =>
      throw _privateConstructorUsedError;
}
