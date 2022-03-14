// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bluetooth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$BluetoothEventTearOff {
  const _$BluetoothEventTearOff();

  _BluetoothInitEvent init() {
    return const _BluetoothInitEvent();
  }

  _BluetoothListenBleStatusEvent listenBleStatus() {
    return const _BluetoothListenBleStatusEvent();
  }

  _BluetoothBleStatusHandlerEvent bleStatusHandler(BleStatus bleStatus) {
    return _BluetoothBleStatusHandlerEvent(
      bleStatus,
    );
  }

  _BluetoothConnectEvent connect(DiscoveredDevice device) {
    return _BluetoothConnectEvent(
      device,
    );
  }

  _BluetoothDisconnectEvent disconnect() {
    return const _BluetoothDisconnectEvent();
  }

  _BluetoothUpdatePairedIdListEvent updatePairedIdList(List<String> list) {
    return _BluetoothUpdatePairedIdListEvent(
      list,
    );
  }

  _BluetoothUpdateDiscoveredListEvent updateDiscoveredList(
      List<DiscoveredDevice> list) {
    return _BluetoothUpdateDiscoveredListEvent(
      list,
    );
  }

  _BluetoothUpdateDeviceConnectionListEvent updateDeviceConnectionList(
      List<ConnectionStateUpdate> list) {
    return _BluetoothUpdateDeviceConnectionListEvent(
      list,
    );
  }
}

/// @nodoc
const $BluetoothEvent = _$BluetoothEventTearOff();

/// @nodoc
mixin _$BluetoothEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() listenBleStatus,
    required TResult Function(BleStatus bleStatus) bleStatusHandler,
    required TResult Function(DiscoveredDevice device) connect,
    required TResult Function() disconnect,
    required TResult Function(List<String> list) updatePairedIdList,
    required TResult Function(List<DiscoveredDevice> list) updateDiscoveredList,
    required TResult Function(List<ConnectionStateUpdate> list)
        updateDeviceConnectionList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? listenBleStatus,
    TResult Function(BleStatus bleStatus)? bleStatusHandler,
    TResult Function(DiscoveredDevice device)? connect,
    TResult Function()? disconnect,
    TResult Function(List<String> list)? updatePairedIdList,
    TResult Function(List<DiscoveredDevice> list)? updateDiscoveredList,
    TResult Function(List<ConnectionStateUpdate> list)?
        updateDeviceConnectionList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? listenBleStatus,
    TResult Function(BleStatus bleStatus)? bleStatusHandler,
    TResult Function(DiscoveredDevice device)? connect,
    TResult Function()? disconnect,
    TResult Function(List<String> list)? updatePairedIdList,
    TResult Function(List<DiscoveredDevice> list)? updateDiscoveredList,
    TResult Function(List<ConnectionStateUpdate> list)?
        updateDeviceConnectionList,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BluetoothInitEvent value) init,
    required TResult Function(_BluetoothListenBleStatusEvent value)
        listenBleStatus,
    required TResult Function(_BluetoothBleStatusHandlerEvent value)
        bleStatusHandler,
    required TResult Function(_BluetoothConnectEvent value) connect,
    required TResult Function(_BluetoothDisconnectEvent value) disconnect,
    required TResult Function(_BluetoothUpdatePairedIdListEvent value)
        updatePairedIdList,
    required TResult Function(_BluetoothUpdateDiscoveredListEvent value)
        updateDiscoveredList,
    required TResult Function(_BluetoothUpdateDeviceConnectionListEvent value)
        updateDeviceConnectionList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_BluetoothInitEvent value)? init,
    TResult Function(_BluetoothListenBleStatusEvent value)? listenBleStatus,
    TResult Function(_BluetoothBleStatusHandlerEvent value)? bleStatusHandler,
    TResult Function(_BluetoothConnectEvent value)? connect,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothUpdatePairedIdListEvent value)?
        updatePairedIdList,
    TResult Function(_BluetoothUpdateDiscoveredListEvent value)?
        updateDiscoveredList,
    TResult Function(_BluetoothUpdateDeviceConnectionListEvent value)?
        updateDeviceConnectionList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BluetoothInitEvent value)? init,
    TResult Function(_BluetoothListenBleStatusEvent value)? listenBleStatus,
    TResult Function(_BluetoothBleStatusHandlerEvent value)? bleStatusHandler,
    TResult Function(_BluetoothConnectEvent value)? connect,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothUpdatePairedIdListEvent value)?
        updatePairedIdList,
    TResult Function(_BluetoothUpdateDiscoveredListEvent value)?
        updateDiscoveredList,
    TResult Function(_BluetoothUpdateDeviceConnectionListEvent value)?
        updateDeviceConnectionList,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BluetoothEventCopyWith<$Res> {
  factory $BluetoothEventCopyWith(
          BluetoothEvent value, $Res Function(BluetoothEvent) then) =
      _$BluetoothEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$BluetoothEventCopyWithImpl<$Res>
    implements $BluetoothEventCopyWith<$Res> {
  _$BluetoothEventCopyWithImpl(this._value, this._then);

  final BluetoothEvent _value;
  // ignore: unused_field
  final $Res Function(BluetoothEvent) _then;
}

/// @nodoc
abstract class _$BluetoothInitEventCopyWith<$Res> {
  factory _$BluetoothInitEventCopyWith(
          _BluetoothInitEvent value, $Res Function(_BluetoothInitEvent) then) =
      __$BluetoothInitEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$BluetoothInitEventCopyWithImpl<$Res>
    extends _$BluetoothEventCopyWithImpl<$Res>
    implements _$BluetoothInitEventCopyWith<$Res> {
  __$BluetoothInitEventCopyWithImpl(
      _BluetoothInitEvent _value, $Res Function(_BluetoothInitEvent) _then)
      : super(_value, (v) => _then(v as _BluetoothInitEvent));

  @override
  _BluetoothInitEvent get _value => super._value as _BluetoothInitEvent;
}

/// @nodoc

class _$_BluetoothInitEvent implements _BluetoothInitEvent {
  const _$_BluetoothInitEvent();

  @override
  String toString() {
    return 'BluetoothEvent.init()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _BluetoothInitEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() listenBleStatus,
    required TResult Function(BleStatus bleStatus) bleStatusHandler,
    required TResult Function(DiscoveredDevice device) connect,
    required TResult Function() disconnect,
    required TResult Function(List<String> list) updatePairedIdList,
    required TResult Function(List<DiscoveredDevice> list) updateDiscoveredList,
    required TResult Function(List<ConnectionStateUpdate> list)
        updateDeviceConnectionList,
  }) {
    return init();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? listenBleStatus,
    TResult Function(BleStatus bleStatus)? bleStatusHandler,
    TResult Function(DiscoveredDevice device)? connect,
    TResult Function()? disconnect,
    TResult Function(List<String> list)? updatePairedIdList,
    TResult Function(List<DiscoveredDevice> list)? updateDiscoveredList,
    TResult Function(List<ConnectionStateUpdate> list)?
        updateDeviceConnectionList,
  }) {
    return init?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? listenBleStatus,
    TResult Function(BleStatus bleStatus)? bleStatusHandler,
    TResult Function(DiscoveredDevice device)? connect,
    TResult Function()? disconnect,
    TResult Function(List<String> list)? updatePairedIdList,
    TResult Function(List<DiscoveredDevice> list)? updateDiscoveredList,
    TResult Function(List<ConnectionStateUpdate> list)?
        updateDeviceConnectionList,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BluetoothInitEvent value) init,
    required TResult Function(_BluetoothListenBleStatusEvent value)
        listenBleStatus,
    required TResult Function(_BluetoothBleStatusHandlerEvent value)
        bleStatusHandler,
    required TResult Function(_BluetoothConnectEvent value) connect,
    required TResult Function(_BluetoothDisconnectEvent value) disconnect,
    required TResult Function(_BluetoothUpdatePairedIdListEvent value)
        updatePairedIdList,
    required TResult Function(_BluetoothUpdateDiscoveredListEvent value)
        updateDiscoveredList,
    required TResult Function(_BluetoothUpdateDeviceConnectionListEvent value)
        updateDeviceConnectionList,
  }) {
    return init(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_BluetoothInitEvent value)? init,
    TResult Function(_BluetoothListenBleStatusEvent value)? listenBleStatus,
    TResult Function(_BluetoothBleStatusHandlerEvent value)? bleStatusHandler,
    TResult Function(_BluetoothConnectEvent value)? connect,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothUpdatePairedIdListEvent value)?
        updatePairedIdList,
    TResult Function(_BluetoothUpdateDiscoveredListEvent value)?
        updateDiscoveredList,
    TResult Function(_BluetoothUpdateDeviceConnectionListEvent value)?
        updateDeviceConnectionList,
  }) {
    return init?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BluetoothInitEvent value)? init,
    TResult Function(_BluetoothListenBleStatusEvent value)? listenBleStatus,
    TResult Function(_BluetoothBleStatusHandlerEvent value)? bleStatusHandler,
    TResult Function(_BluetoothConnectEvent value)? connect,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothUpdatePairedIdListEvent value)?
        updatePairedIdList,
    TResult Function(_BluetoothUpdateDiscoveredListEvent value)?
        updateDiscoveredList,
    TResult Function(_BluetoothUpdateDeviceConnectionListEvent value)?
        updateDeviceConnectionList,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init(this);
    }
    return orElse();
  }
}

