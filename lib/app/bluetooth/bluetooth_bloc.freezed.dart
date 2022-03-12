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

  _BluetoothGotPairedDevicesEvent gotPairedDevices() {
    return const _BluetoothGotPairedDevicesEvent();
  }

  _BluetoothDeviceConnectedEvent deviceConnected() {
    return const _BluetoothDeviceConnectedEvent();
  }

  _BluetoothDeviceConnectionUpdatedEvent deviceConnectionUpdate(
      List<ConnectionStateUpdate> args) {
    return _BluetoothDeviceConnectionUpdatedEvent(
      args,
    );
  }

  _BluetoothScanStartedEvent scanStarted() {
    return const _BluetoothScanStartedEvent();
  }

  _BluetoothScanStoppedEvent scanStopped() {
    return const _BluetoothScanStoppedEvent();
  }

  _BluetoothConnectedEvent connected(DiscoveredDevice device) {
    return _BluetoothConnectedEvent(
      device,
    );
  }

  _BluetoothClearedControlPointResponseEvent clearedControlPointResponse() {
    return const _BluetoothClearedControlPointResponseEvent();
  }

  _BluetoothDisconnectEvent disconnect(String deviceId) {
    return _BluetoothDisconnectEvent(
      deviceId,
    );
  }

  _BluetoothSavePairedDevicesEvent savePairedDevices(PairedDevice pairedDevice,
      [bool? checkSuccess, List<int>? recordAccessData]) {
    return _BluetoothSavePairedDevicesEvent(
      pairedDevice,
      checkSuccess,
      recordAccessData,
    );
  }

  _BluetoothPairedDeviceDeletedEvent pairedDeviceDeleted(String id) {
    return _BluetoothPairedDeviceDeletedEvent(
      id,
    );
  }

  _BluetoothScaleSubscribedEvent scaleSubscribed(PairedDevice pairedDevice) {
    return _BluetoothScaleSubscribedEvent(
      pairedDevice,
    );
  }
}

/// @nodoc
const $BluetoothEvent = _$BluetoothEventTearOff();

/// @nodoc
mixin _$BluetoothEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() gotPairedDevices,
    required TResult Function() deviceConnected,
    required TResult Function(List<ConnectionStateUpdate> args)
        deviceConnectionUpdate,
    required TResult Function() scanStarted,
    required TResult Function() scanStopped,
    required TResult Function(DiscoveredDevice device) connected,
    required TResult Function() clearedControlPointResponse,
    required TResult Function(String deviceId) disconnect,
    required TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)
        savePairedDevices,
    required TResult Function(String id) pairedDeviceDeleted,
    required TResult Function(PairedDevice pairedDevice) scaleSubscribed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? gotPairedDevices,
    TResult Function()? deviceConnected,
    TResult Function(List<ConnectionStateUpdate> args)? deviceConnectionUpdate,
    TResult Function()? scanStarted,
    TResult Function()? scanStopped,
    TResult Function(DiscoveredDevice device)? connected,
    TResult Function()? clearedControlPointResponse,
    TResult Function(String deviceId)? disconnect,
    TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)?
        savePairedDevices,
    TResult Function(String id)? pairedDeviceDeleted,
    TResult Function(PairedDevice pairedDevice)? scaleSubscribed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? gotPairedDevices,
    TResult Function()? deviceConnected,
    TResult Function(List<ConnectionStateUpdate> args)? deviceConnectionUpdate,
    TResult Function()? scanStarted,
    TResult Function()? scanStopped,
    TResult Function(DiscoveredDevice device)? connected,
    TResult Function()? clearedControlPointResponse,
    TResult Function(String deviceId)? disconnect,
    TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)?
        savePairedDevices,
    TResult Function(String id)? pairedDeviceDeleted,
    TResult Function(PairedDevice pairedDevice)? scaleSubscribed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BluetoothGotPairedDevicesEvent value)
        gotPairedDevices,
    required TResult Function(_BluetoothDeviceConnectedEvent value)
        deviceConnected,
    required TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)
        deviceConnectionUpdate,
    required TResult Function(_BluetoothScanStartedEvent value) scanStarted,
    required TResult Function(_BluetoothScanStoppedEvent value) scanStopped,
    required TResult Function(_BluetoothConnectedEvent value) connected,
    required TResult Function(_BluetoothClearedControlPointResponseEvent value)
        clearedControlPointResponse,
    required TResult Function(_BluetoothDisconnectEvent value) disconnect,
    required TResult Function(_BluetoothSavePairedDevicesEvent value)
        savePairedDevices,
    required TResult Function(_BluetoothPairedDeviceDeletedEvent value)
        pairedDeviceDeleted,
    required TResult Function(_BluetoothScaleSubscribedEvent value)
        scaleSubscribed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_BluetoothGotPairedDevicesEvent value)? gotPairedDevices,
    TResult Function(_BluetoothDeviceConnectedEvent value)? deviceConnected,
    TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)?
        deviceConnectionUpdate,
    TResult Function(_BluetoothScanStartedEvent value)? scanStarted,
    TResult Function(_BluetoothScanStoppedEvent value)? scanStopped,
    TResult Function(_BluetoothConnectedEvent value)? connected,
    TResult Function(_BluetoothClearedControlPointResponseEvent value)?
        clearedControlPointResponse,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothSavePairedDevicesEvent value)? savePairedDevices,
    TResult Function(_BluetoothPairedDeviceDeletedEvent value)?
        pairedDeviceDeleted,
    TResult Function(_BluetoothScaleSubscribedEvent value)? scaleSubscribed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BluetoothGotPairedDevicesEvent value)? gotPairedDevices,
    TResult Function(_BluetoothDeviceConnectedEvent value)? deviceConnected,
    TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)?
        deviceConnectionUpdate,
    TResult Function(_BluetoothScanStartedEvent value)? scanStarted,
    TResult Function(_BluetoothScanStoppedEvent value)? scanStopped,
    TResult Function(_BluetoothConnectedEvent value)? connected,
    TResult Function(_BluetoothClearedControlPointResponseEvent value)?
        clearedControlPointResponse,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothSavePairedDevicesEvent value)? savePairedDevices,
    TResult Function(_BluetoothPairedDeviceDeletedEvent value)?
        pairedDeviceDeleted,
    TResult Function(_BluetoothScaleSubscribedEvent value)? scaleSubscribed,
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
abstract class _$BluetoothGotPairedDevicesEventCopyWith<$Res> {
  factory _$BluetoothGotPairedDevicesEventCopyWith(
          _BluetoothGotPairedDevicesEvent value,
          $Res Function(_BluetoothGotPairedDevicesEvent) then) =
      __$BluetoothGotPairedDevicesEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$BluetoothGotPairedDevicesEventCopyWithImpl<$Res>
    extends _$BluetoothEventCopyWithImpl<$Res>
    implements _$BluetoothGotPairedDevicesEventCopyWith<$Res> {
  __$BluetoothGotPairedDevicesEventCopyWithImpl(
      _BluetoothGotPairedDevicesEvent _value,
      $Res Function(_BluetoothGotPairedDevicesEvent) _then)
      : super(_value, (v) => _then(v as _BluetoothGotPairedDevicesEvent));

  @override
  _BluetoothGotPairedDevicesEvent get _value =>
      super._value as _BluetoothGotPairedDevicesEvent;
}

/// @nodoc

class _$_BluetoothGotPairedDevicesEvent
    implements _BluetoothGotPairedDevicesEvent {
  const _$_BluetoothGotPairedDevicesEvent();

  @override
  String toString() {
    return 'BluetoothEvent.gotPairedDevices()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BluetoothGotPairedDevicesEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() gotPairedDevices,
    required TResult Function() deviceConnected,
    required TResult Function(List<ConnectionStateUpdate> args)
        deviceConnectionUpdate,
    required TResult Function() scanStarted,
    required TResult Function() scanStopped,
    required TResult Function(DiscoveredDevice device) connected,
    required TResult Function() clearedControlPointResponse,
    required TResult Function(String deviceId) disconnect,
    required TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)
        savePairedDevices,
    required TResult Function(String id) pairedDeviceDeleted,
    required TResult Function(PairedDevice pairedDevice) scaleSubscribed,
  }) {
    return gotPairedDevices();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? gotPairedDevices,
    TResult Function()? deviceConnected,
    TResult Function(List<ConnectionStateUpdate> args)? deviceConnectionUpdate,
    TResult Function()? scanStarted,
    TResult Function()? scanStopped,
    TResult Function(DiscoveredDevice device)? connected,
    TResult Function()? clearedControlPointResponse,
    TResult Function(String deviceId)? disconnect,
    TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)?
        savePairedDevices,
    TResult Function(String id)? pairedDeviceDeleted,
    TResult Function(PairedDevice pairedDevice)? scaleSubscribed,
  }) {
    return gotPairedDevices?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? gotPairedDevices,
    TResult Function()? deviceConnected,
    TResult Function(List<ConnectionStateUpdate> args)? deviceConnectionUpdate,
    TResult Function()? scanStarted,
    TResult Function()? scanStopped,
    TResult Function(DiscoveredDevice device)? connected,
    TResult Function()? clearedControlPointResponse,
    TResult Function(String deviceId)? disconnect,
    TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)?
        savePairedDevices,
    TResult Function(String id)? pairedDeviceDeleted,
    TResult Function(PairedDevice pairedDevice)? scaleSubscribed,
    required TResult orElse(),
  }) {
    if (gotPairedDevices != null) {
      return gotPairedDevices();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BluetoothGotPairedDevicesEvent value)
        gotPairedDevices,
    required TResult Function(_BluetoothDeviceConnectedEvent value)
        deviceConnected,
    required TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)
        deviceConnectionUpdate,
    required TResult Function(_BluetoothScanStartedEvent value) scanStarted,
    required TResult Function(_BluetoothScanStoppedEvent value) scanStopped,
    required TResult Function(_BluetoothConnectedEvent value) connected,
    required TResult Function(_BluetoothClearedControlPointResponseEvent value)
        clearedControlPointResponse,
    required TResult Function(_BluetoothDisconnectEvent value) disconnect,
    required TResult Function(_BluetoothSavePairedDevicesEvent value)
        savePairedDevices,
    required TResult Function(_BluetoothPairedDeviceDeletedEvent value)
        pairedDeviceDeleted,
    required TResult Function(_BluetoothScaleSubscribedEvent value)
        scaleSubscribed,
  }) {
    return gotPairedDevices(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_BluetoothGotPairedDevicesEvent value)? gotPairedDevices,
    TResult Function(_BluetoothDeviceConnectedEvent value)? deviceConnected,
    TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)?
        deviceConnectionUpdate,
    TResult Function(_BluetoothScanStartedEvent value)? scanStarted,
    TResult Function(_BluetoothScanStoppedEvent value)? scanStopped,
    TResult Function(_BluetoothConnectedEvent value)? connected,
    TResult Function(_BluetoothClearedControlPointResponseEvent value)?
        clearedControlPointResponse,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothSavePairedDevicesEvent value)? savePairedDevices,
    TResult Function(_BluetoothPairedDeviceDeletedEvent value)?
        pairedDeviceDeleted,
    TResult Function(_BluetoothScaleSubscribedEvent value)? scaleSubscribed,
  }) {
    return gotPairedDevices?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BluetoothGotPairedDevicesEvent value)? gotPairedDevices,
    TResult Function(_BluetoothDeviceConnectedEvent value)? deviceConnected,
    TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)?
        deviceConnectionUpdate,
    TResult Function(_BluetoothScanStartedEvent value)? scanStarted,
    TResult Function(_BluetoothScanStoppedEvent value)? scanStopped,
    TResult Function(_BluetoothConnectedEvent value)? connected,
    TResult Function(_BluetoothClearedControlPointResponseEvent value)?
        clearedControlPointResponse,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothSavePairedDevicesEvent value)? savePairedDevices,
    TResult Function(_BluetoothPairedDeviceDeletedEvent value)?
        pairedDeviceDeleted,
    TResult Function(_BluetoothScaleSubscribedEvent value)? scaleSubscribed,
    required TResult orElse(),
  }) {
    if (gotPairedDevices != null) {
      return gotPairedDevices(this);
    }
    return orElse();
  }
}

