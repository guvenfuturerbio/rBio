// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'scale_repo_subscribe_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ScaleRepoSubscribeStateTearOff {
  const _$ScaleRepoSubscribeStateTearOff();

  _ScaleRepoShowMiScalePopUp showMiScalePopUp(bool deviceAlreadyPaired) {
    return _ScaleRepoShowMiScalePopUp(
      deviceAlreadyPaired,
    );
  }

  _ScaleRepoSendModel sendModel(MiScaleModel model) {
    return _ScaleRepoSendModel(
      model,
    );
  }

  _ScaleRepoChangeState changeState(
      List<int> controlPointResponse, MiScaleDevice scaleDevice) {
    return _ScaleRepoChangeState(
      controlPointResponse,
      scaleDevice,
    );
  }
}

/// @nodoc
const $ScaleRepoSubscribeState = _$ScaleRepoSubscribeStateTearOff();

/// @nodoc
mixin _$ScaleRepoSubscribeState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool deviceAlreadyPaired) showMiScalePopUp,
    required TResult Function(MiScaleModel model) sendModel,
    required TResult Function(
            List<int> controlPointResponse, MiScaleDevice scaleDevice)
        changeState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool deviceAlreadyPaired)? showMiScalePopUp,
    TResult Function(MiScaleModel model)? sendModel,
    TResult Function(List<int> controlPointResponse, MiScaleDevice scaleDevice)?
        changeState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool deviceAlreadyPaired)? showMiScalePopUp,
    TResult Function(MiScaleModel model)? sendModel,
    TResult Function(List<int> controlPointResponse, MiScaleDevice scaleDevice)?
        changeState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ScaleRepoShowMiScalePopUp value)
        showMiScalePopUp,
    required TResult Function(_ScaleRepoSendModel value) sendModel,
    required TResult Function(_ScaleRepoChangeState value) changeState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ScaleRepoShowMiScalePopUp value)? showMiScalePopUp,
    TResult Function(_ScaleRepoSendModel value)? sendModel,
    TResult Function(_ScaleRepoChangeState value)? changeState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ScaleRepoShowMiScalePopUp value)? showMiScalePopUp,
    TResult Function(_ScaleRepoSendModel value)? sendModel,
    TResult Function(_ScaleRepoChangeState value)? changeState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScaleRepoSubscribeStateCopyWith<$Res> {
  factory $ScaleRepoSubscribeStateCopyWith(ScaleRepoSubscribeState value,
          $Res Function(ScaleRepoSubscribeState) then) =
      _$ScaleRepoSubscribeStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$ScaleRepoSubscribeStateCopyWithImpl<$Res>
    implements $ScaleRepoSubscribeStateCopyWith<$Res> {
  _$ScaleRepoSubscribeStateCopyWithImpl(this._value, this._then);

  final ScaleRepoSubscribeState _value;
  // ignore: unused_field
  final $Res Function(ScaleRepoSubscribeState) _then;
}

/// @nodoc
abstract class _$ScaleRepoShowMiScalePopUpCopyWith<$Res> {
  factory _$ScaleRepoShowMiScalePopUpCopyWith(_ScaleRepoShowMiScalePopUp value,
          $Res Function(_ScaleRepoShowMiScalePopUp) then) =
      __$ScaleRepoShowMiScalePopUpCopyWithImpl<$Res>;
  $Res call({bool deviceAlreadyPaired});
}

/// @nodoc
class __$ScaleRepoShowMiScalePopUpCopyWithImpl<$Res>
    extends _$ScaleRepoSubscribeStateCopyWithImpl<$Res>
    implements _$ScaleRepoShowMiScalePopUpCopyWith<$Res> {
  __$ScaleRepoShowMiScalePopUpCopyWithImpl(_ScaleRepoShowMiScalePopUp _value,
      $Res Function(_ScaleRepoShowMiScalePopUp) _then)
      : super(_value, (v) => _then(v as _ScaleRepoShowMiScalePopUp));

  @override
  _ScaleRepoShowMiScalePopUp get _value =>
      super._value as _ScaleRepoShowMiScalePopUp;

  @override
  $Res call({
    Object? deviceAlreadyPaired = freezed,
  }) {
    return _then(_ScaleRepoShowMiScalePopUp(
      deviceAlreadyPaired == freezed
          ? _value.deviceAlreadyPaired
          : deviceAlreadyPaired // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ScaleRepoShowMiScalePopUp implements _ScaleRepoShowMiScalePopUp {
  const _$_ScaleRepoShowMiScalePopUp(this.deviceAlreadyPaired);

  @override
  final bool deviceAlreadyPaired;

  @override
  String toString() {
    return 'ScaleRepoSubscribeState.showMiScalePopUp(deviceAlreadyPaired: $deviceAlreadyPaired)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ScaleRepoShowMiScalePopUp &&
            const DeepCollectionEquality()
                .equals(other.deviceAlreadyPaired, deviceAlreadyPaired));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(deviceAlreadyPaired));

  @JsonKey(ignore: true)
  @override
  _$ScaleRepoShowMiScalePopUpCopyWith<_ScaleRepoShowMiScalePopUp>
      get copyWith =>
          __$ScaleRepoShowMiScalePopUpCopyWithImpl<_ScaleRepoShowMiScalePopUp>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool deviceAlreadyPaired) showMiScalePopUp,
    required TResult Function(MiScaleModel model) sendModel,
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
    TResult Function(MiScaleModel model)? sendModel,
    TResult Function(List<int> controlPointResponse, MiScaleDevice scaleDevice)?
        changeState,
  }) {
    return showMiScalePopUp?.call(deviceAlreadyPaired);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool deviceAlreadyPaired)? showMiScalePopUp,
    TResult Function(MiScaleModel model)? sendModel,
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
    required TResult Function(_ScaleRepoShowMiScalePopUp value)
        showMiScalePopUp,
    required TResult Function(_ScaleRepoSendModel value) sendModel,
    required TResult Function(_ScaleRepoChangeState value) changeState,
  }) {
    return showMiScalePopUp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ScaleRepoShowMiScalePopUp value)? showMiScalePopUp,
    TResult Function(_ScaleRepoSendModel value)? sendModel,
    TResult Function(_ScaleRepoChangeState value)? changeState,
  }) {
    return showMiScalePopUp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ScaleRepoShowMiScalePopUp value)? showMiScalePopUp,
    TResult Function(_ScaleRepoSendModel value)? sendModel,
    TResult Function(_ScaleRepoChangeState value)? changeState,
    required TResult orElse(),
  }) {
    if (showMiScalePopUp != null) {
      return showMiScalePopUp(this);
    }
    return orElse();
  }
}