abstract class _BluetoothInitEvent implements BluetoothEvent {
  const factory _BluetoothInitEvent() = _$_BluetoothInitEvent;
}

/// @nodoc
abstract class _$BluetoothListenBleStatusEventCopyWith<$Res> {
  factory _$BluetoothListenBleStatusEventCopyWith(
          _BluetoothListenBleStatusEvent value,
          $Res Function(_BluetoothListenBleStatusEvent) then) =
      __$BluetoothListenBleStatusEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$BluetoothListenBleStatusEventCopyWithImpl<$Res>
    extends _$BluetoothEventCopyWithImpl<$Res>
    implements _$BluetoothListenBleStatusEventCopyWith<$Res> {
  __$BluetoothListenBleStatusEventCopyWithImpl(
      _BluetoothListenBleStatusEvent _value,
      $Res Function(_BluetoothListenBleStatusEvent) _then)
      : super(_value, (v) => _then(v as _BluetoothListenBleStatusEvent));

  @override
  _BluetoothListenBleStatusEvent get _value =>
      super._value as _BluetoothListenBleStatusEvent;
}

/// @nodoc

class _$_BluetoothListenBleStatusEvent
    implements _BluetoothListenBleStatusEvent {
  const _$_BluetoothListenBleStatusEvent();

  @override
  String toString() {
    return 'BluetoothEvent.listenBleStatus()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BluetoothListenBleStatusEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() listenBleStatus,
    required TResult Function(BleStatus bleStatus) bleStatusHandler,
    required TResult Function(DiscoveredDevice device) connect,
    required TResult Function() disconnect,
    required TResult Function(List<String> list) updatePairedIdList,
    required TResult Function(List<DiscoveredDevice> list) updateDiscoveredList,
    required TResult Function(List<ConnectionStateUpdate> list)
        updateDeviceConnectionList,
  }) {
    return listenBleStatus();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? listenBleStatus,
    TResult Function(BleStatus bleStatus)? bleStatusHandler,
    TResult Function(DiscoveredDevice device)? connect,
    TResult Function()? disconnect,
    TResult Function(List<String> list)? updatePairedIdList,
    TResult Function(List<DiscoveredDevice> list)? updateDiscoveredList,
    TResult Function(List<ConnectionStateUpdate> list)?
        updateDeviceConnectionList,
  }) {
    return listenBleStatus?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? listenBleStatus,
    TResult Function(BleStatus bleStatus)? bleStatusHandler,
    TResult Function(DiscoveredDevice device)? connect,
    TResult Function()? disconnect,
    TResult Function(List<String> list)? updatePairedIdList,
    TResult Function(List<DiscoveredDevice> list)? updateDiscoveredList,
    TResult Function(List<ConnectionStateUpdate> list)?
        updateDeviceConnectionList,
    required TResult orElse(),
  }) {
    if (listenBleStatus != null) {
      return listenBleStatus();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BluetoothInitEvent value) init,
    required TResult Function(_BluetoothListenBleStatusEvent value)
        listenBleStatus,
    required TResult Function(_BluetoothBleStatusHandlerEvent value)
        bleStatusHandler,
    required TResult Function(_BluetoothConnectEvent value) connect,
    required TResult Function(_BluetoothDisconnectEvent value) disconnect,
    required TResult Function(_BluetoothUpdatePairedIdListEvent value)
        updatePairedIdList,
    required TResult Function(_BluetoothUpdateDiscoveredListEvent value)
        updateDiscoveredList,
    required TResult Function(_BluetoothUpdateDeviceConnectionListEvent value)
        updateDeviceConnectionList,
  }) {
    return listenBleStatus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_BluetoothInitEvent value)? init,
    TResult Function(_BluetoothListenBleStatusEvent value)? listenBleStatus,
    TResult Function(_BluetoothBleStatusHandlerEvent value)? bleStatusHandler,
    TResult Function(_BluetoothConnectEvent value)? connect,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothUpdatePairedIdListEvent value)?
        updatePairedIdList,
    TResult Function(_BluetoothUpdateDiscoveredListEvent value)?
        updateDiscoveredList,
    TResult Function(_BluetoothUpdateDeviceConnectionListEvent value)?
        updateDeviceConnectionList,
  }) {
    return listenBleStatus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BluetoothInitEvent value)? init,
    TResult Function(_BluetoothListenBleStatusEvent value)? listenBleStatus,
    TResult Function(_BluetoothBleStatusHandlerEvent value)? bleStatusHandler,
    TResult Function(_BluetoothConnectEvent value)? connect,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothUpdatePairedIdListEvent value)?
        updatePairedIdList,
    TResult Function(_BluetoothUpdateDiscoveredListEvent value)?
        updateDiscoveredList,
    TResult Function(_BluetoothUpdateDeviceConnectionListEvent value)?
        updateDeviceConnectionList,
    required TResult orElse(),
  }) {
    if (listenBleStatus != null) {
      return listenBleStatus(this);
    }
    return orElse();
  }
}