abstract class _BluetoothGotPairedDevicesEvent implements BluetoothEvent {
  const factory _BluetoothGotPairedDevicesEvent() =
      _$_BluetoothGotPairedDevicesEvent;
}

/// @nodoc
abstract class _$BluetoothDeviceConnectedEventCopyWith<$Res> {
  factory _$BluetoothDeviceConnectedEventCopyWith(
          _BluetoothDeviceConnectedEvent value,
          $Res Function(_BluetoothDeviceConnectedEvent) then) =
      __$BluetoothDeviceConnectedEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$BluetoothDeviceConnectedEventCopyWithImpl<$Res>
    extends _$BluetoothEventCopyWithImpl<$Res>
    implements _$BluetoothDeviceConnectedEventCopyWith<$Res> {
  __$BluetoothDeviceConnectedEventCopyWithImpl(
      _BluetoothDeviceConnectedEvent _value,
      $Res Function(_BluetoothDeviceConnectedEvent) _then)
      : super(_value, (v) => _then(v as _BluetoothDeviceConnectedEvent));

  @override
  _BluetoothDeviceConnectedEvent get _value =>
      super._value as _BluetoothDeviceConnectedEvent;
}

/// @nodoc

class _$_BluetoothDeviceConnectedEvent
    implements _BluetoothDeviceConnectedEvent {
  const _$_BluetoothDeviceConnectedEvent();

  @override
  String toString() {
    return 'BluetoothEvent.deviceConnected()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BluetoothDeviceConnectedEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() gotPairedDevices,
    required TResult Function() deviceConnected,
    required TResult Function(List<ConnectionStateUpdate> args)
        deviceConnectionUpdate,
    required TResult Function() scanStarted,
    required TResult Function() scanStopped,
    required TResult Function(DiscoveredDevice device) connected,
    required TResult Function() clearedControlPointResponse,
    required TResult Function(String deviceId) disconnect,
    required TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)
        savePairedDevices,
    required TResult Function(String id) pairedDeviceDeleted,
    required TResult Function(PairedDevice pairedDevice) scaleSubscribed,
  }) {
    return deviceConnected();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? gotPairedDevices,
    TResult Function()? deviceConnected,
    TResult Function(List<ConnectionStateUpdate> args)? deviceConnectionUpdate,
    TResult Function()? scanStarted,
    TResult Function()? scanStopped,
    TResult Function(DiscoveredDevice device)? connected,
    TResult Function()? clearedControlPointResponse,
    TResult Function(String deviceId)? disconnect,
    TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)?
        savePairedDevices,
    TResult Function(String id)? pairedDeviceDeleted,
    TResult Function(PairedDevice pairedDevice)? scaleSubscribed,
  }) {
    return deviceConnected?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? gotPairedDevices,
    TResult Function()? deviceConnected,
    TResult Function(List<ConnectionStateUpdate> args)? deviceConnectionUpdate,
    TResult Function()? scanStarted,
    TResult Function()? scanStopped,
    TResult Function(DiscoveredDevice device)? connected,
    TResult Function()? clearedControlPointResponse,
    TResult Function(String deviceId)? disconnect,
    TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)?
        savePairedDevices,
    TResult Function(String id)? pairedDeviceDeleted,
    TResult Function(PairedDevice pairedDevice)? scaleSubscribed,
    required TResult orElse(),
  }) {
    if (deviceConnected != null) {
      return deviceConnected();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BluetoothGotPairedDevicesEvent value)
        gotPairedDevices,
    required TResult Function(_BluetoothDeviceConnectedEvent value)
        deviceConnected,
    required TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)
        deviceConnectionUpdate,
    required TResult Function(_BluetoothScanStartedEvent value) scanStarted,
    required TResult Function(_BluetoothScanStoppedEvent value) scanStopped,
    required TResult Function(_BluetoothConnectedEvent value) connected,
    required TResult Function(_BluetoothClearedControlPointResponseEvent value)
        clearedControlPointResponse,
    required TResult Function(_BluetoothDisconnectEvent value) disconnect,
    required TResult Function(_BluetoothSavePairedDevicesEvent value)
        savePairedDevices,
    required TResult Function(_BluetoothPairedDeviceDeletedEvent value)
        pairedDeviceDeleted,
    required TResult Function(_BluetoothScaleSubscribedEvent value)
        scaleSubscribed,
  }) {
    return deviceConnected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_BluetoothGotPairedDevicesEvent value)? gotPairedDevices,
    TResult Function(_BluetoothDeviceConnectedEvent value)? deviceConnected,
    TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)?
        deviceConnectionUpdate,
    TResult Function(_BluetoothScanStartedEvent value)? scanStarted,
    TResult Function(_BluetoothScanStoppedEvent value)? scanStopped,
    TResult Function(_BluetoothConnectedEvent value)? connected,
    TResult Function(_BluetoothClearedControlPointResponseEvent value)?
        clearedControlPointResponse,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothSavePairedDevicesEvent value)? savePairedDevices,
    TResult Function(_BluetoothPairedDeviceDeletedEvent value)?
        pairedDeviceDeleted,
    TResult Function(_BluetoothScaleSubscribedEvent value)? scaleSubscribed,
  }) {
    return deviceConnected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BluetoothGotPairedDevicesEvent value)? gotPairedDevices,
    TResult Function(_BluetoothDeviceConnectedEvent value)? deviceConnected,
    TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)?
        deviceConnectionUpdate,
    TResult Function(_BluetoothScanStartedEvent value)? scanStarted,
    TResult Function(_BluetoothScanStoppedEvent value)? scanStopped,
    TResult Function(_BluetoothConnectedEvent value)? connected,
    TResult Function(_BluetoothClearedControlPointResponseEvent value)?
        clearedControlPointResponse,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothSavePairedDevicesEvent value)? savePairedDevices,
    TResult Function(_BluetoothPairedDeviceDeletedEvent value)?
        pairedDeviceDeleted,
    TResult Function(_BluetoothScaleSubscribedEvent value)? scaleSubscribed,
    required TResult orElse(),
  }) {
    if (deviceConnected != null) {
      return deviceConnected(this);
    }
    return orElse();
  }
}

abstract class _BluetoothDeviceConnectedEvent implements BluetoothEvent {
  const factory _BluetoothDeviceConnectedEvent() =
      _$_BluetoothDeviceConnectedEvent;
}

/// @nodoc
abstract class _$BluetoothDeviceConnectionUpdatedEventCopyWith<$Res> {
  factory _$BluetoothDeviceConnectionUpdatedEventCopyWith(
          _BluetoothDeviceConnectionUpdatedEvent value,
          $Res Function(_BluetoothDeviceConnectionUpdatedEvent) then) =
      __$BluetoothDeviceConnectionUpdatedEventCopyWithImpl<$Res>;
  $Res call({List<ConnectionStateUpdate> args});
}

/// @nodoc
class __$BluetoothDeviceConnectionUpdatedEventCopyWithImpl<$Res>
    extends _$BluetoothEventCopyWithImpl<$Res>
    implements _$BluetoothDeviceConnectionUpdatedEventCopyWith<$Res> {
  __$BluetoothDeviceConnectionUpdatedEventCopyWithImpl(
      _BluetoothDeviceConnectionUpdatedEvent _value,
      $Res Function(_BluetoothDeviceConnectionUpdatedEvent) _then)
      : super(
            _value, (v) => _then(v as _BluetoothDeviceConnectionUpdatedEvent));

  @override
  _BluetoothDeviceConnectionUpdatedEvent get _value =>
      super._value as _BluetoothDeviceConnectionUpdatedEvent;

  @override
  $Res call({
    Object? args = freezed,
  }) {
    return _then(_BluetoothDeviceConnectionUpdatedEvent(
      args == freezed
          ? _value.args
          : args // ignore: cast_nullable_to_non_nullable
              as List<ConnectionStateUpdate>,
    ));
  }
}

