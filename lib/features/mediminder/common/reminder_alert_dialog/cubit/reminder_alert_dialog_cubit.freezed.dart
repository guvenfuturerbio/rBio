// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'reminder_alert_dialog_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ReminderAlertDialogStateTearOff {
  const _$ReminderAlertDialogStateTearOff();

  _Initial initial() {
    return const _Initial();
  }

  _LoadInProgress loadInProgress() {
    return const _LoadInProgress();
  }

  _Success success(ReminderListModel model) {
    return _Success(
      model,
    );
  }

  _Failure failure() {
    return const _Failure();
  }

  _CreatedPostponeNotification createdPostponeNotification() {
    return const _CreatedPostponeNotification();
  }
}

/// @nodoc
const $ReminderAlertDialogState = _$ReminderAlertDialogStateTearOff();

/// @nodoc
mixin _$ReminderAlertDialogState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadInProgress,
    required TResult Function(ReminderListModel model) success,
    required TResult Function() failure,
    required TResult Function() createdPostponeNotification,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadInProgress,
    TResult Function(ReminderListModel model)? success,
    TResult Function()? failure,
    TResult Function()? createdPostponeNotification,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadInProgress,
    TResult Function(ReminderListModel model)? success,
    TResult Function()? failure,
    TResult Function()? createdPostponeNotification,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadInProgress value) loadInProgress,
    required TResult Function(_Success value) success,
    required TResult Function(_Failure value) failure,
    required TResult Function(_CreatedPostponeNotification value)
        createdPostponeNotification,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    TResult Function(_CreatedPostponeNotification value)?
        createdPostponeNotification,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    TResult Function(_CreatedPostponeNotification value)?
        createdPostponeNotification,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReminderAlertDialogStateCopyWith<$Res> {
  factory $ReminderAlertDialogStateCopyWith(ReminderAlertDialogState value,
          $Res Function(ReminderAlertDialogState) then) =
      _$ReminderAlertDialogStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$ReminderAlertDialogStateCopyWithImpl<$Res>
    implements $ReminderAlertDialogStateCopyWith<$Res> {
  _$ReminderAlertDialogStateCopyWithImpl(this._value, this._then);

  final ReminderAlertDialogState _value;
  // ignore: unused_field
  final $Res Function(ReminderAlertDialogState) _then;
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$InitialCopyWithImpl<$Res>
    extends _$ReminderAlertDialogStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'ReminderAlertDialogState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadInProgress,
    required TResult Function(ReminderListModel model) success,
    required TResult Function() failure,
    required TResult Function() createdPostponeNotification,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadInProgress,
    TResult Function(ReminderListModel model)? success,
    TResult Function()? failure,
    TResult Function()? createdPostponeNotification,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadInProgress,
    TResult Function(ReminderListModel model)? success,
    TResult Function()? failure,
    TResult Function()? createdPostponeNotification,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadInProgress value) loadInProgress,
    required TResult Function(_Success value) success,
    required TResult Function(_Failure value) failure,
    required TResult Function(_CreatedPostponeNotification value)
        createdPostponeNotification,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    TResult Function(_CreatedPostponeNotification value)?
        createdPostponeNotification,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    TResult Function(_CreatedPostponeNotification value)?
        createdPostponeNotification,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements ReminderAlertDialogState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$LoadInProgressCopyWith<$Res> {
  factory _$LoadInProgressCopyWith(
          _LoadInProgress value, $Res Function(_LoadInProgress) then) =
      __$LoadInProgressCopyWithImpl<$Res>;
}

/// @nodoc
class __$LoadInProgressCopyWithImpl<$Res>
    extends _$ReminderAlertDialogStateCopyWithImpl<$Res>
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
    return 'ReminderAlertDialogState.loadInProgress()';
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
    required TResult Function() initial,
    required TResult Function() loadInProgress,
    required TResult Function(ReminderListModel model) success,
    required TResult Function() failure,
    required TResult Function() createdPostponeNotification,
  }) {
    return loadInProgress();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadInProgress,
    TResult Function(ReminderListModel model)? success,
    TResult Function()? failure,
    TResult Function()? createdPostponeNotification,
  }) {
    return loadInProgress?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadInProgress,
    TResult Function(ReminderListModel model)? success,
    TResult Function()? failure,
    TResult Function()? createdPostponeNotification,
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
    required TResult Function(_Success value) success,
    required TResult Function(_Failure value) failure,
    required TResult Function(_CreatedPostponeNotification value)
        createdPostponeNotification,
  }) {
    return loadInProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    TResult Function(_CreatedPostponeNotification value)?
        createdPostponeNotification,
  }) {
    return loadInProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    TResult Function(_CreatedPostponeNotification value)?
        createdPostponeNotification,
    required TResult orElse(),
  }) {
    if (loadInProgress != null) {
      return loadInProgress(this);
    }
    return orElse();
  }
}

abstract class _LoadInProgress implements ReminderAlertDialogState {
  const factory _LoadInProgress() = _$_LoadInProgress;
}

/// @nodoc
abstract class _$SuccessCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) then) =
      __$SuccessCopyWithImpl<$Res>;
  $Res call({ReminderListModel model});
}

/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    extends _$ReminderAlertDialogStateCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(_Success _value, $Res Function(_Success) _then)
      : super(_value, (v) => _then(v as _Success));

  @override
  _Success get _value => super._value as _Success;

  @override
  $Res call({
    Object? model = freezed,
  }) {
    return _then(_Success(
      model == freezed
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as ReminderListModel,
    ));
  }
}

