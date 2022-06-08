// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'scale_measurement_result_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$_InitialCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
  $Res call({ScaleEntity scaleEntity});
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$ScaleMeasurementResultStateCopyWithImpl<$Res>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, (v) => _then(v as _$_Initial));

  @override
  _$_Initial get _value => super._value as _$_Initial;

  @override
  $Res call({
    Object? scaleEntity = freezed,
  }) {
    return _then(_$_Initial(
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
            other is _$_Initial &&
            const DeepCollectionEquality()
                .equals(other.scaleEntity, scaleEntity));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(scaleEntity));

  @JsonKey(ignore: true)
  @override
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      __$$_InitialCopyWithImpl<_$_Initial>(this, _$identity);

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
  const factory _Initial(final ScaleEntity scaleEntity) = _$_Initial;

  ScaleEntity get scaleEntity => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_LoadInProgressCopyWith<$Res> {
  factory _$$_LoadInProgressCopyWith(
          _$_LoadInProgress value, $Res Function(_$_LoadInProgress) then) =
      __$$_LoadInProgressCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_LoadInProgressCopyWithImpl<$Res>
    extends _$ScaleMeasurementResultStateCopyWithImpl<$Res>
    implements _$$_LoadInProgressCopyWith<$Res> {
  __$$_LoadInProgressCopyWithImpl(
      _$_LoadInProgress _value, $Res Function(_$_LoadInProgress) _then)
      : super(_value, (v) => _then(v as _$_LoadInProgress));

  @override
  _$_LoadInProgress get _value => super._value as _$_LoadInProgress;
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
        (other.runtimeType == runtimeType && other is _$_LoadInProgress);
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
abstract class _$$_FailureCopyWith<$Res> {
  factory _$$_FailureCopyWith(
          _$_Failure value, $Res Function(_$_Failure) then) =
      __$$_FailureCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_FailureCopyWithImpl<$Res>
    extends _$ScaleMeasurementResultStateCopyWithImpl<$Res>
    implements _$$_FailureCopyWith<$Res> {
  __$$_FailureCopyWithImpl(_$_Failure _value, $Res Function(_$_Failure) _then)
      : super(_value, (v) => _then(v as _$_Failure));

  @override
  _$_Failure get _value => super._value as _$_Failure;
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
        (other.runtimeType == runtimeType && other is _$_Failure);
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
abstract class _$$_SuccessAddedCopyWith<$Res> {
  factory _$$_SuccessAddedCopyWith(
          _$_SuccessAdded value, $Res Function(_$_SuccessAdded) then) =
      __$$_SuccessAddedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_SuccessAddedCopyWithImpl<$Res>
    extends _$ScaleMeasurementResultStateCopyWithImpl<$Res>
    implements _$$_SuccessAddedCopyWith<$Res> {
  __$$_SuccessAddedCopyWithImpl(
      _$_SuccessAdded _value, $Res Function(_$_SuccessAdded) _then)
      : super(_value, (v) => _then(v as _$_SuccessAdded));

  @override
  _$_SuccessAdded get _value => super._value as _$_SuccessAdded;
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
        (other.runtimeType == runtimeType && other is _$_SuccessAdded);
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