abstract class _ScaleRepoShowMiScalePopUp implements ScaleRepoSubscribeState {
  const factory _ScaleRepoShowMiScalePopUp(bool deviceAlreadyPaired) =
      _$_ScaleRepoShowMiScalePopUp;

  bool get deviceAlreadyPaired;
  @JsonKey(ignore: true)
  _$ScaleRepoShowMiScalePopUpCopyWith<_ScaleRepoShowMiScalePopUp>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ScaleRepoSendModelCopyWith<$Res> {
  factory _$ScaleRepoSendModelCopyWith(
          _ScaleRepoSendModel value, $Res Function(_ScaleRepoSendModel) then) =
      __$ScaleRepoSendModelCopyWithImpl<$Res>;
  $Res call({MiScaleModel model});
}

/// @nodoc
class __$ScaleRepoSendModelCopyWithImpl<$Res>
    extends _$ScaleRepoSubscribeStateCopyWithImpl<$Res>
    implements _$ScaleRepoSendModelCopyWith<$Res> {
  __$ScaleRepoSendModelCopyWithImpl(
      _ScaleRepoSendModel _value, $Res Function(_ScaleRepoSendModel) _then)
      : super(_value, (v) => _then(v as _ScaleRepoSendModel));

  @override
  _ScaleRepoSendModel get _value => super._value as _ScaleRepoSendModel;

  @override
  $Res call({
    Object? model = freezed,
  }) {
    return _then(_ScaleRepoSendModel(
      model == freezed
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as MiScaleModel,
    ));
  }
}

/// @nodoc

class _$_ScaleRepoSendModel implements _ScaleRepoSendModel {
  const _$_ScaleRepoSendModel(this.model);

  @override
  final MiScaleModel model;

  @override
  String toString() {
    return 'ScaleRepoSubscribeState.sendModel(model: $model)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ScaleRepoSendModel &&
            const DeepCollectionEquality().equals(other.model, model));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(model));

  @JsonKey(ignore: true)
  @override
  _$ScaleRepoSendModelCopyWith<_ScaleRepoSendModel> get copyWith =>
      __$ScaleRepoSendModelCopyWithImpl<_ScaleRepoSendModel>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool deviceAlreadyPaired) showMiScalePopUp,
    required TResult Function(MiScaleModel model) sendModel,
    required TResult Function(
            List<int> controlPointResponse, MiScaleDevice scaleDevice)
        changeState,
  }) {
    return sendModel(model);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool deviceAlreadyPaired)? showMiScalePopUp,
    TResult Function(MiScaleModel model)? sendModel,
    TResult Function(List<int> controlPointResponse, MiScaleDevice scaleDevice)?
        changeState,
  }) {
    return sendModel?.call(model);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool deviceAlreadyPaired)? showMiScalePopUp,
    TResult Function(MiScaleModel model)? sendModel,
    TResult Function(List<int> controlPointResponse, MiScaleDevice scaleDevice)?
        changeState,
    required TResult orElse(),
  }) {
    if (sendModel != null) {
      return sendModel(model);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ScaleRepoShowMiScalePopUp value)
        showMiScalePopUp,
    required TResult Function(_ScaleRepoSendModel value) sendModel,
    required TResult Function(_ScaleRepoChangeState value) changeState,
  }) {
    return sendModel(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ScaleRepoShowMiScalePopUp value)? showMiScalePopUp,
    TResult Function(_ScaleRepoSendModel value)? sendModel,
    TResult Function(_ScaleRepoChangeState value)? changeState,
  }) {
    return sendModel?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ScaleRepoShowMiScalePopUp value)? showMiScalePopUp,
    TResult Function(_ScaleRepoSendModel value)? sendModel,
    TResult Function(_ScaleRepoChangeState value)? changeState,
    required TResult orElse(),
  }) {
    if (sendModel != null) {
      return sendModel(this);
    }
    return orElse();
  }
}

