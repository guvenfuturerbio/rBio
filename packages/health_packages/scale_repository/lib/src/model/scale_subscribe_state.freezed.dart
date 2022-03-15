// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'scale_subscribe_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ScaleSubscribeStateTearOff {
  const _$ScaleSubscribeStateTearOff();

  _ScaleShowMiScalePopUp showMiScalePopUp(bool deviceAlreadyPaired) {
    return _ScaleShowMiScalePopUp(
      deviceAlreadyPaired,
    );
  }

  _ScaleSendEntity sendEntity(ScaleEntity model) {
    return _ScaleSendEntity(
      model,
    );
  }

  _ScaleChangeState changeState(
      List<int> controlPointResponse, MiScaleDevice scaleDevice) {
    return _ScaleChangeState(
      controlPointResponse,
      scaleDevice,
    );
  }
}

/// @nodoc
const $ScaleSubscribeState = _$ScaleSubscribeStateTearOff();

/// @nodoc
mixin _$ScaleSubscribeState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool deviceAlreadyPaired) showMiScalePopUp,
    required TResult Function(ScaleEntity model) sendEntity,
    required TResult Function(
            List<int> controlPointResponse, MiScaleDevice scaleDevice)
        changeState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool deviceAlreadyPaired)? showMiScalePopUp,
    TResult Function(ScaleEntity model)? sendEntity,
    TResult Function(List<int> controlPointResponse, MiScaleDevice scaleDevice)?
        changeState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool deviceAlreadyPaired)? showMiScalePopUp,
    TResult Function(ScaleEntity model)? sendEntity,
    TResult Function(List<int> controlPointResponse, MiScaleDevice scaleDevice)?
        changeState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ScaleShowMiScalePopUp value) showMiScalePopUp,
    required TResult Function(_ScaleSendEntity value) sendEntity,
    required TResult Function(_ScaleChangeState value) changeState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ScaleShowMiScalePopUp value)? showMiScalePopUp,
    TResult Function(_ScaleSendEntity value)? sendEntity,
    TResult Function(_ScaleChangeState value)? changeState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ScaleShowMiScalePopUp value)? showMiScalePopUp,
    TResult Function(_ScaleSendEntity value)? sendEntity,
    TResult Function(_ScaleChangeState value)? changeState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScaleSubscribeStateCopyWith<$Res> {
  factory $ScaleSubscribeStateCopyWith(
          ScaleSubscribeState value, $Res Function(ScaleSubscribeState) then) =
      _$ScaleSubscribeStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$ScaleSubscribeStateCopyWithImpl<$Res>
    implements $ScaleSubscribeStateCopyWith<$Res> {
  _$ScaleSubscribeStateCopyWithImpl(this._value, this._then);

  final ScaleSubscribeState _value;
  // ignore: unused_field
  final $Res Function(ScaleSubscribeState) _then;
}

/// @nodoc
abstract class _$ScaleShowMiScalePopUpCopyWith<$Res> {
  factory _$ScaleShowMiScalePopUpCopyWith(_ScaleShowMiScalePopUp value,
          $Res Function(_ScaleShowMiScalePopUp) then) =
      __$ScaleShowMiScalePopUpCopyWithImpl<$Res>;
  $Res call({bool deviceAlreadyPaired});
}

/// @nodoc
class __$ScaleShowMiScalePopUpCopyWithImpl<$Res>
    extends _$ScaleSubscribeStateCopyWithImpl<$Res>
    implements _$ScaleShowMiScalePopUpCopyWith<$Res> {
  __$ScaleShowMiScalePopUpCopyWithImpl(_ScaleShowMiScalePopUp _value,
      $Res Function(_ScaleShowMiScalePopUp) _then)
      : super(_value, (v) => _then(v as _ScaleShowMiScalePopUp));

  @override
  _ScaleShowMiScalePopUp get _value => super._value as _ScaleShowMiScalePopUp;

  @override
  $Res call({
    Object? deviceAlreadyPaired = freezed,
  }) {
    return _then(_ScaleShowMiScalePopUp(
      deviceAlreadyPaired == freezed
          ? _value.deviceAlreadyPaired
          : deviceAlreadyPaired // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ScaleShowMiScalePopUp implements _ScaleShowMiScalePopUp {
  const _$_ScaleShowMiScalePopUp(this.deviceAlreadyPaired);

  @override
  final bool deviceAlreadyPaired;

  @override
  String toString() {
    return 'ScaleSubscribeState.showMiScalePopUp(deviceAlreadyPaired: $deviceAlreadyPaired)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ScaleShowMiScalePopUp &&
            const DeepCollectionEquality()
                .equals(other.deviceAlreadyPaired, deviceAlreadyPaired));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(deviceAlreadyPaired));

  @JsonKey(ignore: true)
  @override
  _$ScaleShowMiScalePopUpCopyWith<_ScaleShowMiScalePopUp> get copyWith =>
      __$ScaleShowMiScalePopUpCopyWithImpl<_ScaleShowMiScalePopUp>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool deviceAlreadyPaired) showMiScalePopUp,
    required TResult Function(ScaleEntity model) sendEntity,
    required TResult Function(
            List<int> controlPointResponse, MiScaleDevice scaleDevice)
        changeState,
  }) {
    return showMiScalePopUp(deviceAlreadyPaired);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool deviceAlreadyPaired)? showMiScalePopUp,
    TResult Function(ScaleEntity model)? sendEntity,
    TResult Function(List<int> controlPointResponse, MiScaleDevice scaleDevice)?
        changeState,
  }) {
    return showMiScalePopUp?.call(deviceAlreadyPaired);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool deviceAlreadyPaired)? showMiScalePopUp,
    TResult Function(ScaleEntity model)? sendEntity,
    TResult Function(List<int> controlPointResponse, MiScaleDevice scaleDevice)?
        changeState,
    required TResult orElse(),
  }) {
    if (showMiScalePopUp != null) {
      return showMiScalePopUp(deviceAlreadyPaired);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ScaleShowMiScalePopUp value) showMiScalePopUp,
    required TResult Function(_ScaleSendEntity value) sendEntity,
    required TResult Function(_ScaleChangeState value) changeState,
  }) {
    return showMiScalePopUp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ScaleShowMiScalePopUp value)? showMiScalePopUp,
    TResult Function(_ScaleSendEntity value)? sendEntity,
    TResult Function(_ScaleChangeState value)? changeState,
  }) {
    return showMiScalePopUp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ScaleShowMiScalePopUp value)? showMiScalePopUp,
    TResult Function(_ScaleSendEntity value)? sendEntity,
    TResult Function(_ScaleChangeState value)? changeState,
    required TResult orElse(),
  }) {
    if (showMiScalePopUp != null) {
      return showMiScalePopUp(this);
    }
    return orElse();
  }
}