abstract class _BluetoothListenBleStatusEvent implements BluetoothEvent {
  const factory _BluetoothListenBleStatusEvent() =
      _$_BluetoothListenBleStatusEvent;
}

/// @nodoc
abstract class _$BluetoothBleStatusHandlerEventCopyWith<$Res> {
  factory _$BluetoothBleStatusHandlerEventCopyWith(
          _BluetoothBleStatusHandlerEvent value,
          $Res Function(_BluetoothBleStatusHandlerEvent) then) =
      __$BluetoothBleStatusHandlerEventCopyWithImpl<$Res>;
  $Res call({BleStatus bleStatus});
}

/// @nodoc
class __$BluetoothBleStatusHandlerEventCopyWithImpl<$Res>
    extends _$BluetoothEventCopyWithImpl<$Res>
    implements _$BluetoothBleStatusHandlerEventCopyWith<$Res> {
  __$BluetoothBleStatusHandlerEventCopyWithImpl(
      _BluetoothBleStatusHandlerEvent _value,
      $Res Function(_BluetoothBleStatusHandlerEvent) _then)
      : super(_value, (v) => _then(v as _BluetoothBleStatusHandlerEvent));

  @override
  _BluetoothBleStatusHandlerEvent get _value =>
      super._value as _BluetoothBleStatusHandlerEvent;

  @override
  $Res call({
    Object? bleStatus = freezed,
  }) {
    return _then(_BluetoothBleStatusHandlerEvent(
      bleStatus == freezed
          ? _value.bleStatus
          : bleStatus // ignore: cast_nullable_to_non_nullable
              as BleStatus,
    ));
  }
}

/// @nodoc

class _$_BluetoothBleStatusHandlerEvent
    implements _BluetoothBleStatusHandlerEvent {
  const _$_BluetoothBleStatusHandlerEvent(this.bleStatus);

  @override
  final BleStatus bleStatus;

  @override
  String toString() {
    return 'BluetoothEvent.bleStatusHandler(bleStatus: $bleStatus)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BluetoothBleStatusHandlerEvent &&
            const DeepCollectionEquality().equals(other.bleStatus, bleStatus));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(bleStatus));

  @JsonKey(ignore: true)
  @override
  _$BluetoothBleStatusHandlerEventCopyWith<_BluetoothBleStatusHandlerEvent>
      get copyWith => __$BluetoothBleStatusHandlerEventCopyWithImpl<
          _BluetoothBleStatusHandlerEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() listenBleStatus,
    required TResult Function(BleStatus bleStatus) bleStatusHandler,
    required TResult Function(DiscoveredDevice device) connect,
    required TResult Function() disconnect,
    required TResult Function(List<String> list) updatePairedIdList,
    required TResult Function(List<DiscoveredDevice> list) updateDiscoveredList,
    required TResult Function(List<ConnectionStateUpdate> list)
        updateDeviceConnectionList,
  }) {
    return bleStatusHandler(bleStatus);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? listenBleStatus,
    TResult Function(BleStatus bleStatus)? bleStatusHandler,
    TResult Function(DiscoveredDevice device)? connect,
    TResult Function()? disconnect,
    TResult Function(List<String> list)? updatePairedIdList,
    TResult Function(List<DiscoveredDevice> list)? updateDiscoveredList,
    TResult Function(List<ConnectionStateUpdate> list)?
        updateDeviceConnectionList,
  }) {
    return bleStatusHandler?.call(bleStatus);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? listenBleStatus,
    TResult Function(BleStatus bleStatus)? bleStatusHandler,
    TResult Function(DiscoveredDevice device)? connect,
    TResult Function()? disconnect,
    TResult Function(List<String> list)? updatePairedIdList,
    TResult Function(List<DiscoveredDevice> list)? updateDiscoveredList,
    TResult Function(List<ConnectionStateUpdate> list)?
        updateDeviceConnectionList,
    required TResult orElse(),
  }) {
    if (bleStatusHandler != null) {
      return bleStatusHandler(bleStatus);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BluetoothInitEvent value) init,
    required TResult Function(_BluetoothListenBleStatusEvent value)
        listenBleStatus,
    required TResult Function(_BluetoothBleStatusHandlerEvent value)
        bleStatusHandler,
    required TResult Function(_BluetoothConnectEvent value) connect,
    required TResult Function(_BluetoothDisconnectEvent value) disconnect,
    required TResult Function(_BluetoothUpdatePairedIdListEvent value)
        updatePairedIdList,
    required TResult Function(_BluetoothUpdateDiscoveredListEvent value)
        updateDiscoveredList,
    required TResult Function(_BluetoothUpdateDeviceConnectionListEvent value)
        updateDeviceConnectionList,
  }) {
    return bleStatusHandler(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_BluetoothInitEvent value)? init,
    TResult Function(_BluetoothListenBleStatusEvent value)? listenBleStatus,
    TResult Function(_BluetoothBleStatusHandlerEvent value)? bleStatusHandler,
    TResult Function(_BluetoothConnectEvent value)? connect,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothUpdatePairedIdListEvent value)?
        updatePairedIdList,
    TResult Function(_BluetoothUpdateDiscoveredListEvent value)?
        updateDiscoveredList,
    TResult Function(_BluetoothUpdateDeviceConnectionListEvent value)?
        updateDeviceConnectionList,
  }) {
    return bleStatusHandler?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BluetoothInitEvent value)? init,
    TResult Function(_BluetoothListenBleStatusEvent value)? listenBleStatus,
    TResult Function(_BluetoothBleStatusHandlerEvent value)? bleStatusHandler,
    TResult Function(_BluetoothConnectEvent value)? connect,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothUpdatePairedIdListEvent value)?
        updatePairedIdList,
    TResult Function(_BluetoothUpdateDiscoveredListEvent value)?
        updateDiscoveredList,
    TResult Function(_BluetoothUpdateDeviceConnectionListEvent value)?
        updateDeviceConnectionList,
    required TResult orElse(),
  }) {
    if (bleStatusHandler != null) {
      return bleStatusHandler(this);
    }
    return orElse();
  }
}