/// @nodoc

class _$_Success implements _Success {
  const _$_Success(this.model);

  @override
  final ReminderListModel model;

  @override
  String toString() {
    return 'ReminderAlertDialogState.success(model: $model)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Success &&
            const DeepCollectionEquality().equals(other.model, model));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(model));

  @JsonKey(ignore: true)
  @override
  _$SuccessCopyWith<_Success> get copyWith =>
      __$SuccessCopyWithImpl<_Success>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadInProgress,
    required TResult Function(ReminderListModel model) success,
    required TResult Function() failure,
    required TResult Function() createdPostponeNotification,
  }) {
    return success(model);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadInProgress,
    TResult Function(ReminderListModel model)? success,
    TResult Function()? failure,
    TResult Function()? createdPostponeNotification,
  }) {
    return success?.call(model);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadInProgress,
    TResult Function(ReminderListModel model)? success,
    TResult Function()? failure,
    TResult Function()? createdPostponeNotification,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(model);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadInProgress value) loadInProgress,
    required TResult Function(_Success value) success,
    required TResult Function(_Failure value) failure,
    required TResult Function(_CreatedPostponeNotification value)
        createdPostponeNotification,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    TResult Function(_CreatedPostponeNotification value)?
        createdPostponeNotification,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    TResult Function(_CreatedPostponeNotification value)?
        createdPostponeNotification,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements ReminderAlertDialogState {
  const factory _Success(ReminderListModel model) = _$_Success;

  ReminderListModel get model;
  @JsonKey(ignore: true)
  _$SuccessCopyWith<_Success> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$FailureCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) then) =
      __$FailureCopyWithImpl<$Res>;
}

/// @nodoc
class __$FailureCopyWithImpl<$Res>
    extends _$ReminderAlertDialogStateCopyWithImpl<$Res>
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
    return 'ReminderAlertDialogState.failure()';
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
    required TResult Function() initial,
    required TResult Function() loadInProgress,
    required TResult Function(ReminderListModel model) success,
    required TResult Function() failure,
    required TResult Function() createdPostponeNotification,
  }) {
    return failure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadInProgress,
    TResult Function(ReminderListModel model)? success,
    TResult Function()? failure,
    TResult Function()? createdPostponeNotification,
  }) {
    return failure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadInProgress,
    TResult Function(ReminderListModel model)? success,
    TResult Function()? failure,
    TResult Function()? createdPostponeNotification,
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
    required TResult Function(_Success value) success,
    required TResult Function(_Failure value) failure,
    required TResult Function(_CreatedPostponeNotification value)
        createdPostponeNotification,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    TResult Function(_CreatedPostponeNotification value)?
        createdPostponeNotification,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    TResult Function(_CreatedPostponeNotification value)?
        createdPostponeNotification,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _Failure implements ReminderAlertDialogState {
  const factory _Failure() = _$_Failure;
}

/// @nodoc
abstract class _$CreatedPostponeNotificationCopyWith<$Res> {
  factory _$CreatedPostponeNotificationCopyWith(
          _CreatedPostponeNotification value,
          $Res Function(_CreatedPostponeNotification) then) =
      __$CreatedPostponeNotificationCopyWithImpl<$Res>;
}

/// @nodoc
class __$CreatedPostponeNotificationCopyWithImpl<$Res>
    extends _$ReminderAlertDialogStateCopyWithImpl<$Res>
    implements _$CreatedPostponeNotificationCopyWith<$Res> {
  __$CreatedPostponeNotificationCopyWithImpl(
      _CreatedPostponeNotification _value,
      $Res Function(_CreatedPostponeNotification) _then)
      : super(_value, (v) => _then(v as _CreatedPostponeNotification));

  @override
  _CreatedPostponeNotification get _value =>
      super._value as _CreatedPostponeNotification;
}

/// @nodoc

class _$_CreatedPostponeNotification implements _CreatedPostponeNotification {
  const _$_CreatedPostponeNotification();

  @override
  String toString() {
    return 'ReminderAlertDialogState.createdPostponeNotification()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CreatedPostponeNotification);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadInProgress,
    required TResult Function(ReminderListModel model) success,
    required TResult Function() failure,
    required TResult Function() createdPostponeNotification,
  }) {
    return createdPostponeNotification();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadInProgress,
    TResult Function(ReminderListModel model)? success,
    TResult Function()? failure,
    TResult Function()? createdPostponeNotification,
  }) {
    return createdPostponeNotification?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadInProgress,
    TResult Function(ReminderListModel model)? success,
    TResult Function()? failure,
    TResult Function()? createdPostponeNotification,
    required TResult orElse(),
  }) {
    if (createdPostponeNotification != null) {
      return createdPostponeNotification();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadInProgress value) loadInProgress,
    required TResult Function(_Success value) success,
    required TResult Function(_Failure value) failure,
    required TResult Function(_CreatedPostponeNotification value)
        createdPostponeNotification,
  }) {
    return createdPostponeNotification(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    TResult Function(_CreatedPostponeNotification value)?
        createdPostponeNotification,
  }) {
    return createdPostponeNotification?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    TResult Function(_CreatedPostponeNotification value)?
        createdPostponeNotification,
    required TResult orElse(),
  }) {
    if (createdPostponeNotification != null) {
      return createdPostponeNotification(this);
    }
    return orElse();
  }
}

abstract class _CreatedPostponeNotification
    implements ReminderAlertDialogState {
  const factory _CreatedPostponeNotification() = _$_CreatedPostponeNotification;
}