/// @nodoc

class _$_BluetoothDeviceConnectionUpdatedEvent
    implements _BluetoothDeviceConnectionUpdatedEvent {
  const _$_BluetoothDeviceConnectionUpdatedEvent(this.args);

  @override
  final List<ConnectionStateUpdate> args;

  @override
  String toString() {
    return 'BluetoothEvent.deviceConnectionUpdate(args: $args)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BluetoothDeviceConnectionUpdatedEvent &&
            const DeepCollectionEquality().equals(other.args, args));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(args));

  @JsonKey(ignore: true)
  @override
  _$BluetoothDeviceConnectionUpdatedEventCopyWith<
          _BluetoothDeviceConnectionUpdatedEvent>
      get copyWith => __$BluetoothDeviceConnectionUpdatedEventCopyWithImpl<
          _BluetoothDeviceConnectionUpdatedEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() gotPairedDevices,
    required TResult Function() deviceConnected,
    required TResult Function(List<ConnectionStateUpdate> args)
        deviceConnectionUpdate,
    required TResult Function() scanStarted,
    required TResult Function() scanStopped,
    required TResult Function(DiscoveredDevice device) connected,
    required TResult Function() clearedControlPointResponse,
    required TResult Function(String deviceId) disconnect,
    required TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)
        savePairedDevices,
    required TResult Function(String id) pairedDeviceDeleted,
    required TResult Function(PairedDevice pairedDevice) scaleSubscribed,
  }) {
    return deviceConnectionUpdate(args);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? gotPairedDevices,
    TResult Function()? deviceConnected,
    TResult Function(List<ConnectionStateUpdate> args)? deviceConnectionUpdate,
    TResult Function()? scanStarted,
    TResult Function()? scanStopped,
    TResult Function(DiscoveredDevice device)? connected,
    TResult Function()? clearedControlPointResponse,
    TResult Function(String deviceId)? disconnect,
    TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)?
        savePairedDevices,
    TResult Function(String id)? pairedDeviceDeleted,
    TResult Function(PairedDevice pairedDevice)? scaleSubscribed,
  }) {
    return deviceConnectionUpdate?.call(args);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? gotPairedDevices,
    TResult Function()? deviceConnected,
    TResult Function(List<ConnectionStateUpdate> args)? deviceConnectionUpdate,
    TResult Function()? scanStarted,
    TResult Function()? scanStopped,
    TResult Function(DiscoveredDevice device)? connected,
    TResult Function()? clearedControlPointResponse,
    TResult Function(String deviceId)? disconnect,
    TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)?
        savePairedDevices,
    TResult Function(String id)? pairedDeviceDeleted,
    TResult Function(PairedDevice pairedDevice)? scaleSubscribed,
    required TResult orElse(),
  }) {
    if (deviceConnectionUpdate != null) {
      return deviceConnectionUpdate(args);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BluetoothGotPairedDevicesEvent value)
        gotPairedDevices,
    required TResult Function(_BluetoothDeviceConnectedEvent value)
        deviceConnected,
    required TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)
        deviceConnectionUpdate,
    required TResult Function(_BluetoothScanStartedEvent value) scanStarted,
    required TResult Function(_BluetoothScanStoppedEvent value) scanStopped,
    required TResult Function(_BluetoothConnectedEvent value) connected,
    required TResult Function(_BluetoothClearedControlPointResponseEvent value)
        clearedControlPointResponse,
    required TResult Function(_BluetoothDisconnectEvent value) disconnect,
    required TResult Function(_BluetoothSavePairedDevicesEvent value)
        savePairedDevices,
    required TResult Function(_BluetoothPairedDeviceDeletedEvent value)
        pairedDeviceDeleted,
    required TResult Function(_BluetoothScaleSubscribedEvent value)
        scaleSubscribed,
  }) {
    return deviceConnectionUpdate(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_BluetoothGotPairedDevicesEvent value)? gotPairedDevices,
    TResult Function(_BluetoothDeviceConnectedEvent value)? deviceConnected,
    TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)?
        deviceConnectionUpdate,
    TResult Function(_BluetoothScanStartedEvent value)? scanStarted,
    TResult Function(_BluetoothScanStoppedEvent value)? scanStopped,
    TResult Function(_BluetoothConnectedEvent value)? connected,
    TResult Function(_BluetoothClearedControlPointResponseEvent value)?
        clearedControlPointResponse,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothSavePairedDevicesEvent value)? savePairedDevices,
    TResult Function(_BluetoothPairedDeviceDeletedEvent value)?
        pairedDeviceDeleted,
    TResult Function(_BluetoothScaleSubscribedEvent value)? scaleSubscribed,
  }) {
    return deviceConnectionUpdate?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BluetoothGotPairedDevicesEvent value)? gotPairedDevices,
    TResult Function(_BluetoothDeviceConnectedEvent value)? deviceConnected,
    TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)?
        deviceConnectionUpdate,
    TResult Function(_BluetoothScanStartedEvent value)? scanStarted,
    TResult Function(_BluetoothScanStoppedEvent value)? scanStopped,
    TResult Function(_BluetoothConnectedEvent value)? connected,
    TResult Function(_BluetoothClearedControlPointResponseEvent value)?
        clearedControlPointResponse,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothSavePairedDevicesEvent value)? savePairedDevices,
    TResult Function(_BluetoothPairedDeviceDeletedEvent value)?
        pairedDeviceDeleted,
    TResult Function(_BluetoothScaleSubscribedEvent value)? scaleSubscribed,
    required TResult orElse(),
  }) {
    if (deviceConnectionUpdate != null) {
      return deviceConnectionUpdate(this);
    }
    return orElse();
  }
}

abstract class _BluetoothDeviceConnectionUpdatedEvent
    implements BluetoothEvent {
  const factory _BluetoothDeviceConnectionUpdatedEvent(
          List<ConnectionStateUpdate> args) =
      _$_BluetoothDeviceConnectionUpdatedEvent;

  List<ConnectionStateUpdate> get args;
  @JsonKey(ignore: true)
  _$BluetoothDeviceConnectionUpdatedEventCopyWith<
          _BluetoothDeviceConnectionUpdatedEvent>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$BluetoothScanStartedEventCopyWith<$Res> {
  factory _$BluetoothScanStartedEventCopyWith(_BluetoothScanStartedEvent value,
          $Res Function(_BluetoothScanStartedEvent) then) =
      __$BluetoothScanStartedEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$BluetoothScanStartedEventCopyWithImpl<$Res>
    extends _$BluetoothEventCopyWithImpl<$Res>
    implements _$BluetoothScanStartedEventCopyWith<$Res> {
  __$BluetoothScanStartedEventCopyWithImpl(_BluetoothScanStartedEvent _value,
      $Res Function(_BluetoothScanStartedEvent) _then)
      : super(_value, (v) => _then(v as _BluetoothScanStartedEvent));

  @override
  _BluetoothScanStartedEvent get _value =>
      super._value as _BluetoothScanStartedEvent;
}

/// @nodoc

class _$_BluetoothScanStartedEvent implements _BluetoothScanStartedEvent {
  const _$_BluetoothScanStartedEvent();

  @override
  String toString() {
    return 'BluetoothEvent.scanStarted()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BluetoothScanStartedEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() gotPairedDevices,
    required TResult Function() deviceConnected,
    required TResult Function(List<ConnectionStateUpdate> args)
        deviceConnectionUpdate,
    required TResult Function() scanStarted,
    required TResult Function() scanStopped,
    required TResult Function(DiscoveredDevice device) connected,
    required TResult Function() clearedControlPointResponse,
    required TResult Function(String deviceId) disconnect,
    required TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)
        savePairedDevices,
    required TResult Function(String id) pairedDeviceDeleted,
    required TResult Function(PairedDevice pairedDevice) scaleSubscribed,
  }) {
    return scanStarted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? gotPairedDevices,
    TResult Function()? deviceConnected,
    TResult Function(List<ConnectionStateUpdate> args)? deviceConnectionUpdate,
    TResult Function()? scanStarted,
    TResult Function()? scanStopped,
    TResult Function(DiscoveredDevice device)? connected,
    TResult Function()? clearedControlPointResponse,
    TResult Function(String deviceId)? disconnect,
    TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)?
        savePairedDevices,
    TResult Function(String id)? pairedDeviceDeleted,
    TResult Function(PairedDevice pairedDevice)? scaleSubscribed,
  }) {
    return scanStarted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? gotPairedDevices,
    TResult Function()? deviceConnected,
    TResult Function(List<ConnectionStateUpdate> args)? deviceConnectionUpdate,
    TResult Function()? scanStarted,
    TResult Function()? scanStopped,
    TResult Function(DiscoveredDevice device)? connected,
    TResult Function()? clearedControlPointResponse,
    TResult Function(String deviceId)? disconnect,
    TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)?
        savePairedDevices,
    TResult Function(String id)? pairedDeviceDeleted,
    TResult Function(PairedDevice pairedDevice)? scaleSubscribed,
    required TResult orElse(),
  }) {
    if (scanStarted != null) {
      return scanStarted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BluetoothGotPairedDevicesEvent value)
        gotPairedDevices,
    required TResult Function(_BluetoothDeviceConnectedEvent value)
        deviceConnected,
    required TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)
        deviceConnectionUpdate,
    required TResult Function(_BluetoothScanStartedEvent value) scanStarted,
    required TResult Function(_BluetoothScanStoppedEvent value) scanStopped,
    required TResult Function(_BluetoothConnectedEvent value) connected,
    required TResult Function(_BluetoothClearedControlPointResponseEvent value)
        clearedControlPointResponse,
    required TResult Function(_BluetoothDisconnectEvent value) disconnect,
    required TResult Function(_BluetoothSavePairedDevicesEvent value)
        savePairedDevices,
    required TResult Function(_BluetoothPairedDeviceDeletedEvent value)
        pairedDeviceDeleted,
    required TResult Function(_BluetoothScaleSubscribedEvent value)
        scaleSubscribed,
  }) {
    return scanStarted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_BluetoothGotPairedDevicesEvent value)? gotPairedDevices,
    TResult Function(_BluetoothDeviceConnectedEvent value)? deviceConnected,
    TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)?
        deviceConnectionUpdate,
    TResult Function(_BluetoothScanStartedEvent value)? scanStarted,
    TResult Function(_BluetoothScanStoppedEvent value)? scanStopped,
    TResult Function(_BluetoothConnectedEvent value)? connected,
    TResult Function(_BluetoothClearedControlPointResponseEvent value)?
        clearedControlPointResponse,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothSavePairedDevicesEvent value)? savePairedDevices,
    TResult Function(_BluetoothPairedDeviceDeletedEvent value)?
        pairedDeviceDeleted,
    TResult Function(_BluetoothScaleSubscribedEvent value)? scaleSubscribed,
  }) {
    return scanStarted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BluetoothGotPairedDevicesEvent value)? gotPairedDevices,
    TResult Function(_BluetoothDeviceConnectedEvent value)? deviceConnected,
    TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)?
        deviceConnectionUpdate,
    TResult Function(_BluetoothScanStartedEvent value)? scanStarted,
    TResult Function(_BluetoothScanStoppedEvent value)? scanStopped,
    TResult Function(_BluetoothConnectedEvent value)? connected,
    TResult Function(_BluetoothClearedControlPointResponseEvent value)?
        clearedControlPointResponse,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothSavePairedDevicesEvent value)? savePairedDevices,
    TResult Function(_BluetoothPairedDeviceDeletedEvent value)?
        pairedDeviceDeleted,
    TResult Function(_BluetoothScaleSubscribedEvent value)? scaleSubscribed,
    required TResult orElse(),
  }) {
    if (scanStarted != null) {
      return scanStarted(this);
    }
    return orElse();
  }
}