abstract class _BluetoothBleStatusHandlerEvent implements BluetoothEvent {
  const factory _BluetoothBleStatusHandlerEvent(BleStatus bleStatus) =
      _$_BluetoothBleStatusHandlerEvent;

  BleStatus get bleStatus;
  @JsonKey(ignore: true)
  _$BluetoothBleStatusHandlerEventCopyWith<_BluetoothBleStatusHandlerEvent>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$BluetoothConnectEventCopyWith<$Res> {
  factory _$BluetoothConnectEventCopyWith(_BluetoothConnectEvent value,
          $Res Function(_BluetoothConnectEvent) then) =
      __$BluetoothConnectEventCopyWithImpl<$Res>;
  $Res call({DiscoveredDevice device});
}

/// @nodoc
class __$BluetoothConnectEventCopyWithImpl<$Res>
    extends _$BluetoothEventCopyWithImpl<$Res>
    implements _$BluetoothConnectEventCopyWith<$Res> {
  __$BluetoothConnectEventCopyWithImpl(_BluetoothConnectEvent _value,
      $Res Function(_BluetoothConnectEvent) _then)
      : super(_value, (v) => _then(v as _BluetoothConnectEvent));

  @override
  _BluetoothConnectEvent get _value => super._value as _BluetoothConnectEvent;

  @override
  $Res call({
    Object? device = freezed,
  }) {
    return _then(_BluetoothConnectEvent(
      device == freezed
          ? _value.device
          : device // ignore: cast_nullable_to_non_nullable
              as DiscoveredDevice,
    ));
  }
}

/// @nodoc

class _$_BluetoothConnectEvent implements _BluetoothConnectEvent {
  const _$_BluetoothConnectEvent(this.device);

  @override
  final DiscoveredDevice device;

  @override
  String toString() {
    return 'BluetoothEvent.connect(device: $device)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BluetoothConnectEvent &&
            const DeepCollectionEquality().equals(other.device, device));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(device));

  @JsonKey(ignore: true)
  @override
  _$BluetoothConnectEventCopyWith<_BluetoothConnectEvent> get copyWith =>
      __$BluetoothConnectEventCopyWithImpl<_BluetoothConnectEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() listenBleStatus,
    required TResult Function(BleStatus bleStatus) bleStatusHandler,
    required TResult Function(DiscoveredDevice device) connect,
    required TResult Function() disconnect,
    required TResult Function(List<String> list) updatePairedIdList,
    required TResult Function(List<DiscoveredDevice> list) updateDiscoveredList,
    required TResult Function(List<ConnectionStateUpdate> list)
        updateDeviceConnectionList,
  }) {
    return connect(device);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? listenBleStatus,
    TResult Function(BleStatus bleStatus)? bleStatusHandler,
    TResult Function(DiscoveredDevice device)? connect,
    TResult Function()? disconnect,
    TResult Function(List<String> list)? updatePairedIdList,
    TResult Function(List<DiscoveredDevice> list)? updateDiscoveredList,
    TResult Function(List<ConnectionStateUpdate> list)?
        updateDeviceConnectionList,
  }) {
    return connect?.call(device);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? listenBleStatus,
    TResult Function(BleStatus bleStatus)? bleStatusHandler,
    TResult Function(DiscoveredDevice device)? connect,
    TResult Function()? disconnect,
    TResult Function(List<String> list)? updatePairedIdList,
    TResult Function(List<DiscoveredDevice> list)? updateDiscoveredList,
    TResult Function(List<ConnectionStateUpdate> list)?
        updateDeviceConnectionList,
    required TResult orElse(),
  }) {
    if (connect != null) {
      return connect(device);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BluetoothInitEvent value) init,
    required TResult Function(_BluetoothListenBleStatusEvent value)
        listenBleStatus,
    required TResult Function(_BluetoothBleStatusHandlerEvent value)
        bleStatusHandler,
    required TResult Function(_BluetoothConnectEvent value) connect,
    required TResult Function(_BluetoothDisconnectEvent value) disconnect,
    required TResult Function(_BluetoothUpdatePairedIdListEvent value)
        updatePairedIdList,
    required TResult Function(_BluetoothUpdateDiscoveredListEvent value)
        updateDiscoveredList,
    required TResult Function(_BluetoothUpdateDeviceConnectionListEvent value)
        updateDeviceConnectionList,
  }) {
    return connect(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_BluetoothInitEvent value)? init,
    TResult Function(_BluetoothListenBleStatusEvent value)? listenBleStatus,
    TResult Function(_BluetoothBleStatusHandlerEvent value)? bleStatusHandler,
    TResult Function(_BluetoothConnectEvent value)? connect,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothUpdatePairedIdListEvent value)?
        updatePairedIdList,
    TResult Function(_BluetoothUpdateDiscoveredListEvent value)?
        updateDiscoveredList,
    TResult Function(_BluetoothUpdateDeviceConnectionListEvent value)?
        updateDeviceConnectionList,
  }) {
    return connect?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BluetoothInitEvent value)? init,
    TResult Function(_BluetoothListenBleStatusEvent value)? listenBleStatus,
    TResult Function(_BluetoothBleStatusHandlerEvent value)? bleStatusHandler,
    TResult Function(_BluetoothConnectEvent value)? connect,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothUpdatePairedIdListEvent value)?
        updatePairedIdList,
    TResult Function(_BluetoothUpdateDiscoveredListEvent value)?
        updateDiscoveredList,
    TResult Function(_BluetoothUpdateDeviceConnectionListEvent value)?
        updateDeviceConnectionList,
    required TResult orElse(),
  }) {
    if (connect != null) {
      return connect(this);
    }
    return orElse();
  }
}

