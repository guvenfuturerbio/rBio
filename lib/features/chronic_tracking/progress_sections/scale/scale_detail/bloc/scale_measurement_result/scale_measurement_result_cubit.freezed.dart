// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'scale_measurement_result_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ScaleMeasurementResultStateTearOff {
  const _$ScaleMeasurementResultStateTearOff();

  _Initial initial(ScaleEntity scaleEntity) {
    return _Initial(
      scaleEntity,
    );
  }

  _LoadInProgress loadInProgress() {
    return const _LoadInProgress();
  }

  _Failure failure() {
    return const _Failure();
  }

  _SuccessAdded successAdded() {
    return const _SuccessAdded();
  }
}

/// @nodoc
const $ScaleMeasurementResultState = _$ScaleMeasurementResultStateTearOff();

/// @nodoc
mixin _$ScaleMeasurementResultState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ScaleEntity scaleEntity) initial,
    required TResult Function() loadInProgress,
    required TResult Function() failure,
    required TResult Function() successAdded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ScaleEntity scaleEntity)? initial,
    TResult Function()? loadInProgress,
    TResult Function()? failure,
    TResult Function()? successAdded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ScaleEntity scaleEntity)? initial,
    TResult Function()? loadInProgress,
    TResult Function()? failure,
    TResult Function()? successAdded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadInProgress value) loadInProgress,
    required TResult Function(_Failure value) failure,
    required TResult Function(_SuccessAdded value) successAdded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_Failure value)? failure,
    TResult Function(_SuccessAdded value)? successAdded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_Failure value)? failure,
    TResult Function(_SuccessAdded value)? successAdded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScaleMeasurementResultStateCopyWith<$Res> {
  factory $ScaleMeasurementResultStateCopyWith(
          ScaleMeasurementResultState value,
          $Res Function(ScaleMeasurementResultState) then) =
      _$ScaleMeasurementResultStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$ScaleMeasurementResultStateCopyWithImpl<$Res>
    implements $ScaleMeasurementResultStateCopyWith<$Res> {
  _$ScaleMeasurementResultStateCopyWithImpl(this._value, this._then);

  final ScaleMeasurementResultState _value;
  // ignore: unused_field
  final $Res Function(ScaleMeasurementResultState) _then;
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
  $Res call({ScaleEntity scaleEntity});
}

/// @nodoc
class __$InitialCopyWithImpl<$Res>
    extends _$ScaleMeasurementResultStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;

  @override
  $Res call({
    Object? scaleEntity = freezed,
  }) {
    return _then(_Initial(
      scaleEntity == freezed
          ? _value.scaleEntity
          : scaleEntity // ignore: cast_nullable_to_non_nullable
              as ScaleEntity,
    ));
  }
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial(this.scaleEntity);

  @override
  final ScaleEntity scaleEntity;

  @override
  String toString() {
    return 'ScaleMeasurementResultState.initial(scaleEntity: $scaleEntity)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Initial &&
            const DeepCollectionEquality()
                .equals(other.scaleEntity, scaleEntity));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(scaleEntity));

  @JsonKey(ignore: true)
  @override
  _$InitialCopyWith<_Initial> get copyWith =>
      __$InitialCopyWithImpl<_Initial>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ScaleEntity scaleEntity) initial,
    required TResult Function() loadInProgress,
    required TResult Function() failure,
    required TResult Function() successAdded,
  }) {
    return initial(scaleEntity);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ScaleEntity scaleEntity)? initial,
    TResult Function()? loadInProgress,
    TResult Function()? failure,
    TResult Function()? successAdded,
  }) {
    return initial?.call(scaleEntity);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ScaleEntity scaleEntity)? initial,
    TResult Function()? loadInProgress,
    TResult Function()? failure,
    TResult Function()? successAdded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(scaleEntity);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadInProgress value) loadInProgress,
    required TResult Function(_Failure value) failure,
    required TResult Function(_SuccessAdded value) successAdded,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_Failure value)? failure,
    TResult Function(_SuccessAdded value)? successAdded,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_Failure value)? failure,
    TResult Function(_SuccessAdded value)? successAdded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements ScaleMeasurementResultState {
  const factory _Initial(ScaleEntity scaleEntity) = _$_Initial;

  ScaleEntity get scaleEntity;
  @JsonKey(ignore: true)
  _$InitialCopyWith<_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$LoadInProgressCopyWith<$Res> {
  factory _$LoadInProgressCopyWith(
          _LoadInProgress value, $Res Function(_LoadInProgress) then) =
      __$LoadInProgressCopyWithImpl<$Res>;
}

/// @nodoc
class __$LoadInProgressCopyWithImpl<$Res>
    extends _$ScaleMeasurementResultStateCopyWithImpl<$Res>
    implements _$LoadInProgressCopyWith<$Res> {
  __$LoadInProgressCopyWithImpl(
      _LoadInProgress _value, $Res Function(_LoadInProgress) _then)
      : super(_value, (v) => _then(v as _LoadInProgress));

  @override
  _LoadInProgress get _value => super._value as _LoadInProgress;
}

/// @nodoc

class _$_LoadInProgress implements _LoadInProgress {
  const _$_LoadInProgress();

  @override
  String toString() {
    return 'ScaleMeasurementResultState.loadInProgress()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _LoadInProgress);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ScaleEntity scaleEntity) initial,
    required TResult Function() loadInProgress,
    required TResult Function() failure,
    required TResult Function() successAdded,
  }) {
    return loadInProgress();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ScaleEntity scaleEntity)? initial,
    TResult Function()? loadInProgress,
    TResult Function()? failure,
    TResult Function()? successAdded,
  }) {
    return loadInProgress?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ScaleEntity scaleEntity)? initial,
    TResult Function()? loadInProgress,
    TResult Function()? failure,
    TResult Function()? successAdded,
    required TResult orElse(),
  }) {
    if (loadInProgress != null) {
      return loadInProgress();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadInProgress value) loadInProgress,
    required TResult Function(_Failure value) failure,
    required TResult Function(_SuccessAdded value) successAdded,
  }) {
    return loadInProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_Failure value)? failure,
    TResult Function(_SuccessAdded value)? successAdded,
  }) {
    return loadInProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_Failure value)? failure,
    TResult Function(_SuccessAdded value)? successAdded,
    required TResult orElse(),
  }) {
    if (loadInProgress != null) {
      return loadInProgress(this);
    }
    return orElse();
  }
}