abstract class _BluetoothScanStartedEvent implements BluetoothEvent {
  const factory _BluetoothScanStartedEvent() = _$_BluetoothScanStartedEvent;
}

/// @nodoc
abstract class _$BluetoothScanStoppedEventCopyWith<$Res> {
  factory _$BluetoothScanStoppedEventCopyWith(_BluetoothScanStoppedEvent value,
          $Res Function(_BluetoothScanStoppedEvent) then) =
      __$BluetoothScanStoppedEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$BluetoothScanStoppedEventCopyWithImpl<$Res>
    extends _$BluetoothEventCopyWithImpl<$Res>
    implements _$BluetoothScanStoppedEventCopyWith<$Res> {
  __$BluetoothScanStoppedEventCopyWithImpl(_BluetoothScanStoppedEvent _value,
      $Res Function(_BluetoothScanStoppedEvent) _then)
      : super(_value, (v) => _then(v as _BluetoothScanStoppedEvent));

  @override
  _BluetoothScanStoppedEvent get _value =>
      super._value as _BluetoothScanStoppedEvent;
}

/// @nodoc

class _$_BluetoothScanStoppedEvent implements _BluetoothScanStoppedEvent {
  const _$_BluetoothScanStoppedEvent();

  @override
  String toString() {
    return 'BluetoothEvent.scanStopped()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BluetoothScanStoppedEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() gotPairedDevices,
    required TResult Function() deviceConnected,
    required TResult Function(List<ConnectionStateUpdate> args)
        deviceConnectionUpdate,
    required TResult Function() scanStarted,
    required TResult Function() scanStopped,
    required TResult Function(DiscoveredDevice device) connected,
    required TResult Function() clearedControlPointResponse,
    required TResult Function(String deviceId) disconnect,
    required TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)
        savePairedDevices,
    required TResult Function(String id) pairedDeviceDeleted,
    required TResult Function(PairedDevice pairedDevice) scaleSubscribed,
  }) {
    return scanStopped();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? gotPairedDevices,
    TResult Function()? deviceConnected,
    TResult Function(List<ConnectionStateUpdate> args)? deviceConnectionUpdate,
    TResult Function()? scanStarted,
    TResult Function()? scanStopped,
    TResult Function(DiscoveredDevice device)? connected,
    TResult Function()? clearedControlPointResponse,
    TResult Function(String deviceId)? disconnect,
    TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)?
        savePairedDevices,
    TResult Function(String id)? pairedDeviceDeleted,
    TResult Function(PairedDevice pairedDevice)? scaleSubscribed,
  }) {
    return scanStopped?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? gotPairedDevices,
    TResult Function()? deviceConnected,
    TResult Function(List<ConnectionStateUpdate> args)? deviceConnectionUpdate,
    TResult Function()? scanStarted,
    TResult Function()? scanStopped,
    TResult Function(DiscoveredDevice device)? connected,
    TResult Function()? clearedControlPointResponse,
    TResult Function(String deviceId)? disconnect,
    TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)?
        savePairedDevices,
    TResult Function(String id)? pairedDeviceDeleted,
    TResult Function(PairedDevice pairedDevice)? scaleSubscribed,
    required TResult orElse(),
  }) {
    if (scanStopped != null) {
      return scanStopped();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BluetoothGotPairedDevicesEvent value)
        gotPairedDevices,
    required TResult Function(_BluetoothDeviceConnectedEvent value)
        deviceConnected,
    required TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)
        deviceConnectionUpdate,
    required TResult Function(_BluetoothScanStartedEvent value) scanStarted,
    required TResult Function(_BluetoothScanStoppedEvent value) scanStopped,
    required TResult Function(_BluetoothConnectedEvent value) connected,
    required TResult Function(_BluetoothClearedControlPointResponseEvent value)
        clearedControlPointResponse,
    required TResult Function(_BluetoothDisconnectEvent value) disconnect,
    required TResult Function(_BluetoothSavePairedDevicesEvent value)
        savePairedDevices,
    required TResult Function(_BluetoothPairedDeviceDeletedEvent value)
        pairedDeviceDeleted,
    required TResult Function(_BluetoothScaleSubscribedEvent value)
        scaleSubscribed,
  }) {
    return scanStopped(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_BluetoothGotPairedDevicesEvent value)? gotPairedDevices,
    TResult Function(_BluetoothDeviceConnectedEvent value)? deviceConnected,
    TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)?
        deviceConnectionUpdate,
    TResult Function(_BluetoothScanStartedEvent value)? scanStarted,
    TResult Function(_BluetoothScanStoppedEvent value)? scanStopped,
    TResult Function(_BluetoothConnectedEvent value)? connected,
    TResult Function(_BluetoothClearedControlPointResponseEvent value)?
        clearedControlPointResponse,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothSavePairedDevicesEvent value)? savePairedDevices,
    TResult Function(_BluetoothPairedDeviceDeletedEvent value)?
        pairedDeviceDeleted,
    TResult Function(_BluetoothScaleSubscribedEvent value)? scaleSubscribed,
  }) {
    return scanStopped?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BluetoothGotPairedDevicesEvent value)? gotPairedDevices,
    TResult Function(_BluetoothDeviceConnectedEvent value)? deviceConnected,
    TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)?
        deviceConnectionUpdate,
    TResult Function(_BluetoothScanStartedEvent value)? scanStarted,
    TResult Function(_BluetoothScanStoppedEvent value)? scanStopped,
    TResult Function(_BluetoothConnectedEvent value)? connected,
    TResult Function(_BluetoothClearedControlPointResponseEvent value)?
        clearedControlPointResponse,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothSavePairedDevicesEvent value)? savePairedDevices,
    TResult Function(_BluetoothPairedDeviceDeletedEvent value)?
        pairedDeviceDeleted,
    TResult Function(_BluetoothScaleSubscribedEvent value)? scaleSubscribed,
    required TResult orElse(),
  }) {
    if (scanStopped != null) {
      return scanStopped(this);
    }
    return orElse();
  }
}

abstract class _BluetoothScanStoppedEvent implements BluetoothEvent {
  const factory _BluetoothScanStoppedEvent() = _$_BluetoothScanStoppedEvent;
}

/// @nodoc
abstract class _$BluetoothConnectedEventCopyWith<$Res> {
  factory _$BluetoothConnectedEventCopyWith(_BluetoothConnectedEvent value,
          $Res Function(_BluetoothConnectedEvent) then) =
      __$BluetoothConnectedEventCopyWithImpl<$Res>;
  $Res call({DiscoveredDevice device});
}

/// @nodoc
class __$BluetoothConnectedEventCopyWithImpl<$Res>
    extends _$BluetoothEventCopyWithImpl<$Res>
    implements _$BluetoothConnectedEventCopyWith<$Res> {
  __$BluetoothConnectedEventCopyWithImpl(_BluetoothConnectedEvent _value,
      $Res Function(_BluetoothConnectedEvent) _then)
      : super(_value, (v) => _then(v as _BluetoothConnectedEvent));

  @override
  _BluetoothConnectedEvent get _value =>
      super._value as _BluetoothConnectedEvent;

  @override
  $Res call({
    Object? device = freezed,
  }) {
    return _then(_BluetoothConnectedEvent(
      device == freezed
          ? _value.device
          : device // ignore: cast_nullable_to_non_nullable
              as DiscoveredDevice,
    ));
  }
}

/// @nodoc

class _$_BluetoothConnectedEvent implements _BluetoothConnectedEvent {
  const _$_BluetoothConnectedEvent(this.device);

  @override
  final DiscoveredDevice device;