abstract class _BluetoothConnectEvent implements BluetoothEvent {
  const factory _BluetoothConnectEvent(DiscoveredDevice device) =
      _$_BluetoothConnectEvent;

  DiscoveredDevice get device;
  @JsonKey(ignore: true)
  _$BluetoothConnectEventCopyWith<_BluetoothConnectEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$BluetoothDisconnectEventCopyWith<$Res> {
  factory _$BluetoothDisconnectEventCopyWith(_BluetoothDisconnectEvent value,
          $Res Function(_BluetoothDisconnectEvent) then) =
      __$BluetoothDisconnectEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$BluetoothDisconnectEventCopyWithImpl<$Res>
    extends _$BluetoothEventCopyWithImpl<$Res>
    implements _$BluetoothDisconnectEventCopyWith<$Res> {
  __$BluetoothDisconnectEventCopyWithImpl(_BluetoothDisconnectEvent _value,
      $Res Function(_BluetoothDisconnectEvent) _then)
      : super(_value, (v) => _then(v as _BluetoothDisconnectEvent));

  @override
  _BluetoothDisconnectEvent get _value =>
      super._value as _BluetoothDisconnectEvent;
}

/// @nodoc

class _$_BluetoothDisconnectEvent implements _BluetoothDisconnectEvent {
  const _$_BluetoothDisconnectEvent();

  @override
  String toString() {
    return 'BluetoothEvent.disconnect()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BluetoothDisconnectEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() listenBleStatus,
    required TResult Function(BleStatus bleStatus) bleStatusHandler,
    required TResult Function(DiscoveredDevice device) connect,
    required TResult Function() disconnect,
    required TResult Function(List<String> list) updatePairedIdList,
    required TResult Function(List<DiscoveredDevice> list) updateDiscoveredList,
    required TResult Function(List<ConnectionStateUpdate> list)
        updateDeviceConnectionList,
  }) {
    return disconnect();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? listenBleStatus,
    TResult Function(BleStatus bleStatus)? bleStatusHandler,
    TResult Function(DiscoveredDevice device)? connect,
    TResult Function()? disconnect,
    TResult Function(List<String> list)? updatePairedIdList,
    TResult Function(List<DiscoveredDevice> list)? updateDiscoveredList,
    TResult Function(List<ConnectionStateUpdate> list)?
        updateDeviceConnectionList,
  }) {
    return disconnect?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? listenBleStatus,
    TResult Function(BleStatus bleStatus)? bleStatusHandler,
    TResult Function(DiscoveredDevice device)? connect,
    TResult Function()? disconnect,
    TResult Function(List<String> list)? updatePairedIdList,
    TResult Function(List<DiscoveredDevice> list)? updateDiscoveredList,
    TResult Function(List<ConnectionStateUpdate> list)?
        updateDeviceConnectionList,
    required TResult orElse(),
  }) {
    if (disconnect != null) {
      return disconnect();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BluetoothInitEvent value) init,
    required TResult Function(_BluetoothListenBleStatusEvent value)
        listenBleStatus,
    required TResult Function(_BluetoothBleStatusHandlerEvent value)
        bleStatusHandler,
    required TResult Function(_BluetoothConnectEvent value) connect,
    required TResult Function(_BluetoothDisconnectEvent value) disconnect,
    required TResult Function(_BluetoothUpdatePairedIdListEvent value)
        updatePairedIdList,
    required TResult Function(_BluetoothUpdateDiscoveredListEvent value)
        updateDiscoveredList,
    required TResult Function(_BluetoothUpdateDeviceConnectionListEvent value)
        updateDeviceConnectionList,
  }) {
    return disconnect(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_BluetoothInitEvent value)? init,
    TResult Function(_BluetoothListenBleStatusEvent value)? listenBleStatus,
    TResult Function(_BluetoothBleStatusHandlerEvent value)? bleStatusHandler,
    TResult Function(_BluetoothConnectEvent value)? connect,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothUpdatePairedIdListEvent value)?
        updatePairedIdList,
    TResult Function(_BluetoothUpdateDiscoveredListEvent value)?
        updateDiscoveredList,
    TResult Function(_BluetoothUpdateDeviceConnectionListEvent value)?
        updateDeviceConnectionList,
  }) {
    return disconnect?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BluetoothInitEvent value)? init,
    TResult Function(_BluetoothListenBleStatusEvent value)? listenBleStatus,
    TResult Function(_BluetoothBleStatusHandlerEvent value)? bleStatusHandler,
    TResult Function(_BluetoothConnectEvent value)? connect,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothUpdatePairedIdListEvent value)?
        updatePairedIdList,
    TResult Function(_BluetoothUpdateDiscoveredListEvent value)?
        updateDiscoveredList,
    TResult Function(_BluetoothUpdateDeviceConnectionListEvent value)?
        updateDeviceConnectionList,
    required TResult orElse(),
  }) {
    if (disconnect != null) {
      return disconnect(this);
    }
    return orElse();
  }
}

abstract class _BluetoothDisconnectEvent implements BluetoothEvent {
  const factory _BluetoothDisconnectEvent() = _$_BluetoothDisconnectEvent;
}