abstract class _ScaleShowMiScalePopUp implements ScaleSubscribeState {
  const factory _ScaleShowMiScalePopUp(bool deviceAlreadyPaired) =
      _$_ScaleShowMiScalePopUp;

  bool get deviceAlreadyPaired;
  @JsonKey(ignore: true)
  _$ScaleShowMiScalePopUpCopyWith<_ScaleShowMiScalePopUp> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ScaleSendEntityCopyWith<$Res> {
  factory _$ScaleSendEntityCopyWith(
          _ScaleSendEntity value, $Res Function(_ScaleSendEntity) then) =
      __$ScaleSendEntityCopyWithImpl<$Res>;
  $Res call({ScaleEntity model});
}

/// @nodoc
class __$ScaleSendEntityCopyWithImpl<$Res>
    extends _$ScaleSubscribeStateCopyWithImpl<$Res>
    implements _$ScaleSendEntityCopyWith<$Res> {
  __$ScaleSendEntityCopyWithImpl(
      _ScaleSendEntity _value, $Res Function(_ScaleSendEntity) _then)
      : super(_value, (v) => _then(v as _ScaleSendEntity));

  @override
  _ScaleSendEntity get _value => super._value as _ScaleSendEntity;

  @override
  $Res call({
    Object? model = freezed,
  }) {
    return _then(_ScaleSendEntity(
      model == freezed
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as ScaleEntity,
    ));
  }
}

/// @nodoc

class _$_ScaleSendEntity implements _ScaleSendEntity {
  const _$_ScaleSendEntity(this.model);

  @override
  final ScaleEntity model;

  @override
  String toString() {
    return 'ScaleSubscribeState.sendEntity(model: $model)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ScaleSendEntity &&
            const DeepCollectionEquality().equals(other.model, model));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(model));

  @JsonKey(ignore: true)
  @override
  _$ScaleSendEntityCopyWith<_ScaleSendEntity> get copyWith =>
      __$ScaleSendEntityCopyWithImpl<_ScaleSendEntity>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool deviceAlreadyPaired) showMiScalePopUp,
    required TResult Function(ScaleEntity model) sendEntity,
    required TResult Function(
            List<int> controlPointResponse, MiScaleDevice scaleDevice)
        changeState,
  }) {
    return sendEntity(model);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool deviceAlreadyPaired)? showMiScalePopUp,
    TResult Function(ScaleEntity model)? sendEntity,
    TResult Function(List<int> controlPointResponse, MiScaleDevice scaleDevice)?
        changeState,
  }) {
    return sendEntity?.call(model);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool deviceAlreadyPaired)? showMiScalePopUp,
    TResult Function(ScaleEntity model)? sendEntity,
    TResult Function(List<int> controlPointResponse, MiScaleDevice scaleDevice)?
        changeState,
    required TResult orElse(),
  }) {
    if (sendEntity != null) {
      return sendEntity(model);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ScaleShowMiScalePopUp value) showMiScalePopUp,
    required TResult Function(_ScaleSendEntity value) sendEntity,
    required TResult Function(_ScaleChangeState value) changeState,
  }) {
    return sendEntity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ScaleShowMiScalePopUp value)? showMiScalePopUp,
    TResult Function(_ScaleSendEntity value)? sendEntity,
    TResult Function(_ScaleChangeState value)? changeState,
  }) {
    return sendEntity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ScaleShowMiScalePopUp value)? showMiScalePopUp,
    TResult Function(_ScaleSendEntity value)? sendEntity,
    TResult Function(_ScaleChangeState value)? changeState,
    required TResult orElse(),
  }) {
    if (sendEntity != null) {
      return sendEntity(this);
    }
    return orElse();
  }
}