  @override
  String toString() {
    return 'BluetoothEvent.connected(device: $device)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BluetoothConnectedEvent &&
            const DeepCollectionEquality().equals(other.device, device));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(device));

  @JsonKey(ignore: true)
  @override
  _$BluetoothConnectedEventCopyWith<_BluetoothConnectedEvent> get copyWith =>
      __$BluetoothConnectedEventCopyWithImpl<_BluetoothConnectedEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() gotPairedDevices,
    required TResult Function() deviceConnected,
    required TResult Function(List<ConnectionStateUpdate> args)
        deviceConnectionUpdate,
    required TResult Function() scanStarted,
    required TResult Function() scanStopped,
    required TResult Function(DiscoveredDevice device) connected,
    required TResult Function() clearedControlPointResponse,
    required TResult Function(String deviceId) disconnect,
    required TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)
        savePairedDevices,
    required TResult Function(String id) pairedDeviceDeleted,
    required TResult Function(PairedDevice pairedDevice) scaleSubscribed,
  }) {
    return connected(device);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? gotPairedDevices,
    TResult Function()? deviceConnected,
    TResult Function(List<ConnectionStateUpdate> args)? deviceConnectionUpdate,
    TResult Function()? scanStarted,
    TResult Function()? scanStopped,
    TResult Function(DiscoveredDevice device)? connected,
    TResult Function()? clearedControlPointResponse,
    TResult Function(String deviceId)? disconnect,
    TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)?
        savePairedDevices,
    TResult Function(String id)? pairedDeviceDeleted,
    TResult Function(PairedDevice pairedDevice)? scaleSubscribed,
  }) {
    return connected?.call(device);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? gotPairedDevices,
    TResult Function()? deviceConnected,
    TResult Function(List<ConnectionStateUpdate> args)? deviceConnectionUpdate,
    TResult Function()? scanStarted,
    TResult Function()? scanStopped,
    TResult Function(DiscoveredDevice device)? connected,
    TResult Function()? clearedControlPointResponse,
    TResult Function(String deviceId)? disconnect,
    TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)?
        savePairedDevices,
    TResult Function(String id)? pairedDeviceDeleted,
    TResult Function(PairedDevice pairedDevice)? scaleSubscribed,
    required TResult orElse(),
  }) {
    if (connected != null) {
      return connected(device);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BluetoothGotPairedDevicesEvent value)
        gotPairedDevices,
    required TResult Function(_BluetoothDeviceConnectedEvent value)
        deviceConnected,
    required TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)
        deviceConnectionUpdate,
    required TResult Function(_BluetoothScanStartedEvent value) scanStarted,
    required TResult Function(_BluetoothScanStoppedEvent value) scanStopped,
    required TResult Function(_BluetoothConnectedEvent value) connected,
    required TResult Function(_BluetoothClearedControlPointResponseEvent value)
        clearedControlPointResponse,
    required TResult Function(_BluetoothDisconnectEvent value) disconnect,
    required TResult Function(_BluetoothSavePairedDevicesEvent value)
        savePairedDevices,
    required TResult Function(_BluetoothPairedDeviceDeletedEvent value)
        pairedDeviceDeleted,
    required TResult Function(_BluetoothScaleSubscribedEvent value)
        scaleSubscribed,
  }) {
    return connected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_BluetoothGotPairedDevicesEvent value)? gotPairedDevices,
    TResult Function(_BluetoothDeviceConnectedEvent value)? deviceConnected,
    TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)?
        deviceConnectionUpdate,
    TResult Function(_BluetoothScanStartedEvent value)? scanStarted,
    TResult Function(_BluetoothScanStoppedEvent value)? scanStopped,
    TResult Function(_BluetoothConnectedEvent value)? connected,
    TResult Function(_BluetoothClearedControlPointResponseEvent value)?
        clearedControlPointResponse,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothSavePairedDevicesEvent value)? savePairedDevices,
    TResult Function(_BluetoothPairedDeviceDeletedEvent value)?
        pairedDeviceDeleted,
    TResult Function(_BluetoothScaleSubscribedEvent value)? scaleSubscribed,
  }) {
    return connected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BluetoothGotPairedDevicesEvent value)? gotPairedDevices,
    TResult Function(_BluetoothDeviceConnectedEvent value)? deviceConnected,
    TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)?
        deviceConnectionUpdate,
    TResult Function(_BluetoothScanStartedEvent value)? scanStarted,
    TResult Function(_BluetoothScanStoppedEvent value)? scanStopped,
    TResult Function(_BluetoothConnectedEvent value)? connected,
    TResult Function(_BluetoothClearedControlPointResponseEvent value)?
        clearedControlPointResponse,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothSavePairedDevicesEvent value)? savePairedDevices,
    TResult Function(_BluetoothPairedDeviceDeletedEvent value)?
        pairedDeviceDeleted,
    TResult Function(_BluetoothScaleSubscribedEvent value)? scaleSubscribed,
    required TResult orElse(),
  }) {
    if (connected != null) {
      return connected(this);
    }
    return orElse();
  }
}

abstract class _BluetoothConnectedEvent implements BluetoothEvent {
  const factory _BluetoothConnectedEvent(DiscoveredDevice device) =
      _$_BluetoothConnectedEvent;

  DiscoveredDevice get device;
  @JsonKey(ignore: true)
  _$BluetoothConnectedEventCopyWith<_BluetoothConnectedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$BluetoothClearedControlPointResponseEventCopyWith<$Res> {
  factory _$BluetoothClearedControlPointResponseEventCopyWith(
          _BluetoothClearedControlPointResponseEvent value,
          $Res Function(_BluetoothClearedControlPointResponseEvent) then) =
      __$BluetoothClearedControlPointResponseEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$BluetoothClearedControlPointResponseEventCopyWithImpl<$Res>
    extends _$BluetoothEventCopyWithImpl<$Res>
    implements _$BluetoothClearedControlPointResponseEventCopyWith<$Res> {
  __$BluetoothClearedControlPointResponseEventCopyWithImpl(
      _BluetoothClearedControlPointResponseEvent _value,
      $Res Function(_BluetoothClearedControlPointResponseEvent) _then)
      : super(_value,
            (v) => _then(v as _BluetoothClearedControlPointResponseEvent));

  @override
  _BluetoothClearedControlPointResponseEvent get _value =>
      super._value as _BluetoothClearedControlPointResponseEvent;
}

/// @nodoc

class _$_BluetoothClearedControlPointResponseEvent
    implements _BluetoothClearedControlPointResponseEvent {
  const _$_BluetoothClearedControlPointResponseEvent();

  @override
  String toString() {
    return 'BluetoothEvent.clearedControlPointResponse()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BluetoothClearedControlPointResponseEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() gotPairedDevices,
    required TResult Function() deviceConnected,
    required TResult Function(List<ConnectionStateUpdate> args)
        deviceConnectionUpdate,
    required TResult Function() scanStarted,
    required TResult Function() scanStopped,
    required TResult Function(DiscoveredDevice device) connected,
    required TResult Function() clearedControlPointResponse,
    required TResult Function(String deviceId) disconnect,
    required TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)
        savePairedDevices,
    required TResult Function(String id) pairedDeviceDeleted,
    required TResult Function(PairedDevice pairedDevice) scaleSubscribed,
  }) {
    return clearedControlPointResponse();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? gotPairedDevices,
    TResult Function()? deviceConnected,
    TResult Function(List<ConnectionStateUpdate> args)? deviceConnectionUpdate,
    TResult Function()? scanStarted,
    TResult Function()? scanStopped,
    TResult Function(DiscoveredDevice device)? connected,
    TResult Function()? clearedControlPointResponse,
    TResult Function(String deviceId)? disconnect,
    TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)?
        savePairedDevices,
    TResult Function(String id)? pairedDeviceDeleted,
    TResult Function(PairedDevice pairedDevice)? scaleSubscribed,
  }) {
    return clearedControlPointResponse?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? gotPairedDevices,
    TResult Function()? deviceConnected,
    TResult Function(List<ConnectionStateUpdate> args)? deviceConnectionUpdate,
    TResult Function()? scanStarted,
    TResult Function()? scanStopped,
    TResult Function(DiscoveredDevice device)? connected,
    TResult Function()? clearedControlPointResponse,
    TResult Function(String deviceId)? disconnect,
    TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)?
        savePairedDevices,
    TResult Function(String id)? pairedDeviceDeleted,
    TResult Function(PairedDevice pairedDevice)? scaleSubscribed,
    required TResult orElse(),
  }) {
    if (clearedControlPointResponse != null) {
      return clearedControlPointResponse();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BluetoothGotPairedDevicesEvent value)
        gotPairedDevices,
    required TResult Function(_BluetoothDeviceConnectedEvent value)
        deviceConnected,
    required TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)
        deviceConnectionUpdate,
    required TResult Function(_BluetoothScanStartedEvent value) scanStarted,
    required TResult Function(_BluetoothScanStoppedEvent value) scanStopped,
    required TResult Function(_BluetoothConnectedEvent value) connected,
    required TResult Function(_BluetoothClearedControlPointResponseEvent value)
        clearedControlPointResponse,
    required TResult Function(_BluetoothDisconnectEvent value) disconnect,
    required TResult Function(_BluetoothSavePairedDevicesEvent value)
        savePairedDevices,
    required TResult Function(_BluetoothPairedDeviceDeletedEvent value)
        pairedDeviceDeleted,
    required TResult Function(_BluetoothScaleSubscribedEvent value)
        scaleSubscribed,
  }) {
    return clearedControlPointResponse(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_BluetoothGotPairedDevicesEvent value)? gotPairedDevices,
    TResult Function(_BluetoothDeviceConnectedEvent value)? deviceConnected,
    TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)?
        deviceConnectionUpdate,
    TResult Function(_BluetoothScanStartedEvent value)? scanStarted,
    TResult Function(_BluetoothScanStoppedEvent value)? scanStopped,
    TResult Function(_BluetoothConnectedEvent value)? connected,
    TResult Function(_BluetoothClearedControlPointResponseEvent value)?
        clearedControlPointResponse,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothSavePairedDevicesEvent value)? savePairedDevices,
    TResult Function(_BluetoothPairedDeviceDeletedEvent value)?
        pairedDeviceDeleted,
    TResult Function(_BluetoothScaleSubscribedEvent value)? scaleSubscribed,
  }) {
    return clearedControlPointResponse?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BluetoothGotPairedDevicesEvent value)? gotPairedDevices,
    TResult Function(_BluetoothDeviceConnectedEvent value)? deviceConnected,
    TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)?
        deviceConnectionUpdate,
    TResult Function(_BluetoothScanStartedEvent value)? scanStarted,
    TResult Function(_BluetoothScanStoppedEvent value)? scanStopped,
    TResult Function(_BluetoothConnectedEvent value)? connected,
    TResult Function(_BluetoothClearedControlPointResponseEvent value)?
        clearedControlPointResponse,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothSavePairedDevicesEvent value)? savePairedDevices,
    TResult Function(_BluetoothPairedDeviceDeletedEvent value)?
        pairedDeviceDeleted,
    TResult Function(_BluetoothScaleSubscribedEvent value)? scaleSubscribed,
    required TResult orElse(),
  }) {
    if (clearedControlPointResponse != null) {
      return clearedControlPointResponse(this);
    }
    return orElse();
  }
}