/// @nodoc
abstract class _$BluetoothUpdatePairedIdListEventCopyWith<$Res> {
  factory _$BluetoothUpdatePairedIdListEventCopyWith(
          _BluetoothUpdatePairedIdListEvent value,
          $Res Function(_BluetoothUpdatePairedIdListEvent) then) =
      __$BluetoothUpdatePairedIdListEventCopyWithImpl<$Res>;
  $Res call({List<String> list});
}

/// @nodoc
class __$BluetoothUpdatePairedIdListEventCopyWithImpl<$Res>
    extends _$BluetoothEventCopyWithImpl<$Res>
    implements _$BluetoothUpdatePairedIdListEventCopyWith<$Res> {
  __$BluetoothUpdatePairedIdListEventCopyWithImpl(
      _BluetoothUpdatePairedIdListEvent _value,
      $Res Function(_BluetoothUpdatePairedIdListEvent) _then)
      : super(_value, (v) => _then(v as _BluetoothUpdatePairedIdListEvent));

  @override
  _BluetoothUpdatePairedIdListEvent get _value =>
      super._value as _BluetoothUpdatePairedIdListEvent;

  @override
  $Res call({
    Object? list = freezed,
  }) {
    return _then(_BluetoothUpdatePairedIdListEvent(
      list == freezed
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_BluetoothUpdatePairedIdListEvent
    implements _BluetoothUpdatePairedIdListEvent {
  const _$_BluetoothUpdatePairedIdListEvent(this.list);

  @override
  final List<String> list;

  @override
  String toString() {
    return 'BluetoothEvent.updatePairedIdList(list: $list)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BluetoothUpdatePairedIdListEvent &&
            const DeepCollectionEquality().equals(other.list, list));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(list));

  @JsonKey(ignore: true)
  @override
  _$BluetoothUpdatePairedIdListEventCopyWith<_BluetoothUpdatePairedIdListEvent>
      get copyWith => __$BluetoothUpdatePairedIdListEventCopyWithImpl<
          _BluetoothUpdatePairedIdListEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() listenBleStatus,
    required TResult Function(BleStatus bleStatus) bleStatusHandler,
    required TResult Function(DiscoveredDevice device) connect,
    required TResult Function() disconnect,
    required TResult Function(List<String> list) updatePairedIdList,
    required TResult Function(List<DiscoveredDevice> list) updateDiscoveredList,
    required TResult Function(List<ConnectionStateUpdate> list)
        updateDeviceConnectionList,
  }) {
    return updatePairedIdList(list);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? listenBleStatus,
    TResult Function(BleStatus bleStatus)? bleStatusHandler,
    TResult Function(DiscoveredDevice device)? connect,
    TResult Function()? disconnect,
    TResult Function(List<String> list)? updatePairedIdList,
    TResult Function(List<DiscoveredDevice> list)? updateDiscoveredList,
    TResult Function(List<ConnectionStateUpdate> list)?
        updateDeviceConnectionList,
  }) {
    return updatePairedIdList?.call(list);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? listenBleStatus,
    TResult Function(BleStatus bleStatus)? bleStatusHandler,
    TResult Function(DiscoveredDevice device)? connect,
    TResult Function()? disconnect,
    TResult Function(List<String> list)? updatePairedIdList,
    TResult Function(List<DiscoveredDevice> list)? updateDiscoveredList,
    TResult Function(List<ConnectionStateUpdate> list)?
        updateDeviceConnectionList,
    required TResult orElse(),
  }) {
    if (updatePairedIdList != null) {
      return updatePairedIdList(list);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BluetoothInitEvent value) init,
    required TResult Function(_BluetoothListenBleStatusEvent value)
        listenBleStatus,
    required TResult Function(_BluetoothBleStatusHandlerEvent value)
        bleStatusHandler,
    required TResult Function(_BluetoothConnectEvent value) connect,
    required TResult Function(_BluetoothDisconnectEvent value) disconnect,
    required TResult Function(_BluetoothUpdatePairedIdListEvent value)
        updatePairedIdList,
    required TResult Function(_BluetoothUpdateDiscoveredListEvent value)
        updateDiscoveredList,
    required TResult Function(_BluetoothUpdateDeviceConnectionListEvent value)
        updateDeviceConnectionList,
  }) {
    return updatePairedIdList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_BluetoothInitEvent value)? init,
    TResult Function(_BluetoothListenBleStatusEvent value)? listenBleStatus,
    TResult Function(_BluetoothBleStatusHandlerEvent value)? bleStatusHandler,
    TResult Function(_BluetoothConnectEvent value)? connect,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothUpdatePairedIdListEvent value)?
        updatePairedIdList,
    TResult Function(_BluetoothUpdateDiscoveredListEvent value)?
        updateDiscoveredList,
    TResult Function(_BluetoothUpdateDeviceConnectionListEvent value)?
        updateDeviceConnectionList,
  }) {
    return updatePairedIdList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BluetoothInitEvent value)? init,
    TResult Function(_BluetoothListenBleStatusEvent value)? listenBleStatus,
    TResult Function(_BluetoothBleStatusHandlerEvent value)? bleStatusHandler,
    TResult Function(_BluetoothConnectEvent value)? connect,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothUpdatePairedIdListEvent value)?
        updatePairedIdList,
    TResult Function(_BluetoothUpdateDiscoveredListEvent value)?
        updateDiscoveredList,
    TResult Function(_BluetoothUpdateDeviceConnectionListEvent value)?
        updateDeviceConnectionList,
    required TResult orElse(),
  }) {
    if (updatePairedIdList != null) {
      return updatePairedIdList(this);
    }
    return orElse();
  }
}

abstract class _BluetoothUpdatePairedIdListEvent implements BluetoothEvent {
  const factory _BluetoothUpdatePairedIdListEvent(List<String> list) =
      _$_BluetoothUpdatePairedIdListEvent;