abstract class _LoadInProgress implements ScaleMeasurementResultState {
  const factory _LoadInProgress() = _$_LoadInProgress;
}

/// @nodoc
abstract class _$FailureCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) then) =
      __$FailureCopyWithImpl<$Res>;
}

/// @nodoc
class __$FailureCopyWithImpl<$Res>
    extends _$ScaleMeasurementResultStateCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(_Failure _value, $Res Function(_Failure) _then)
      : super(_value, (v) => _then(v as _Failure));

  @override
  _Failure get _value => super._value as _Failure;
}

/// @nodoc

class _$_Failure implements _Failure {
  const _$_Failure();

  @override
  String toString() {
    return 'ScaleMeasurementResultState.failure()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Failure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ScaleEntity scaleEntity) initial,
    required TResult Function() loadInProgress,
    required TResult Function() failure,
    required TResult Function() successAdded,
  }) {
    return failure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ScaleEntity scaleEntity)? initial,
    TResult Function()? loadInProgress,
    TResult Function()? failure,
    TResult Function()? successAdded,
  }) {
    return failure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ScaleEntity scaleEntity)? initial,
    TResult Function()? loadInProgress,
    TResult Function()? failure,
    TResult Function()? successAdded,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadInProgress value) loadInProgress,
    required TResult Function(_Failure value) failure,
    required TResult Function(_SuccessAdded value) successAdded,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_Failure value)? failure,
    TResult Function(_SuccessAdded value)? successAdded,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_Failure value)? failure,
    TResult Function(_SuccessAdded value)? successAdded,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _Failure implements ScaleMeasurementResultState {
  const factory _Failure() = _$_Failure;
}

/// @nodoc
abstract class _$SuccessAddedCopyWith<$Res> {
  factory _$SuccessAddedCopyWith(
          _SuccessAdded value, $Res Function(_SuccessAdded) then) =
      __$SuccessAddedCopyWithImpl<$Res>;
}

/// @nodoc
class __$SuccessAddedCopyWithImpl<$Res>
    extends _$ScaleMeasurementResultStateCopyWithImpl<$Res>
    implements _$SuccessAddedCopyWith<$Res> {
  __$SuccessAddedCopyWithImpl(
      _SuccessAdded _value, $Res Function(_SuccessAdded) _then)
      : super(_value, (v) => _then(v as _SuccessAdded));

  @override
  _SuccessAdded get _value => super._value as _SuccessAdded;
}

/// @nodoc

class _$_SuccessAdded implements _SuccessAdded {
  const _$_SuccessAdded();

  @override
  String toString() {
    return 'ScaleMeasurementResultState.successAdded()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _SuccessAdded);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ScaleEntity scaleEntity) initial,
    required TResult Function() loadInProgress,
    required TResult Function() failure,
    required TResult Function() successAdded,
  }) {
    return successAdded();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ScaleEntity scaleEntity)? initial,
    TResult Function()? loadInProgress,
    TResult Function()? failure,
    TResult Function()? successAdded,
  }) {
    return successAdded?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ScaleEntity scaleEntity)? initial,
    TResult Function()? loadInProgress,
    TResult Function()? failure,
    TResult Function()? successAdded,
    required TResult orElse(),
  }) {
    if (successAdded != null) {
      return successAdded();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadInProgress value) loadInProgress,
    required TResult Function(_Failure value) failure,
    required TResult Function(_SuccessAdded value) successAdded,
  }) {
    return successAdded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_Failure value)? failure,
    TResult Function(_SuccessAdded value)? successAdded,
  }) {
    return successAdded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_Failure value)? failure,
    TResult Function(_SuccessAdded value)? successAdded,
    required TResult orElse(),
  }) {
    if (successAdded != null) {
      return successAdded(this);
    }
    return orElse();
  }
}

abstract class _SuccessAdded implements ScaleMeasurementResultState {
  const factory _SuccessAdded() = _$_SuccessAdded;
}