abstract class _BluetoothClearedControlPointResponseEvent
    implements BluetoothEvent {
  const factory _BluetoothClearedControlPointResponseEvent() =
      _$_BluetoothClearedControlPointResponseEvent;
}

/// @nodoc
abstract class _$BluetoothDisconnectEventCopyWith<$Res> {
  factory _$BluetoothDisconnectEventCopyWith(_BluetoothDisconnectEvent value,
          $Res Function(_BluetoothDisconnectEvent) then) =
      __$BluetoothDisconnectEventCopyWithImpl<$Res>;
  $Res call({String deviceId});
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

  @override
  $Res call({
    Object? deviceId = freezed,
  }) {
    return _then(_BluetoothDisconnectEvent(
      deviceId == freezed
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_BluetoothDisconnectEvent implements _BluetoothDisconnectEvent {
  const _$_BluetoothDisconnectEvent(this.deviceId);

  @override
  final String deviceId;

  @override
  String toString() {
    return 'BluetoothEvent.disconnect(deviceId: $deviceId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BluetoothDisconnectEvent &&
            const DeepCollectionEquality().equals(other.deviceId, deviceId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(deviceId));

  @JsonKey(ignore: true)
  @override
  _$BluetoothDisconnectEventCopyWith<_BluetoothDisconnectEvent> get copyWith =>
      __$BluetoothDisconnectEventCopyWithImpl<_BluetoothDisconnectEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() gotPairedDevices,
    required TResult Function() deviceConnected,
    required TResult Function(List<ConnectionStateUpdate> args)
        deviceConnectionUpdate,
    required TResult Function() scanStarted,
    required TResult Function() scanStopped,
    required TResult Function(DiscoveredDevice device) connected,
    required TResult Function() clearedControlPointResponse,
    required TResult Function(String deviceId) disconnect,
    required TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)
        savePairedDevices,
    required TResult Function(String id) pairedDeviceDeleted,
    required TResult Function(PairedDevice pairedDevice) scaleSubscribed,
  }) {
    return disconnect(deviceId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? gotPairedDevices,
    TResult Function()? deviceConnected,
    TResult Function(List<ConnectionStateUpdate> args)? deviceConnectionUpdate,
    TResult Function()? scanStarted,
    TResult Function()? scanStopped,
    TResult Function(DiscoveredDevice device)? connected,
    TResult Function()? clearedControlPointResponse,
    TResult Function(String deviceId)? disconnect,
    TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)?
        savePairedDevices,
    TResult Function(String id)? pairedDeviceDeleted,
    TResult Function(PairedDevice pairedDevice)? scaleSubscribed,
  }) {
    return disconnect?.call(deviceId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? gotPairedDevices,
    TResult Function()? deviceConnected,
    TResult Function(List<ConnectionStateUpdate> args)? deviceConnectionUpdate,
    TResult Function()? scanStarted,
    TResult Function()? scanStopped,
    TResult Function(DiscoveredDevice device)? connected,
    TResult Function()? clearedControlPointResponse,
    TResult Function(String deviceId)? disconnect,
    TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)?
        savePairedDevices,
    TResult Function(String id)? pairedDeviceDeleted,
    TResult Function(PairedDevice pairedDevice)? scaleSubscribed,
    required TResult orElse(),
  }) {
    if (disconnect != null) {
      return disconnect(deviceId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BluetoothGotPairedDevicesEvent value)
        gotPairedDevices,
    required TResult Function(_BluetoothDeviceConnectedEvent value)
        deviceConnected,
    required TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)
        deviceConnectionUpdate,
    required TResult Function(_BluetoothScanStartedEvent value) scanStarted,
    required TResult Function(_BluetoothScanStoppedEvent value) scanStopped,
    required TResult Function(_BluetoothConnectedEvent value) connected,
    required TResult Function(_BluetoothClearedControlPointResponseEvent value)
        clearedControlPointResponse,
    required TResult Function(_BluetoothDisconnectEvent value) disconnect,
    required TResult Function(_BluetoothSavePairedDevicesEvent value)
        savePairedDevices,
    required TResult Function(_BluetoothPairedDeviceDeletedEvent value)
        pairedDeviceDeleted,
    required TResult Function(_BluetoothScaleSubscribedEvent value)
        scaleSubscribed,
  }) {
    return disconnect(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_BluetoothGotPairedDevicesEvent value)? gotPairedDevices,
    TResult Function(_BluetoothDeviceConnectedEvent value)? deviceConnected,
    TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)?
        deviceConnectionUpdate,
    TResult Function(_BluetoothScanStartedEvent value)? scanStarted,
    TResult Function(_BluetoothScanStoppedEvent value)? scanStopped,
    TResult Function(_BluetoothConnectedEvent value)? connected,
    TResult Function(_BluetoothClearedControlPointResponseEvent value)?
        clearedControlPointResponse,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothSavePairedDevicesEvent value)? savePairedDevices,
    TResult Function(_BluetoothPairedDeviceDeletedEvent value)?
        pairedDeviceDeleted,
    TResult Function(_BluetoothScaleSubscribedEvent value)? scaleSubscribed,
  }) {
    return disconnect?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BluetoothGotPairedDevicesEvent value)? gotPairedDevices,
    TResult Function(_BluetoothDeviceConnectedEvent value)? deviceConnected,
    TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)?
        deviceConnectionUpdate,
    TResult Function(_BluetoothScanStartedEvent value)? scanStarted,
    TResult Function(_BluetoothScanStoppedEvent value)? scanStopped,
    TResult Function(_BluetoothConnectedEvent value)? connected,
    TResult Function(_BluetoothClearedControlPointResponseEvent value)?
        clearedControlPointResponse,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothSavePairedDevicesEvent value)? savePairedDevices,
    TResult Function(_BluetoothPairedDeviceDeletedEvent value)?
        pairedDeviceDeleted,
    TResult Function(_BluetoothScaleSubscribedEvent value)? scaleSubscribed,
    required TResult orElse(),
  }) {
    if (disconnect != null) {
      return disconnect(this);
    }
    return orElse();
  }
}

abstract class _BluetoothDisconnectEvent implements BluetoothEvent {
  const factory _BluetoothDisconnectEvent(String deviceId) =
      _$_BluetoothDisconnectEvent;