  List<String> get list;
  @JsonKey(ignore: true)
  _$BluetoothUpdatePairedIdListEventCopyWith<_BluetoothUpdatePairedIdListEvent>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$BluetoothUpdateDiscoveredListEventCopyWith<$Res> {
  factory _$BluetoothUpdateDiscoveredListEventCopyWith(
          _BluetoothUpdateDiscoveredListEvent value,
          $Res Function(_BluetoothUpdateDiscoveredListEvent) then) =
      __$BluetoothUpdateDiscoveredListEventCopyWithImpl<$Res>;
  $Res call({List<DiscoveredDevice> list});
}

/// @nodoc
class __$BluetoothUpdateDiscoveredListEventCopyWithImpl<$Res>
    extends _$BluetoothEventCopyWithImpl<$Res>
    implements _$BluetoothUpdateDiscoveredListEventCopyWith<$Res> {
  __$BluetoothUpdateDiscoveredListEventCopyWithImpl(
      _BluetoothUpdateDiscoveredListEvent _value,
      $Res Function(_BluetoothUpdateDiscoveredListEvent) _then)
      : super(_value, (v) => _then(v as _BluetoothUpdateDiscoveredListEvent));

  @override
  _BluetoothUpdateDiscoveredListEvent get _value =>
      super._value as _BluetoothUpdateDiscoveredListEvent;

  @override
  $Res call({
    Object? list = freezed,
  }) {
    return _then(_BluetoothUpdateDiscoveredListEvent(
      list == freezed
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<DiscoveredDevice>,
    ));
  }
}

/// @nodoc

class _$_BluetoothUpdateDiscoveredListEvent
    implements _BluetoothUpdateDiscoveredListEvent {
  const _$_BluetoothUpdateDiscoveredListEvent(this.list);

  @override
  final List<DiscoveredDevice> list;

  @override
  String toString() {
    return 'BluetoothEvent.updateDiscoveredList(list: $list)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BluetoothUpdateDiscoveredListEvent &&
            const DeepCollectionEquality().equals(other.list, list));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(list));

  @JsonKey(ignore: true)
  @override
  _$BluetoothUpdateDiscoveredListEventCopyWith<
          _BluetoothUpdateDiscoveredListEvent>
      get copyWith => __$BluetoothUpdateDiscoveredListEventCopyWithImpl<
          _BluetoothUpdateDiscoveredListEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() listenBleStatus,
    required TResult Function(BleStatus bleStatus) bleStatusHandler,
    required TResult Function(DiscoveredDevice device) connect,
    required TResult Function() disconnect,
    required TResult Function(List<String> list) updatePairedIdList,
    required TResult Function(List<DiscoveredDevice> list) updateDiscoveredList,
    required TResult Function(List<ConnectionStateUpdate> list)
        updateDeviceConnectionList,
  }) {
    return updateDiscoveredList(list);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? listenBleStatus,
    TResult Function(BleStatus bleStatus)? bleStatusHandler,
    TResult Function(DiscoveredDevice device)? connect,
    TResult Function()? disconnect,
    TResult Function(List<String> list)? updatePairedIdList,
    TResult Function(List<DiscoveredDevice> list)? updateDiscoveredList,
    TResult Function(List<ConnectionStateUpdate> list)?
        updateDeviceConnectionList,
  }) {
    return updateDiscoveredList?.call(list);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? listenBleStatus,
    TResult Function(BleStatus bleStatus)? bleStatusHandler,
    TResult Function(DiscoveredDevice device)? connect,
    TResult Function()? disconnect,
    TResult Function(List<String> list)? updatePairedIdList,
    TResult Function(List<DiscoveredDevice> list)? updateDiscoveredList,
    TResult Function(List<ConnectionStateUpdate> list)?
        updateDeviceConnectionList,
    required TResult orElse(),
  }) {
    if (updateDiscoveredList != null) {
      return updateDiscoveredList(list);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BluetoothInitEvent value) init,
    required TResult Function(_BluetoothListenBleStatusEvent value)
        listenBleStatus,
    required TResult Function(_BluetoothBleStatusHandlerEvent value)
        bleStatusHandler,
    required TResult Function(_BluetoothConnectEvent value) connect,
    required TResult Function(_BluetoothDisconnectEvent value) disconnect,
    required TResult Function(_BluetoothUpdatePairedIdListEvent value)
        updatePairedIdList,
    required TResult Function(_BluetoothUpdateDiscoveredListEvent value)
        updateDiscoveredList,
    required TResult Function(_BluetoothUpdateDeviceConnectionListEvent value)
        updateDeviceConnectionList,
  }) {
    return updateDiscoveredList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_BluetoothInitEvent value)? init,
    TResult Function(_BluetoothListenBleStatusEvent value)? listenBleStatus,
    TResult Function(_BluetoothBleStatusHandlerEvent value)? bleStatusHandler,
    TResult Function(_BluetoothConnectEvent value)? connect,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothUpdatePairedIdListEvent value)?
        updatePairedIdList,
    TResult Function(_BluetoothUpdateDiscoveredListEvent value)?
        updateDiscoveredList,
    TResult Function(_BluetoothUpdateDeviceConnectionListEvent value)?
        updateDeviceConnectionList,
  }) {
    return updateDiscoveredList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BluetoothInitEvent value)? init,
    TResult Function(_BluetoothListenBleStatusEvent value)? listenBleStatus,
    TResult Function(_BluetoothBleStatusHandlerEvent value)? bleStatusHandler,
    TResult Function(_BluetoothConnectEvent value)? connect,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothUpdatePairedIdListEvent value)?
        updatePairedIdList,
    TResult Function(_BluetoothUpdateDiscoveredListEvent value)?
        updateDiscoveredList,
    TResult Function(_BluetoothUpdateDeviceConnectionListEvent value)?
        updateDeviceConnectionList,
    required TResult orElse(),
  }) {
    if (updateDiscoveredList != null) {
      return updateDiscoveredList(this);
    }
    return orElse();
  }
}

abstract class _BluetoothUpdateDiscoveredListEvent implements BluetoothEvent {
  const factory _BluetoothUpdateDiscoveredListEvent(
      List<DiscoveredDevice> list) = _$_BluetoothUpdateDiscoveredListEvent;

