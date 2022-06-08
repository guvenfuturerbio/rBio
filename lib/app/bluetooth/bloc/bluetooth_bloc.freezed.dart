// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bluetooth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$_BluetoothInitEventCopyWith<$Res> {
  factory _$$_BluetoothInitEventCopyWith(_$_BluetoothInitEvent value,
          $Res Function(_$_BluetoothInitEvent) then) =
      __$$_BluetoothInitEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_BluetoothInitEventCopyWithImpl<$Res>
    extends _$BluetoothEventCopyWithImpl<$Res>
    implements _$$_BluetoothInitEventCopyWith<$Res> {
  __$$_BluetoothInitEventCopyWithImpl(
      _$_BluetoothInitEvent _value, $Res Function(_$_BluetoothInitEvent) _then)
      : super(_value, (v) => _then(v as _$_BluetoothInitEvent));

  @override
  _$_BluetoothInitEvent get _value => super._value as _$_BluetoothInitEvent;
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
        (other.runtimeType == runtimeType && other is _$_BluetoothInitEvent);
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
abstract class _$$_BluetoothListenBleStatusEventCopyWith<$Res> {
  factory _$$_BluetoothListenBleStatusEventCopyWith(
          _$_BluetoothListenBleStatusEvent value,
          $Res Function(_$_BluetoothListenBleStatusEvent) then) =
      __$$_BluetoothListenBleStatusEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_BluetoothListenBleStatusEventCopyWithImpl<$Res>
    extends _$BluetoothEventCopyWithImpl<$Res>
    implements _$$_BluetoothListenBleStatusEventCopyWith<$Res> {
  __$$_BluetoothListenBleStatusEventCopyWithImpl(
      _$_BluetoothListenBleStatusEvent _value,
      $Res Function(_$_BluetoothListenBleStatusEvent) _then)
      : super(_value, (v) => _then(v as _$_BluetoothListenBleStatusEvent));

  @override
  _$_BluetoothListenBleStatusEvent get _value =>
      super._value as _$_BluetoothListenBleStatusEvent;
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
            other is _$_BluetoothListenBleStatusEvent);
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
abstract class _$$_BluetoothBleStatusHandlerEventCopyWith<$Res> {
  factory _$$_BluetoothBleStatusHandlerEventCopyWith(
          _$_BluetoothBleStatusHandlerEvent value,
          $Res Function(_$_BluetoothBleStatusHandlerEvent) then) =
      __$$_BluetoothBleStatusHandlerEventCopyWithImpl<$Res>;
  $Res call({BleStatus bleStatus});
}

/// @nodoc
class __$$_BluetoothBleStatusHandlerEventCopyWithImpl<$Res>
    extends _$BluetoothEventCopyWithImpl<$Res>
    implements _$$_BluetoothBleStatusHandlerEventCopyWith<$Res> {
  __$$_BluetoothBleStatusHandlerEventCopyWithImpl(
      _$_BluetoothBleStatusHandlerEvent _value,
      $Res Function(_$_BluetoothBleStatusHandlerEvent) _then)
      : super(_value, (v) => _then(v as _$_BluetoothBleStatusHandlerEvent));

  @override
  _$_BluetoothBleStatusHandlerEvent get _value =>
      super._value as _$_BluetoothBleStatusHandlerEvent;

  @override
  $Res call({
    Object? bleStatus = freezed,
  }) {
    return _then(_$_BluetoothBleStatusHandlerEvent(
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
            other is _$_BluetoothBleStatusHandlerEvent &&
            const DeepCollectionEquality().equals(other.bleStatus, bleStatus));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(bleStatus));

  @JsonKey(ignore: true)
  @override
  _$$_BluetoothBleStatusHandlerEventCopyWith<_$_BluetoothBleStatusHandlerEvent>
      get copyWith => __$$_BluetoothBleStatusHandlerEventCopyWithImpl<
          _$_BluetoothBleStatusHandlerEvent>(this, _$identity);

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
  const factory _BluetoothBleStatusHandlerEvent(final BleStatus bleStatus) =
      _$_BluetoothBleStatusHandlerEvent;

  BleStatus get bleStatus => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$_BluetoothBleStatusHandlerEventCopyWith<_$_BluetoothBleStatusHandlerEvent>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_BluetoothConnectEventCopyWith<$Res> {
  factory _$$_BluetoothConnectEventCopyWith(_$_BluetoothConnectEvent value,
          $Res Function(_$_BluetoothConnectEvent) then) =
      __$$_BluetoothConnectEventCopyWithImpl<$Res>;
  $Res call({DiscoveredDevice device});
}

/// @nodoc
class __$$_BluetoothConnectEventCopyWithImpl<$Res>
    extends _$BluetoothEventCopyWithImpl<$Res>
    implements _$$_BluetoothConnectEventCopyWith<$Res> {
  __$$_BluetoothConnectEventCopyWithImpl(_$_BluetoothConnectEvent _value,
      $Res Function(_$_BluetoothConnectEvent) _then)
      : super(_value, (v) => _then(v as _$_BluetoothConnectEvent));

  @override
  _$_BluetoothConnectEvent get _value =>
      super._value as _$_BluetoothConnectEvent;

  @override
  $Res call({
    Object? device = freezed,
  }) {
    return _then(_$_BluetoothConnectEvent(
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
            other is _$_BluetoothConnectEvent &&
            const DeepCollectionEquality().equals(other.device, device));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(device));

  @JsonKey(ignore: true)
  @override
  _$$_BluetoothConnectEventCopyWith<_$_BluetoothConnectEvent> get copyWith =>
      __$$_BluetoothConnectEventCopyWithImpl<_$_BluetoothConnectEvent>(
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
  const factory _BluetoothConnectEvent(final DiscoveredDevice device) =
      _$_BluetoothConnectEvent;

  DiscoveredDevice get device => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$_BluetoothConnectEventCopyWith<_$_BluetoothConnectEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_BluetoothDisconnectEventCopyWith<$Res> {
  factory _$$_BluetoothDisconnectEventCopyWith(
          _$_BluetoothDisconnectEvent value,
          $Res Function(_$_BluetoothDisconnectEvent) then) =
      __$$_BluetoothDisconnectEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_BluetoothDisconnectEventCopyWithImpl<$Res>
    extends _$BluetoothEventCopyWithImpl<$Res>
    implements _$$_BluetoothDisconnectEventCopyWith<$Res> {
  __$$_BluetoothDisconnectEventCopyWithImpl(_$_BluetoothDisconnectEvent _value,
      $Res Function(_$_BluetoothDisconnectEvent) _then)
      : super(_value, (v) => _then(v as _$_BluetoothDisconnectEvent));

  @override
  _$_BluetoothDisconnectEvent get _value =>
      super._value as _$_BluetoothDisconnectEvent;
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
            other is _$_BluetoothDisconnectEvent);
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
abstract class _$$_BluetoothUpdatePairedIdListEventCopyWith<$Res> {
  factory _$$_BluetoothUpdatePairedIdListEventCopyWith(
          _$_BluetoothUpdatePairedIdListEvent value,
          $Res Function(_$_BluetoothUpdatePairedIdListEvent) then) =
      __$$_BluetoothUpdatePairedIdListEventCopyWithImpl<$Res>;
  $Res call({List<String> list});
}

/// @nodoc
class __$$_BluetoothUpdatePairedIdListEventCopyWithImpl<$Res>
    extends _$BluetoothEventCopyWithImpl<$Res>
    implements _$$_BluetoothUpdatePairedIdListEventCopyWith<$Res> {
  __$$_BluetoothUpdatePairedIdListEventCopyWithImpl(
      _$_BluetoothUpdatePairedIdListEvent _value,
      $Res Function(_$_BluetoothUpdatePairedIdListEvent) _then)
      : super(_value, (v) => _then(v as _$_BluetoothUpdatePairedIdListEvent));

  @override
  _$_BluetoothUpdatePairedIdListEvent get _value =>
      super._value as _$_BluetoothUpdatePairedIdListEvent;

  @override
  $Res call({
    Object? list = freezed,
  }) {
    return _then(_$_BluetoothUpdatePairedIdListEvent(
      list == freezed
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_BluetoothUpdatePairedIdListEvent
    implements _BluetoothUpdatePairedIdListEvent {
  const _$_BluetoothUpdatePairedIdListEvent(final List<String> list)
      : _list = list;

  final List<String> _list;
  @override
  List<String> get list {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  String toString() {
    return 'BluetoothEvent.updatePairedIdList(list: $list)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BluetoothUpdatePairedIdListEvent &&
            const DeepCollectionEquality().equals(other._list, _list));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_list));

  @JsonKey(ignore: true)
  @override
  _$$_BluetoothUpdatePairedIdListEventCopyWith<
          _$_BluetoothUpdatePairedIdListEvent>
      get copyWith => __$$_BluetoothUpdatePairedIdListEventCopyWithImpl<
          _$_BluetoothUpdatePairedIdListEvent>(this, _$identity);

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
  const factory _BluetoothUpdatePairedIdListEvent(final List<String> list) =
      _$_BluetoothUpdatePairedIdListEvent;

  List<String> get list => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$_BluetoothUpdatePairedIdListEventCopyWith<
          _$_BluetoothUpdatePairedIdListEvent>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_BluetoothUpdateDiscoveredListEventCopyWith<$Res> {
  factory _$$_BluetoothUpdateDiscoveredListEventCopyWith(
          _$_BluetoothUpdateDiscoveredListEvent value,
          $Res Function(_$_BluetoothUpdateDiscoveredListEvent) then) =
      __$$_BluetoothUpdateDiscoveredListEventCopyWithImpl<$Res>;
  $Res call({List<DiscoveredDevice> list});
}

/// @nodoc
class __$$_BluetoothUpdateDiscoveredListEventCopyWithImpl<$Res>
    extends _$BluetoothEventCopyWithImpl<$Res>
    implements _$$_BluetoothUpdateDiscoveredListEventCopyWith<$Res> {
  __$$_BluetoothUpdateDiscoveredListEventCopyWithImpl(
      _$_BluetoothUpdateDiscoveredListEvent _value,
      $Res Function(_$_BluetoothUpdateDiscoveredListEvent) _then)
      : super(_value, (v) => _then(v as _$_BluetoothUpdateDiscoveredListEvent));

  @override
  _$_BluetoothUpdateDiscoveredListEvent get _value =>
      super._value as _$_BluetoothUpdateDiscoveredListEvent;

  @override
  $Res call({
    Object? list = freezed,
  }) {
    return _then(_$_BluetoothUpdateDiscoveredListEvent(
      list == freezed
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<DiscoveredDevice>,
    ));
  }
}

/// @nodoc

class _$_BluetoothUpdateDiscoveredListEvent
    implements _BluetoothUpdateDiscoveredListEvent {
  const _$_BluetoothUpdateDiscoveredListEvent(final List<DiscoveredDevice> list)
      : _list = list;

  final List<DiscoveredDevice> _list;
  @override
  List<DiscoveredDevice> get list {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  String toString() {
    return 'BluetoothEvent.updateDiscoveredList(list: $list)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BluetoothUpdateDiscoveredListEvent &&
            const DeepCollectionEquality().equals(other._list, _list));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_list));

  @JsonKey(ignore: true)
  @override
  _$$_BluetoothUpdateDiscoveredListEventCopyWith<
          _$_BluetoothUpdateDiscoveredListEvent>
      get copyWith => __$$_BluetoothUpdateDiscoveredListEventCopyWithImpl<
          _$_BluetoothUpdateDiscoveredListEvent>(this, _$identity);

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
          final List<DiscoveredDevice> list) =
      _$_BluetoothUpdateDiscoveredListEvent;

  List<DiscoveredDevice> get list => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$_BluetoothUpdateDiscoveredListEventCopyWith<
          _$_BluetoothUpdateDiscoveredListEvent>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_BluetoothUpdateDeviceConnectionListEventCopyWith<$Res> {
  factory _$$_BluetoothUpdateDeviceConnectionListEventCopyWith(
          _$_BluetoothUpdateDeviceConnectionListEvent value,
          $Res Function(_$_BluetoothUpdateDeviceConnectionListEvent) then) =
      __$$_BluetoothUpdateDeviceConnectionListEventCopyWithImpl<$Res>;
  $Res call({List<ConnectionStateUpdate> list});
}

/// @nodoc
class __$$_BluetoothUpdateDeviceConnectionListEventCopyWithImpl<$Res>
    extends _$BluetoothEventCopyWithImpl<$Res>
    implements _$$_BluetoothUpdateDeviceConnectionListEventCopyWith<$Res> {
  __$$_BluetoothUpdateDeviceConnectionListEventCopyWithImpl(
      _$_BluetoothUpdateDeviceConnectionListEvent _value,
      $Res Function(_$_BluetoothUpdateDeviceConnectionListEvent) _then)
      : super(_value,
            (v) => _then(v as _$_BluetoothUpdateDeviceConnectionListEvent));

  @override
  _$_BluetoothUpdateDeviceConnectionListEvent get _value =>
      super._value as _$_BluetoothUpdateDeviceConnectionListEvent;

  @override
  $Res call({
    Object? list = freezed,
  }) {
    return _then(_$_BluetoothUpdateDeviceConnectionListEvent(
      list == freezed
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<ConnectionStateUpdate>,
    ));
  }
}

/// @nodoc

class _$_BluetoothUpdateDeviceConnectionListEvent
    implements _BluetoothUpdateDeviceConnectionListEvent {
  const _$_BluetoothUpdateDeviceConnectionListEvent(
      final List<ConnectionStateUpdate> list)
      : _list = list;

  final List<ConnectionStateUpdate> _list;
  @override
  List<ConnectionStateUpdate> get list {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  String toString() {
    return 'BluetoothEvent.updateDeviceConnectionList(list: $list)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BluetoothUpdateDeviceConnectionListEvent &&
            const DeepCollectionEquality().equals(other._list, _list));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_list));

  @JsonKey(ignore: true)
  @override
  _$$_BluetoothUpdateDeviceConnectionListEventCopyWith<
          _$_BluetoothUpdateDeviceConnectionListEvent>
      get copyWith => __$$_BluetoothUpdateDeviceConnectionListEventCopyWithImpl<
          _$_BluetoothUpdateDeviceConnectionListEvent>(this, _$identity);

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
          final List<ConnectionStateUpdate> list) =
      _$_BluetoothUpdateDeviceConnectionListEvent;

  List<ConnectionStateUpdate> get list => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$_BluetoothUpdateDeviceConnectionListEventCopyWith<
          _$_BluetoothUpdateDeviceConnectionListEvent>
      get copyWith => throw _privateConstructorUsedError;
}