  String get deviceId;
  @JsonKey(ignore: true)
  _$BluetoothDisconnectEventCopyWith<_BluetoothDisconnectEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$BluetoothSavePairedDevicesEventCopyWith<$Res> {
  factory _$BluetoothSavePairedDevicesEventCopyWith(
          _BluetoothSavePairedDevicesEvent value,
          $Res Function(_BluetoothSavePairedDevicesEvent) then) =
      __$BluetoothSavePairedDevicesEventCopyWithImpl<$Res>;
  $Res call(
      {PairedDevice pairedDevice,
      bool? checkSuccess,
      List<int>? recordAccessData});
}

/// @nodoc
class __$BluetoothSavePairedDevicesEventCopyWithImpl<$Res>
    extends _$BluetoothEventCopyWithImpl<$Res>
    implements _$BluetoothSavePairedDevicesEventCopyWith<$Res> {
  __$BluetoothSavePairedDevicesEventCopyWithImpl(
      _BluetoothSavePairedDevicesEvent _value,
      $Res Function(_BluetoothSavePairedDevicesEvent) _then)
      : super(_value, (v) => _then(v as _BluetoothSavePairedDevicesEvent));

  @override
  _BluetoothSavePairedDevicesEvent get _value =>
      super._value as _BluetoothSavePairedDevicesEvent;

  @override
  $Res call({
    Object? pairedDevice = freezed,
    Object? checkSuccess = freezed,
    Object? recordAccessData = freezed,
  }) {
    return _then(_BluetoothSavePairedDevicesEvent(
      pairedDevice == freezed
          ? _value.pairedDevice
          : pairedDevice // ignore: cast_nullable_to_non_nullable
              as PairedDevice,
      checkSuccess == freezed
          ? _value.checkSuccess
          : checkSuccess // ignore: cast_nullable_to_non_nullable
              as bool?,
      recordAccessData == freezed
          ? _value.recordAccessData
          : recordAccessData // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc

class _$_BluetoothSavePairedDevicesEvent
    implements _BluetoothSavePairedDevicesEvent {
  const _$_BluetoothSavePairedDevicesEvent(this.pairedDevice,
      [this.checkSuccess, this.recordAccessData]);

  @override
  final PairedDevice pairedDevice;
  @override
  final bool? checkSuccess;
  @override
  final List<int>? recordAccessData;

  @override
  String toString() {
    return 'BluetoothEvent.savePairedDevices(pairedDevice: $pairedDevice, checkSuccess: $checkSuccess, recordAccessData: $recordAccessData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BluetoothSavePairedDevicesEvent &&
            const DeepCollectionEquality()
                .equals(other.pairedDevice, pairedDevice) &&
            const DeepCollectionEquality()
                .equals(other.checkSuccess, checkSuccess) &&
            const DeepCollectionEquality()
                .equals(other.recordAccessData, recordAccessData));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(pairedDevice),
      const DeepCollectionEquality().hash(checkSuccess),
      const DeepCollectionEquality().hash(recordAccessData));

  @JsonKey(ignore: true)
  @override
  _$BluetoothSavePairedDevicesEventCopyWith<_BluetoothSavePairedDevicesEvent>
      get copyWith => __$BluetoothSavePairedDevicesEventCopyWithImpl<
          _BluetoothSavePairedDevicesEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() gotPairedDevices,
    required TResult Function() deviceConnected,
    required TResult Function(List<ConnectionStateUpdate> args)
        deviceConnectionUpdate,
    required TResult Function() scanStarted,
    required TResult Function() scanStopped,
    required TResult Function(DiscoveredDevice device) connected,
    required TResult Function() clearedControlPointResponse,
    required TResult Function(String deviceId) disconnect,
    required TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)
        savePairedDevices,
    required TResult Function(String id) pairedDeviceDeleted,
    required TResult Function(PairedDevice pairedDevice) scaleSubscribed,
  }) {
    return savePairedDevices(pairedDevice, checkSuccess, recordAccessData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? gotPairedDevices,
    TResult Function()? deviceConnected,
    TResult Function(List<ConnectionStateUpdate> args)? deviceConnectionUpdate,
    TResult Function()? scanStarted,
    TResult Function()? scanStopped,
    TResult Function(DiscoveredDevice device)? connected,
    TResult Function()? clearedControlPointResponse,
    TResult Function(String deviceId)? disconnect,
    TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)?
        savePairedDevices,
    TResult Function(String id)? pairedDeviceDeleted,
    TResult Function(PairedDevice pairedDevice)? scaleSubscribed,
  }) {
    return savePairedDevices?.call(
        pairedDevice, checkSuccess, recordAccessData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? gotPairedDevices,
    TResult Function()? deviceConnected,
    TResult Function(List<ConnectionStateUpdate> args)? deviceConnectionUpdate,
    TResult Function()? scanStarted,
    TResult Function()? scanStopped,
    TResult Function(DiscoveredDevice device)? connected,
    TResult Function()? clearedControlPointResponse,
    TResult Function(String deviceId)? disconnect,
    TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)?
        savePairedDevices,
    TResult Function(String id)? pairedDeviceDeleted,
    TResult Function(PairedDevice pairedDevice)? scaleSubscribed,
    required TResult orElse(),
  }) {
    if (savePairedDevices != null) {
      return savePairedDevices(pairedDevice, checkSuccess, recordAccessData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BluetoothGotPairedDevicesEvent value)
        gotPairedDevices,
    required TResult Function(_BluetoothDeviceConnectedEvent value)
        deviceConnected,
    required TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)
        deviceConnectionUpdate,
    required TResult Function(_BluetoothScanStartedEvent value) scanStarted,
    required TResult Function(_BluetoothScanStoppedEvent value) scanStopped,
    required TResult Function(_BluetoothConnectedEvent value) connected,
    required TResult Function(_BluetoothClearedControlPointResponseEvent value)
        clearedControlPointResponse,
    required TResult Function(_BluetoothDisconnectEvent value) disconnect,
    required TResult Function(_BluetoothSavePairedDevicesEvent value)
        savePairedDevices,
    required TResult Function(_BluetoothPairedDeviceDeletedEvent value)
        pairedDeviceDeleted,
    required TResult Function(_BluetoothScaleSubscribedEvent value)
        scaleSubscribed,
  }) {
    return savePairedDevices(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_BluetoothGotPairedDevicesEvent value)? gotPairedDevices,
    TResult Function(_BluetoothDeviceConnectedEvent value)? deviceConnected,
    TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)?
        deviceConnectionUpdate,
    TResult Function(_BluetoothScanStartedEvent value)? scanStarted,
    TResult Function(_BluetoothScanStoppedEvent value)? scanStopped,
    TResult Function(_BluetoothConnectedEvent value)? connected,
    TResult Function(_BluetoothClearedControlPointResponseEvent value)?
        clearedControlPointResponse,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothSavePairedDevicesEvent value)? savePairedDevices,
    TResult Function(_BluetoothPairedDeviceDeletedEvent value)?
        pairedDeviceDeleted,
    TResult Function(_BluetoothScaleSubscribedEvent value)? scaleSubscribed,
  }) {
    return savePairedDevices?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BluetoothGotPairedDevicesEvent value)? gotPairedDevices,
    TResult Function(_BluetoothDeviceConnectedEvent value)? deviceConnected,
    TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)?
        deviceConnectionUpdate,
    TResult Function(_BluetoothScanStartedEvent value)? scanStarted,
    TResult Function(_BluetoothScanStoppedEvent value)? scanStopped,
    TResult Function(_BluetoothConnectedEvent value)? connected,
    TResult Function(_BluetoothClearedControlPointResponseEvent value)?
        clearedControlPointResponse,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothSavePairedDevicesEvent value)? savePairedDevices,
    TResult Function(_BluetoothPairedDeviceDeletedEvent value)?
        pairedDeviceDeleted,
    TResult Function(_BluetoothScaleSubscribedEvent value)? scaleSubscribed,
    required TResult orElse(),
  }) {
    if (savePairedDevices != null) {
      return savePairedDevices(this);
    }
    return orElse();
  }
}

abstract class _BluetoothSavePairedDevicesEvent implements BluetoothEvent {
  const factory _BluetoothSavePairedDevicesEvent(PairedDevice pairedDevice,
      [bool? checkSuccess,
      List<int>? recordAccessData]) = _$_BluetoothSavePairedDevicesEvent;

  PairedDevice get pairedDevice;
  bool? get checkSuccess;
  List<int>? get recordAccessData;
  @JsonKey(ignore: true)
  _$BluetoothSavePairedDevicesEventCopyWith<_BluetoothSavePairedDevicesEvent>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$BluetoothPairedDeviceDeletedEventCopyWith<$Res> {
  factory _$BluetoothPairedDeviceDeletedEventCopyWith(
          _BluetoothPairedDeviceDeletedEvent value,
          $Res Function(_BluetoothPairedDeviceDeletedEvent) then) =
      __$BluetoothPairedDeviceDeletedEventCopyWithImpl<$Res>;
  $Res call({String id});
}

/// @nodoc
class __$BluetoothPairedDeviceDeletedEventCopyWithImpl<$Res>
    extends _$BluetoothEventCopyWithImpl<$Res>
    implements _$BluetoothPairedDeviceDeletedEventCopyWith<$Res> {
  __$BluetoothPairedDeviceDeletedEventCopyWithImpl(
      _BluetoothPairedDeviceDeletedEvent _value,
      $Res Function(_BluetoothPairedDeviceDeletedEvent) _then)
      : super(_value, (v) => _then(v as _BluetoothPairedDeviceDeletedEvent));

  @override
  _BluetoothPairedDeviceDeletedEvent get _value =>
      super._value as _BluetoothPairedDeviceDeletedEvent;

  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_BluetoothPairedDeviceDeletedEvent(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_BluetoothPairedDeviceDeletedEvent
    implements _BluetoothPairedDeviceDeletedEvent {
  const _$_BluetoothPairedDeviceDeletedEvent(this.id);

  @override
  final String id;

  @override
  String toString() {
    return 'BluetoothEvent.pairedDeviceDeleted(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BluetoothPairedDeviceDeletedEvent &&
            const DeepCollectionEquality().equals(other.id, id));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(id));

  @JsonKey(ignore: true)
  @override
  _$BluetoothPairedDeviceDeletedEventCopyWith<
          _BluetoothPairedDeviceDeletedEvent>
      get copyWith => __$BluetoothPairedDeviceDeletedEventCopyWithImpl<
          _BluetoothPairedDeviceDeletedEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() gotPairedDevices,
    required TResult Function() deviceConnected,
    required TResult Function(List<ConnectionStateUpdate> args)
        deviceConnectionUpdate,
    required TResult Function() scanStarted,
    required TResult Function() scanStopped,
    required TResult Function(DiscoveredDevice device) connected,
    required TResult Function() clearedControlPointResponse,
    required TResult Function(String deviceId) disconnect,
    required TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)
        savePairedDevices,
    required TResult Function(String id) pairedDeviceDeleted,
    required TResult Function(PairedDevice pairedDevice) scaleSubscribed,
  }) {
    return pairedDeviceDeleted(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? gotPairedDevices,
    TResult Function()? deviceConnected,
    TResult Function(List<ConnectionStateUpdate> args)? deviceConnectionUpdate,
    TResult Function()? scanStarted,
    TResult Function()? scanStopped,
    TResult Function(DiscoveredDevice device)? connected,
    TResult Function()? clearedControlPointResponse,
    TResult Function(String deviceId)? disconnect,
    TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)?
        savePairedDevices,
    TResult Function(String id)? pairedDeviceDeleted,
    TResult Function(PairedDevice pairedDevice)? scaleSubscribed,
  }) {
    return pairedDeviceDeleted?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? gotPairedDevices,
    TResult Function()? deviceConnected,
    TResult Function(List<ConnectionStateUpdate> args)? deviceConnectionUpdate,
    TResult Function()? scanStarted,
    TResult Function()? scanStopped,
    TResult Function(DiscoveredDevice device)? connected,
    TResult Function()? clearedControlPointResponse,
    TResult Function(String deviceId)? disconnect,
    TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)?
        savePairedDevices,
    TResult Function(String id)? pairedDeviceDeleted,
    TResult Function(PairedDevice pairedDevice)? scaleSubscribed,
    required TResult orElse(),
  }) {
    if (pairedDeviceDeleted != null) {
      return pairedDeviceDeleted(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BluetoothGotPairedDevicesEvent value)
        gotPairedDevices,
    required TResult Function(_BluetoothDeviceConnectedEvent value)
        deviceConnected,
    required TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)
        deviceConnectionUpdate,
    required TResult Function(_BluetoothScanStartedEvent value) scanStarted,
    required TResult Function(_BluetoothScanStoppedEvent value) scanStopped,
    required TResult Function(_BluetoothConnectedEvent value) connected,
    required TResult Function(_BluetoothClearedControlPointResponseEvent value)
        clearedControlPointResponse,
    required TResult Function(_BluetoothDisconnectEvent value) disconnect,
    required TResult Function(_BluetoothSavePairedDevicesEvent value)
        savePairedDevices,
    required TResult Function(_BluetoothPairedDeviceDeletedEvent value)
        pairedDeviceDeleted,
    required TResult Function(_BluetoothScaleSubscribedEvent value)
        scaleSubscribed,
  }) {
    return pairedDeviceDeleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_BluetoothGotPairedDevicesEvent value)? gotPairedDevices,
    TResult Function(_BluetoothDeviceConnectedEvent value)? deviceConnected,
    TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)?
        deviceConnectionUpdate,
    TResult Function(_BluetoothScanStartedEvent value)? scanStarted,
    TResult Function(_BluetoothScanStoppedEvent value)? scanStopped,
    TResult Function(_BluetoothConnectedEvent value)? connected,
    TResult Function(_BluetoothClearedControlPointResponseEvent value)?
        clearedControlPointResponse,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothSavePairedDevicesEvent value)? savePairedDevices,
    TResult Function(_BluetoothPairedDeviceDeletedEvent value)?
        pairedDeviceDeleted,
    TResult Function(_BluetoothScaleSubscribedEvent value)? scaleSubscribed,
  }) {
    return pairedDeviceDeleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BluetoothGotPairedDevicesEvent value)? gotPairedDevices,
    TResult Function(_BluetoothDeviceConnectedEvent value)? deviceConnected,
    TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)?
        deviceConnectionUpdate,
    TResult Function(_BluetoothScanStartedEvent value)? scanStarted,
    TResult Function(_BluetoothScanStoppedEvent value)? scanStopped,
    TResult Function(_BluetoothConnectedEvent value)? connected,
    TResult Function(_BluetoothClearedControlPointResponseEvent value)?
        clearedControlPointResponse,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothSavePairedDevicesEvent value)? savePairedDevices,
    TResult Function(_BluetoothPairedDeviceDeletedEvent value)?
        pairedDeviceDeleted,
    TResult Function(_BluetoothScaleSubscribedEvent value)? scaleSubscribed,
    required TResult orElse(),
  }) {
    if (pairedDeviceDeleted != null) {
      return pairedDeviceDeleted(this);
    }
    return orElse();
  }
}