  List<DiscoveredDevice> get list;
  @JsonKey(ignore: true)
  _$BluetoothUpdateDiscoveredListEventCopyWith<
          _BluetoothUpdateDiscoveredListEvent>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$BluetoothUpdateDeviceConnectionListEventCopyWith<$Res> {
  factory _$BluetoothUpdateDeviceConnectionListEventCopyWith(
          _BluetoothUpdateDeviceConnectionListEvent value,
          $Res Function(_BluetoothUpdateDeviceConnectionListEvent) then) =
      __$BluetoothUpdateDeviceConnectionListEventCopyWithImpl<$Res>;
  $Res call({List<ConnectionStateUpdate> list});
}

/// @nodoc
class __$BluetoothUpdateDeviceConnectionListEventCopyWithImpl<$Res>
    extends _$BluetoothEventCopyWithImpl<$Res>
    implements _$BluetoothUpdateDeviceConnectionListEventCopyWith<$Res> {
  __$BluetoothUpdateDeviceConnectionListEventCopyWithImpl(
      _BluetoothUpdateDeviceConnectionListEvent _value,
      $Res Function(_BluetoothUpdateDeviceConnectionListEvent) _then)
      : super(_value,
            (v) => _then(v as _BluetoothUpdateDeviceConnectionListEvent));

  @override
  _BluetoothUpdateDeviceConnectionListEvent get _value =>
      super._value as _BluetoothUpdateDeviceConnectionListEvent;

  @override
  $Res call({
    Object? list = freezed,
  }) {
    return _then(_BluetoothUpdateDeviceConnectionListEvent(
      list == freezed
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<ConnectionStateUpdate>,
    ));
  }
}

/// @nodoc

class _$_BluetoothUpdateDeviceConnectionListEvent
    implements _BluetoothUpdateDeviceConnectionListEvent {
  const _$_BluetoothUpdateDeviceConnectionListEvent(this.list);

  @override
  final List<ConnectionStateUpdate> list;

  @override
  String toString() {
    return 'BluetoothEvent.updateDeviceConnectionList(list: $list)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BluetoothUpdateDeviceConnectionListEvent &&
            const DeepCollectionEquality().equals(other.list, list));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(list));

  @JsonKey(ignore: true)
  @override
  _$BluetoothUpdateDeviceConnectionListEventCopyWith<
          _BluetoothUpdateDeviceConnectionListEvent>
      get copyWith => __$BluetoothUpdateDeviceConnectionListEventCopyWithImpl<
          _BluetoothUpdateDeviceConnectionListEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() listenBleStatus,
    required TResult Function(BleStatus bleStatus) bleStatusHandler,
    required TResult Function(DiscoveredDevice device) connect,
    required TResult Function() disconnect,
    required TResult Function(List<String> list) updatePairedIdList,
    required TResult Function(List<DiscoveredDevice> list) updateDiscoveredList,
    required TResult Function(List<ConnectionStateUpdate> list)
        updateDeviceConnectionList,
  }) {
    return updateDeviceConnectionList(list);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? listenBleStatus,
    TResult Function(BleStatus bleStatus)? bleStatusHandler,
    TResult Function(DiscoveredDevice device)? connect,
    TResult Function()? disconnect,
    TResult Function(List<String> list)? updatePairedIdList,
    TResult Function(List<DiscoveredDevice> list)? updateDiscoveredList,
    TResult Function(List<ConnectionStateUpdate> list)?
        updateDeviceConnectionList,
  }) {
    return updateDeviceConnectionList?.call(list);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? listenBleStatus,
    TResult Function(BleStatus bleStatus)? bleStatusHandler,
    TResult Function(DiscoveredDevice device)? connect,
    TResult Function()? disconnect,
    TResult Function(List<String> list)? updatePairedIdList,
    TResult Function(List<DiscoveredDevice> list)? updateDiscoveredList,
    TResult Function(List<ConnectionStateUpdate> list)?
        updateDeviceConnectionList,
    required TResult orElse(),
  }) {
    if (updateDeviceConnectionList != null) {
      return updateDeviceConnectionList(list);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BluetoothInitEvent value) init,
    required TResult Function(_BluetoothListenBleStatusEvent value)
        listenBleStatus,
    required TResult Function(_BluetoothBleStatusHandlerEvent value)
        bleStatusHandler,
    required TResult Function(_BluetoothConnectEvent value) connect,
    required TResult Function(_BluetoothDisconnectEvent value) disconnect,
    required TResult Function(_BluetoothUpdatePairedIdListEvent value)
        updatePairedIdList,
    required TResult Function(_BluetoothUpdateDiscoveredListEvent value)
        updateDiscoveredList,
    required TResult Function(_BluetoothUpdateDeviceConnectionListEvent value)
        updateDeviceConnectionList,
  }) {
    return updateDeviceConnectionList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_BluetoothInitEvent value)? init,
    TResult Function(_BluetoothListenBleStatusEvent value)? listenBleStatus,
    TResult Function(_BluetoothBleStatusHandlerEvent value)? bleStatusHandler,
    TResult Function(_BluetoothConnectEvent value)? connect,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothUpdatePairedIdListEvent value)?
        updatePairedIdList,
    TResult Function(_BluetoothUpdateDiscoveredListEvent value)?
        updateDiscoveredList,
    TResult Function(_BluetoothUpdateDeviceConnectionListEvent value)?
        updateDeviceConnectionList,
  }) {
    return updateDeviceConnectionList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BluetoothInitEvent value)? init,
    TResult Function(_BluetoothListenBleStatusEvent value)? listenBleStatus,
    TResult Function(_BluetoothBleStatusHandlerEvent value)? bleStatusHandler,
    TResult Function(_BluetoothConnectEvent value)? connect,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothUpdatePairedIdListEvent value)?
        updatePairedIdList,
    TResult Function(_BluetoothUpdateDiscoveredListEvent value)?
        updateDiscoveredList,
    TResult Function(_BluetoothUpdateDeviceConnectionListEvent value)?
        updateDeviceConnectionList,
    required TResult orElse(),
  }) {
    if (updateDeviceConnectionList != null) {
      return updateDeviceConnectionList(this);
    }
    return orElse();
  }
}

abstract class _BluetoothUpdateDeviceConnectionListEvent
    implements BluetoothEvent {
  const factory _BluetoothUpdateDeviceConnectionListEvent(
          List<ConnectionStateUpdate> list) =
      _$_BluetoothUpdateDeviceConnectionListEvent;

  List<ConnectionStateUpdate> get list;
  @JsonKey(ignore: true)
  _$BluetoothUpdateDeviceConnectionListEventCopyWith<
          _BluetoothUpdateDeviceConnectionListEvent>
      get copyWith => throw _privateConstructorUsedError;
}
