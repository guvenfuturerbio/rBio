// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'doctor_cv_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$DoctorCvStateTearOff {
  const _$DoctorCvStateTearOff();

  _InitialState initial() {
    return const _InitialState();
  }

  _SuccessState success(DoctorCvResponse result) {
    return _SuccessState(
      result,
    );
  }

  _LoadingState loading() {
    return const _LoadingState();
  }

  _ErrorState error(DoctorCvResponse? result) {
    return _ErrorState(
      result,
    );
  }
}

/// @nodoc
const $DoctorCvState = _$DoctorCvStateTearOff();

/// @nodoc
mixin _$DoctorCvState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(DoctorCvResponse result) success,
    required TResult Function() loading,
    required TResult Function(DoctorCvResponse? result) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(DoctorCvResponse result)? success,
    TResult Function()? loading,
    TResult Function(DoctorCvResponse? result)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(DoctorCvResponse result)? success,
    TResult Function()? loading,
    TResult Function(DoctorCvResponse? result)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialState value) initial,
    required TResult Function(_SuccessState value) success,
    required TResult Function(_LoadingState value) loading,
    required TResult Function(_ErrorState value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitialState value)? initial,
    TResult Function(_SuccessState value)? success,
    TResult Function(_LoadingState value)? loading,
    TResult Function(_ErrorState value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialState value)? initial,
    TResult Function(_SuccessState value)? success,
    TResult Function(_LoadingState value)? loading,
    TResult Function(_ErrorState value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoctorCvStateCopyWith<$Res> {
  factory $DoctorCvStateCopyWith(
          DoctorCvState value, $Res Function(DoctorCvState) then) =
      _$DoctorCvStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$DoctorCvStateCopyWithImpl<$Res>
    implements $DoctorCvStateCopyWith<$Res> {
  _$DoctorCvStateCopyWithImpl(this._value, this._then);

  final DoctorCvState _value;
  // ignore: unused_field
  final $Res Function(DoctorCvState) _then;
}

/// @nodoc
abstract class _$InitialStateCopyWith<$Res> {
  factory _$InitialStateCopyWith(
          _InitialState value, $Res Function(_InitialState) then) =
      __$InitialStateCopyWithImpl<$Res>;
}

/// @nodoc
class __$InitialStateCopyWithImpl<$Res>
    extends _$DoctorCvStateCopyWithImpl<$Res>
    implements _$InitialStateCopyWith<$Res> {
  __$InitialStateCopyWithImpl(
      _InitialState _value, $Res Function(_InitialState) _then)
      : super(_value, (v) => _then(v as _InitialState));

  @override
  _InitialState get _value => super._value as _InitialState;
}

/// @nodoc

class _$_InitialState implements _InitialState {
  const _$_InitialState();

  @override
  String toString() {
    return 'DoctorCvState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _InitialState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(DoctorCvResponse result) success,
    required TResult Function() loading,
    required TResult Function(DoctorCvResponse? result) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(DoctorCvResponse result)? success,
    TResult Function()? loading,
    TResult Function(DoctorCvResponse? result)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(DoctorCvResponse result)? success,
    TResult Function()? loading,
    TResult Function(DoctorCvResponse? result)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialState value) initial,
    required TResult Function(_SuccessState value) success,
    required TResult Function(_LoadingState value) loading,
    required TResult Function(_ErrorState value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitialState value)? initial,
    TResult Function(_SuccessState value)? success,
    TResult Function(_LoadingState value)? loading,
    TResult Function(_ErrorState value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialState value)? initial,
    TResult Function(_SuccessState value)? success,
    TResult Function(_LoadingState value)? loading,
    TResult Function(_ErrorState value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _InitialState implements DoctorCvState {
  const factory _InitialState() = _$_InitialState;
}

/// @nodoc
abstract class _$SuccessStateCopyWith<$Res> {
  factory _$SuccessStateCopyWith(
          _SuccessState value, $Res Function(_SuccessState) then) =
      __$SuccessStateCopyWithImpl<$Res>;
  $Res call({DoctorCvResponse result});
}

/// @nodoc
class __$SuccessStateCopyWithImpl<$Res>
    extends _$DoctorCvStateCopyWithImpl<$Res>
    implements _$SuccessStateCopyWith<$Res> {
  __$SuccessStateCopyWithImpl(
      _SuccessState _value, $Res Function(_SuccessState) _then)
      : super(_value, (v) => _then(v as _SuccessState));

  @override
  _SuccessState get _value => super._value as _SuccessState;

  @override
  $Res call({
    Object? result = freezed,
  }) {
    return _then(_SuccessState(
      result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as DoctorCvResponse,
    ));
  }
}

/// @nodoc

class _$_SuccessState implements _SuccessState {
  const _$_SuccessState(this.result);

  @override
  final DoctorCvResponse result;

  @override
  String toString() {
    return 'DoctorCvState.success(result: $result)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SuccessState &&
            const DeepCollectionEquality().equals(other.result, result));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(result));

  @JsonKey(ignore: true)
  @override
  _$SuccessStateCopyWith<_SuccessState> get copyWith =>
      __$SuccessStateCopyWithImpl<_SuccessState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(DoctorCvResponse result) success,
    required TResult Function() loading,
    required TResult Function(DoctorCvResponse? result) error,
  }) {
    return success(result);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(DoctorCvResponse result)? success,
    TResult Function()? loading,
    TResult Function(DoctorCvResponse? result)? error,
  }) {
    return success?.call(result);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(DoctorCvResponse result)? success,
    TResult Function()? loading,
    TResult Function(DoctorCvResponse? result)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(result);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialState value) initial,
    required TResult Function(_SuccessState value) success,
    required TResult Function(_LoadingState value) loading,
    required TResult Function(_ErrorState value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitialState value)? initial,
    TResult Function(_SuccessState value)? success,
    TResult Function(_LoadingState value)? loading,
    TResult Function(_ErrorState value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialState value)? initial,
    TResult Function(_SuccessState value)? success,
    TResult Function(_LoadingState value)? loading,
    TResult Function(_ErrorState value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _SuccessState implements DoctorCvState {
  const factory _SuccessState(DoctorCvResponse result) = _$_SuccessState;

  DoctorCvResponse get result;
  @JsonKey(ignore: true)
  _$SuccessStateCopyWith<_SuccessState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$LoadingStateCopyWith<$Res> {
  factory _$LoadingStateCopyWith(
          _LoadingState value, $Res Function(_LoadingState) then) =
      __$LoadingStateCopyWithImpl<$Res>;
}

/// @nodoc
class __$LoadingStateCopyWithImpl<$Res>
    extends _$DoctorCvStateCopyWithImpl<$Res>
    implements _$LoadingStateCopyWith<$Res> {
  __$LoadingStateCopyWithImpl(
      _LoadingState _value, $Res Function(_LoadingState) _then)
      : super(_value, (v) => _then(v as _LoadingState));

  @override
  _LoadingState get _value => super._value as _LoadingState;
}

/// @nodoc

class _$_LoadingState implements _LoadingState {
  const _$_LoadingState();

  @override
  String toString() {
    return 'DoctorCvState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _LoadingState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(DoctorCvResponse result) success,
    required TResult Function() loading,
    required TResult Function(DoctorCvResponse? result) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(DoctorCvResponse result)? success,
    TResult Function()? loading,
    TResult Function(DoctorCvResponse? result)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(DoctorCvResponse result)? success,
    TResult Function()? loading,
    TResult Function(DoctorCvResponse? result)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialState value) initial,
    required TResult Function(_SuccessState value) success,
    required TResult Function(_LoadingState value) loading,
    required TResult Function(_ErrorState value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitialState value)? initial,
    TResult Function(_SuccessState value)? success,
    TResult Function(_LoadingState value)? loading,
    TResult Function(_ErrorState value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialState value)? initial,
    TResult Function(_SuccessState value)? success,
    TResult Function(_LoadingState value)? loading,
    TResult Function(_ErrorState value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _LoadingState implements DoctorCvState {
  const factory _LoadingState() = _$_LoadingState;
}

/// @nodoc
abstract class _$ErrorStateCopyWith<$Res> {
  factory _$ErrorStateCopyWith(
          _ErrorState value, $Res Function(_ErrorState) then) =
      __$ErrorStateCopyWithImpl<$Res>;
  $Res call({DoctorCvResponse? result});
}

/// @nodoc
class __$ErrorStateCopyWithImpl<$Res> extends _$DoctorCvStateCopyWithImpl<$Res>
    implements _$ErrorStateCopyWith<$Res> {
  __$ErrorStateCopyWithImpl(
      _ErrorState _value, $Res Function(_ErrorState) _then)
      : super(_value, (v) => _then(v as _ErrorState));

  @override
  _ErrorState get _value => super._value as _ErrorState;

  @override
  $Res call({
    Object? result = freezed,
  }) {
    return _then(_ErrorState(
      result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as DoctorCvResponse?,
    ));
  }
}

/// @nodoc

class _$_ErrorState implements _ErrorState {
  const _$_ErrorState(this.result);

  @override
  final DoctorCvResponse? result;

  @override
  String toString() {
    return 'DoctorCvState.error(result: $result)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ErrorState &&
            const DeepCollectionEquality().equals(other.result, result));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(result));

  @JsonKey(ignore: true)
  @override
  _$ErrorStateCopyWith<_ErrorState> get copyWith =>
      __$ErrorStateCopyWithImpl<_ErrorState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(DoctorCvResponse result) success,
    required TResult Function() loading,
    required TResult Function(DoctorCvResponse? result) error,
  }) {
    return error(result);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(DoctorCvResponse result)? success,
    TResult Function()? loading,
    TResult Function(DoctorCvResponse? result)? error,
  }) {
    return error?.call(result);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(DoctorCvResponse result)? success,
    TResult Function()? loading,
    TResult Function(DoctorCvResponse? result)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(result);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialState value) initial,
    required TResult Function(_SuccessState value) success,
    required TResult Function(_LoadingState value) loading,
    required TResult Function(_ErrorState value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitialState value)? initial,
    TResult Function(_SuccessState value)? success,
    TResult Function(_LoadingState value)? loading,
    TResult Function(_ErrorState value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialState value)? initial,
    TResult Function(_SuccessState value)? success,
    TResult Function(_LoadingState value)? loading,
    TResult Function(_ErrorState value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _ErrorState implements DoctorCvState {
  const factory _ErrorState(DoctorCvResponse? result) = _$_ErrorState;

  DoctorCvResponse? get result;
  @JsonKey(ignore: true)
  _$ErrorStateCopyWith<_ErrorState> get copyWith =>
      throw _privateConstructorUsedError;
}