abstract class _ScaleRepoSendModel implements ScaleRepoSubscribeState {
  const factory _ScaleRepoSendModel(MiScaleModel model) = _$_ScaleRepoSendModel;

  MiScaleModel get model;
  @JsonKey(ignore: true)
  _$ScaleRepoSendModelCopyWith<_ScaleRepoSendModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ScaleRepoChangeStateCopyWith<$Res> {
  factory _$ScaleRepoChangeStateCopyWith(_ScaleRepoChangeState value,
          $Res Function(_ScaleRepoChangeState) then) =
      __$ScaleRepoChangeStateCopyWithImpl<$Res>;
  $Res call({List<int> controlPointResponse, MiScaleDevice scaleDevice});
}

/// @nodoc
class __$ScaleRepoChangeStateCopyWithImpl<$Res>
    extends _$ScaleRepoSubscribeStateCopyWithImpl<$Res>
    implements _$ScaleRepoChangeStateCopyWith<$Res> {
  __$ScaleRepoChangeStateCopyWithImpl(
      _ScaleRepoChangeState _value, $Res Function(_ScaleRepoChangeState) _then)
      : super(_value, (v) => _then(v as _ScaleRepoChangeState));

  @override
  _ScaleRepoChangeState get _value => super._value as _ScaleRepoChangeState;

  @override
  $Res call({
    Object? controlPointResponse = freezed,
    Object? scaleDevice = freezed,
  }) {
    return _then(_ScaleRepoChangeState(
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

class _$_ScaleRepoChangeState implements _ScaleRepoChangeState {
  const _$_ScaleRepoChangeState(this.controlPointResponse, this.scaleDevice);

  @override
  final List<int> controlPointResponse;
  @override
  final MiScaleDevice scaleDevice;

  @override
  String toString() {
    return 'ScaleRepoSubscribeState.changeState(controlPointResponse: $controlPointResponse, scaleDevice: $scaleDevice)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ScaleRepoChangeState &&
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
  _$ScaleRepoChangeStateCopyWith<_ScaleRepoChangeState> get copyWith =>
      __$ScaleRepoChangeStateCopyWithImpl<_ScaleRepoChangeState>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool deviceAlreadyPaired) showMiScalePopUp,
    required TResult Function(MiScaleModel model) sendModel,
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
    TResult Function(MiScaleModel model)? sendModel,
    TResult Function(List<int> controlPointResponse, MiScaleDevice scaleDevice)?
        changeState,
  }) {
    return changeState?.call(controlPointResponse, scaleDevice);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool deviceAlreadyPaired)? showMiScalePopUp,
    TResult Function(MiScaleModel model)? sendModel,
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
    required TResult Function(_ScaleRepoShowMiScalePopUp value)
        showMiScalePopUp,
    required TResult Function(_ScaleRepoSendModel value) sendModel,
    required TResult Function(_ScaleRepoChangeState value) changeState,
  }) {
    return changeState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ScaleRepoShowMiScalePopUp value)? showMiScalePopUp,
    TResult Function(_ScaleRepoSendModel value)? sendModel,
    TResult Function(_ScaleRepoChangeState value)? changeState,
  }) {
    return changeState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ScaleRepoShowMiScalePopUp value)? showMiScalePopUp,
    TResult Function(_ScaleRepoSendModel value)? sendModel,
    TResult Function(_ScaleRepoChangeState value)? changeState,
    required TResult orElse(),
  }) {
    if (changeState != null) {
      return changeState(this);
    }
    return orElse();
  }
}

abstract class _ScaleRepoChangeState implements ScaleRepoSubscribeState {
  const factory _ScaleRepoChangeState(
          List<int> controlPointResponse, MiScaleDevice scaleDevice) =
      _$_ScaleRepoChangeState;

  List<int> get controlPointResponse;
  MiScaleDevice get scaleDevice;
  @JsonKey(ignore: true)
  _$ScaleRepoChangeStateCopyWith<_ScaleRepoChangeState> get copyWith =>
      throw _privateConstructorUsedError;
}
