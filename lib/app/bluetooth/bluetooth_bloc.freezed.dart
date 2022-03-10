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