abstract class _BluetoothPairedDeviceDeletedEvent implements BluetoothEvent {
  const factory _BluetoothPairedDeviceDeletedEvent(String id) =
      _$_BluetoothPairedDeviceDeletedEvent;

  String get id;
  @JsonKey(ignore: true)
  _$BluetoothPairedDeviceDeletedEventCopyWith<
          _BluetoothPairedDeviceDeletedEvent>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$BluetoothScaleSubscribedEventCopyWith<$Res> {
  factory _$BluetoothScaleSubscribedEventCopyWith(
          _BluetoothScaleSubscribedEvent value,
          $Res Function(_BluetoothScaleSubscribedEvent) then) =
      __$BluetoothScaleSubscribedEventCopyWithImpl<$Res>;
  $Res call({PairedDevice pairedDevice});
}

/// @nodoc
class __$BluetoothScaleSubscribedEventCopyWithImpl<$Res>
    extends _$BluetoothEventCopyWithImpl<$Res>
    implements _$BluetoothScaleSubscribedEventCopyWith<$Res> {
  __$BluetoothScaleSubscribedEventCopyWithImpl(
      _BluetoothScaleSubscribedEvent _value,
      $Res Function(_BluetoothScaleSubscribedEvent) _then)
      : super(_value, (v) => _then(v as _BluetoothScaleSubscribedEvent));

  @override
  _BluetoothScaleSubscribedEvent get _value =>
      super._value as _BluetoothScaleSubscribedEvent;

  @override
  $Res call({
    Object? pairedDevice = freezed,
  }) {
    return _then(_BluetoothScaleSubscribedEvent(
      pairedDevice == freezed
          ? _value.pairedDevice
          : pairedDevice // ignore: cast_nullable_to_non_nullable
              as PairedDevice,
    ));
  }
}

/// @nodoc

class _$_BluetoothScaleSubscribedEvent
    implements _BluetoothScaleSubscribedEvent {
  const _$_BluetoothScaleSubscribedEvent(this.pairedDevice);

  @override
  final PairedDevice pairedDevice;

  @override
  String toString() {
    return 'BluetoothEvent.scaleSubscribed(pairedDevice: $pairedDevice)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BluetoothScaleSubscribedEvent &&
            const DeepCollectionEquality()
                .equals(other.pairedDevice, pairedDevice));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(pairedDevice));

  @JsonKey(ignore: true)
  @override
  _$BluetoothScaleSubscribedEventCopyWith<_BluetoothScaleSubscribedEvent>
      get copyWith => __$BluetoothScaleSubscribedEventCopyWithImpl<
          _BluetoothScaleSubscribedEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() gotPairedDevices,
    required TResult Function() deviceConnected,
    required TResult Function(List<ConnectionStateUpdate> args)
        deviceConnectionUpdate,
    required TResult Function() scanStarted,
    required TResult Function() scanStopped,
    required TResult Function(DiscoveredDevice device) connected,
    required TResult Function() clearedControlPointResponse,
    required TResult Function(String deviceId) disconnect,
    required TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)
        savePairedDevices,
    required TResult Function(String id) pairedDeviceDeleted,
    required TResult Function(PairedDevice pairedDevice) scaleSubscribed,
  }) {
    return scaleSubscribed(pairedDevice);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? gotPairedDevices,
    TResult Function()? deviceConnected,
    TResult Function(List<ConnectionStateUpdate> args)? deviceConnectionUpdate,
    TResult Function()? scanStarted,
    TResult Function()? scanStopped,
    TResult Function(DiscoveredDevice device)? connected,
    TResult Function()? clearedControlPointResponse,
    TResult Function(String deviceId)? disconnect,
    TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)?
        savePairedDevices,
    TResult Function(String id)? pairedDeviceDeleted,
    TResult Function(PairedDevice pairedDevice)? scaleSubscribed,
  }) {
    return scaleSubscribed?.call(pairedDevice);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? gotPairedDevices,
    TResult Function()? deviceConnected,
    TResult Function(List<ConnectionStateUpdate> args)? deviceConnectionUpdate,
    TResult Function()? scanStarted,
    TResult Function()? scanStopped,
    TResult Function(DiscoveredDevice device)? connected,
    TResult Function()? clearedControlPointResponse,
    TResult Function(String deviceId)? disconnect,
    TResult Function(PairedDevice pairedDevice, bool? checkSuccess,
            List<int>? recordAccessData)?
        savePairedDevices,
    TResult Function(String id)? pairedDeviceDeleted,
    TResult Function(PairedDevice pairedDevice)? scaleSubscribed,
    required TResult orElse(),
  }) {
    if (scaleSubscribed != null) {
      return scaleSubscribed(pairedDevice);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BluetoothGotPairedDevicesEvent value)
        gotPairedDevices,
    required TResult Function(_BluetoothDeviceConnectedEvent value)
        deviceConnected,
    required TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)
        deviceConnectionUpdate,
    required TResult Function(_BluetoothScanStartedEvent value) scanStarted,
    required TResult Function(_BluetoothScanStoppedEvent value) scanStopped,
    required TResult Function(_BluetoothConnectedEvent value) connected,
    required TResult Function(_BluetoothClearedControlPointResponseEvent value)
        clearedControlPointResponse,
    required TResult Function(_BluetoothDisconnectEvent value) disconnect,
    required TResult Function(_BluetoothSavePairedDevicesEvent value)
        savePairedDevices,
    required TResult Function(_BluetoothPairedDeviceDeletedEvent value)
        pairedDeviceDeleted,
    required TResult Function(_BluetoothScaleSubscribedEvent value)
        scaleSubscribed,
  }) {
    return scaleSubscribed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_BluetoothGotPairedDevicesEvent value)? gotPairedDevices,
    TResult Function(_BluetoothDeviceConnectedEvent value)? deviceConnected,
    TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)?
        deviceConnectionUpdate,
    TResult Function(_BluetoothScanStartedEvent value)? scanStarted,
    TResult Function(_BluetoothScanStoppedEvent value)? scanStopped,
    TResult Function(_BluetoothConnectedEvent value)? connected,
    TResult Function(_BluetoothClearedControlPointResponseEvent value)?
        clearedControlPointResponse,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothSavePairedDevicesEvent value)? savePairedDevices,
    TResult Function(_BluetoothPairedDeviceDeletedEvent value)?
        pairedDeviceDeleted,
    TResult Function(_BluetoothScaleSubscribedEvent value)? scaleSubscribed,
  }) {
    return scaleSubscribed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BluetoothGotPairedDevicesEvent value)? gotPairedDevices,
    TResult Function(_BluetoothDeviceConnectedEvent value)? deviceConnected,
    TResult Function(_BluetoothDeviceConnectionUpdatedEvent value)?
        deviceConnectionUpdate,
    TResult Function(_BluetoothScanStartedEvent value)? scanStarted,
    TResult Function(_BluetoothScanStoppedEvent value)? scanStopped,
    TResult Function(_BluetoothConnectedEvent value)? connected,
    TResult Function(_BluetoothClearedControlPointResponseEvent value)?
        clearedControlPointResponse,
    TResult Function(_BluetoothDisconnectEvent value)? disconnect,
    TResult Function(_BluetoothSavePairedDevicesEvent value)? savePairedDevices,
    TResult Function(_BluetoothPairedDeviceDeletedEvent value)?
        pairedDeviceDeleted,
    TResult Function(_BluetoothScaleSubscribedEvent value)? scaleSubscribed,
    required TResult orElse(),
  }) {
    if (scaleSubscribed != null) {
      return scaleSubscribed(this);
    }
    return orElse();
  }
}

abstract class _BluetoothScaleSubscribedEvent implements BluetoothEvent {
  const factory _BluetoothScaleSubscribedEvent(PairedDevice pairedDevice) =
      _$_BluetoothScaleSubscribedEvent;

  PairedDevice get pairedDevice;
  @JsonKey(ignore: true)
  _$BluetoothScaleSubscribedEventCopyWith<_BluetoothScaleSubscribedEvent>
      get copyWith => throw _privateConstructorUsedError;
}