abstract class _ScaleSendEntity implements ScaleSubscribeState {
  const factory _ScaleSendEntity(ScaleEntity model) = _$_ScaleSendEntity;

  ScaleEntity get model;
  @JsonKey(ignore: true)
  _$ScaleSendEntityCopyWith<_ScaleSendEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ScaleChangeStateCopyWith<$Res> {
  factory _$ScaleChangeStateCopyWith(
          _ScaleChangeState value, $Res Function(_ScaleChangeState) then) =
      __$ScaleChangeStateCopyWithImpl<$Res>;
  $Res call({List<int> controlPointResponse, MiScaleDevice scaleDevice});
}

/// @nodoc
class __$ScaleChangeStateCopyWithImpl<$Res>
    extends _$ScaleSubscribeStateCopyWithImpl<$Res>
    implements _$ScaleChangeStateCopyWith<$Res> {
  __$ScaleChangeStateCopyWithImpl(
      _ScaleChangeState _value, $Res Function(_ScaleChangeState) _then)
      : super(_value, (v) => _then(v as _ScaleChangeState));

  @override
  _ScaleChangeState get _value => super._value as _ScaleChangeState;

  @override
  $Res call({
    Object? controlPointResponse = freezed,
    Object? scaleDevice = freezed,
  }) {
    return _then(_ScaleChangeState(
      controlPointResponse == freezed
          ? _value.controlPointResponse
          : controlPointResponse // ignore: cast_nullable_to_non_nullable
              as List<int>,
      scaleDevice == freezed
          ? _value.scaleDevice
          : scaleDevice // ignore: cast_nullable_to_non_nullable
              as MiScaleDevice,
    ));
  }
}

/// @nodoc

class _$_ScaleChangeState implements _ScaleChangeState {
  const _$_ScaleChangeState(this.controlPointResponse, this.scaleDevice);

  @override
  final List<int> controlPointResponse;
  @override
  final MiScaleDevice scaleDevice;

  @override
  String toString() {
    return 'ScaleSubscribeState.changeState(controlPointResponse: $controlPointResponse, scaleDevice: $scaleDevice)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ScaleChangeState &&
            const DeepCollectionEquality()
                .equals(other.controlPointResponse, controlPointResponse) &&
            const DeepCollectionEquality()
                .equals(other.scaleDevice, scaleDevice));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(controlPointResponse),
      const DeepCollectionEquality().hash(scaleDevice));

  @JsonKey(ignore: true)
  @override
  _$ScaleChangeStateCopyWith<_ScaleChangeState> get copyWith =>
      __$ScaleChangeStateCopyWithImpl<_ScaleChangeState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool deviceAlreadyPaired) showMiScalePopUp,
    required TResult Function(ScaleEntity model) sendEntity,
    required TResult Function(
            List<int> controlPointResponse, MiScaleDevice scaleDevice)
        changeState,
  }) {
    return changeState(controlPointResponse, scaleDevice);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool deviceAlreadyPaired)? showMiScalePopUp,
    TResult Function(ScaleEntity model)? sendEntity,
    TResult Function(List<int> controlPointResponse, MiScaleDevice scaleDevice)?
        changeState,
  }) {
    return changeState?.call(controlPointResponse, scaleDevice);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool deviceAlreadyPaired)? showMiScalePopUp,
    TResult Function(ScaleEntity model)? sendEntity,
    TResult Function(List<int> controlPointResponse, MiScaleDevice scaleDevice)?
        changeState,
    required TResult orElse(),
  }) {
    if (changeState != null) {
      return changeState(controlPointResponse, scaleDevice);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ScaleShowMiScalePopUp value) showMiScalePopUp,
    required TResult Function(_ScaleSendEntity value) sendEntity,
    required TResult Function(_ScaleChangeState value) changeState,
  }) {
    return changeState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ScaleShowMiScalePopUp value)? showMiScalePopUp,
    TResult Function(_ScaleSendEntity value)? sendEntity,
    TResult Function(_ScaleChangeState value)? changeState,
  }) {
    return changeState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ScaleShowMiScalePopUp value)? showMiScalePopUp,
    TResult Function(_ScaleSendEntity value)? sendEntity,
    TResult Function(_ScaleChangeState value)? changeState,
    required TResult orElse(),
  }) {
    if (changeState != null) {
      return changeState(this);
    }
    return orElse();
  }
}

abstract class _ScaleChangeState implements ScaleSubscribeState {
  const factory _ScaleChangeState(
          List<int> controlPointResponse, MiScaleDevice scaleDevice) =
      _$_ScaleChangeState;

  List<int> get controlPointResponse;
  MiScaleDevice get scaleDevice;
  @JsonKey(ignore: true)
  _$ScaleChangeStateCopyWith<_ScaleChangeState> get copyWith =>
      throw _privateConstructorUsedError;
}
