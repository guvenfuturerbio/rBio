// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'exceptions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$HiveScaleExceptionTearOff {
  const _$HiveScaleExceptionTearOff();

  HiveScaleBoxClosedException boxClosed([String? message]) {
    return HiveScaleBoxClosedException(
      message,
    );
  }

  HiveScaleFailedToDeleteException failedToDelete([String? message]) {
    return HiveScaleFailedToDeleteException(
      message,
    );
  }

  HiveScaleFailedToWriteException failedToWrite([String? message]) {
    return HiveScaleFailedToWriteException(
      message,
    );
  }

  HiveScaleFailedToUpdateException failedToUpdate([String? message]) {
    return HiveScaleFailedToUpdateException(
      message,
    );
  }

  HiveScaleFailedToReadException failedToRead([String? message]) {
    return HiveScaleFailedToReadException(
      message,
    );
  }
}

/// @nodoc
const $HiveScaleException = _$HiveScaleExceptionTearOff();

/// @nodoc
mixin _$HiveScaleException {
  String? get message => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) boxClosed,
    required TResult Function(String? message) failedToDelete,
    required TResult Function(String? message) failedToWrite,
    required TResult Function(String? message) failedToUpdate,
    required TResult Function(String? message) failedToRead,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? message)? boxClosed,
    TResult Function(String? message)? failedToDelete,
    TResult Function(String? message)? failedToWrite,
    TResult Function(String? message)? failedToUpdate,
    TResult Function(String? message)? failedToRead,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? boxClosed,
    TResult Function(String? message)? failedToDelete,
    TResult Function(String? message)? failedToWrite,
    TResult Function(String? message)? failedToUpdate,
    TResult Function(String? message)? failedToRead,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HiveScaleBoxClosedException value) boxClosed,
    required TResult Function(HiveScaleFailedToDeleteException value)
        failedToDelete,
    required TResult Function(HiveScaleFailedToWriteException value)
        failedToWrite,
    required TResult Function(HiveScaleFailedToUpdateException value)
        failedToUpdate,
    required TResult Function(HiveScaleFailedToReadException value)
        failedToRead,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(HiveScaleBoxClosedException value)? boxClosed,
    TResult Function(HiveScaleFailedToDeleteException value)? failedToDelete,
    TResult Function(HiveScaleFailedToWriteException value)? failedToWrite,
    TResult Function(HiveScaleFailedToUpdateException value)? failedToUpdate,
    TResult Function(HiveScaleFailedToReadException value)? failedToRead,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HiveScaleBoxClosedException value)? boxClosed,
    TResult Function(HiveScaleFailedToDeleteException value)? failedToDelete,
    TResult Function(HiveScaleFailedToWriteException value)? failedToWrite,
    TResult Function(HiveScaleFailedToUpdateException value)? failedToUpdate,
    TResult Function(HiveScaleFailedToReadException value)? failedToRead,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HiveScaleExceptionCopyWith<HiveScaleException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HiveScaleExceptionCopyWith<$Res> {
  factory $HiveScaleExceptionCopyWith(
          HiveScaleException value, $Res Function(HiveScaleException) then) =
      _$HiveScaleExceptionCopyWithImpl<$Res>;
  $Res call({String? message});
}

/// @nodoc
class _$HiveScaleExceptionCopyWithImpl<$Res>
    implements $HiveScaleExceptionCopyWith<$Res> {
  _$HiveScaleExceptionCopyWithImpl(this._value, this._then);

  final HiveScaleException _value;
  // ignore: unused_field
  final $Res Function(HiveScaleException) _then;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class $HiveScaleBoxClosedExceptionCopyWith<$Res>
    implements $HiveScaleExceptionCopyWith<$Res> {
  factory $HiveScaleBoxClosedExceptionCopyWith(
          HiveScaleBoxClosedException value,
          $Res Function(HiveScaleBoxClosedException) then) =
      _$HiveScaleBoxClosedExceptionCopyWithImpl<$Res>;
  @override
  $Res call({String? message});
}

/// @nodoc
class _$HiveScaleBoxClosedExceptionCopyWithImpl<$Res>
    extends _$HiveScaleExceptionCopyWithImpl<$Res>
    implements $HiveScaleBoxClosedExceptionCopyWith<$Res> {
  _$HiveScaleBoxClosedExceptionCopyWithImpl(HiveScaleBoxClosedException _value,
      $Res Function(HiveScaleBoxClosedException) _then)
      : super(_value, (v) => _then(v as HiveScaleBoxClosedException));

  @override
  HiveScaleBoxClosedException get _value =>
      super._value as HiveScaleBoxClosedException;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(HiveScaleBoxClosedException(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@Implements<Exception>()
class _$HiveScaleBoxClosedException implements HiveScaleBoxClosedException {
  const _$HiveScaleBoxClosedException([this.message]);

  @override
  final String? message;

  @override
  String toString() {
    return 'HiveScaleException.boxClosed(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HiveScaleBoxClosedException &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  $HiveScaleBoxClosedExceptionCopyWith<HiveScaleBoxClosedException>
      get copyWith => _$HiveScaleBoxClosedExceptionCopyWithImpl<
          HiveScaleBoxClosedException>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) boxClosed,
    required TResult Function(String? message) failedToDelete,
    required TResult Function(String? message) failedToWrite,
    required TResult Function(String? message) failedToUpdate,
    required TResult Function(String? message) failedToRead,
  }) {
    return boxClosed(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? message)? boxClosed,
    TResult Function(String? message)? failedToDelete,
    TResult Function(String? message)? failedToWrite,
    TResult Function(String? message)? failedToUpdate,
    TResult Function(String? message)? failedToRead,
  }) {
    return boxClosed?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? boxClosed,
    TResult Function(String? message)? failedToDelete,
    TResult Function(String? message)? failedToWrite,
    TResult Function(String? message)? failedToUpdate,
    TResult Function(String? message)? failedToRead,
    required TResult orElse(),
  }) {
    if (boxClosed != null) {
      return boxClosed(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HiveScaleBoxClosedException value) boxClosed,
    required TResult Function(HiveScaleFailedToDeleteException value)
        failedToDelete,
    required TResult Function(HiveScaleFailedToWriteException value)
        failedToWrite,
    required TResult Function(HiveScaleFailedToUpdateException value)
        failedToUpdate,
    required TResult Function(HiveScaleFailedToReadException value)
        failedToRead,
  }) {
    return boxClosed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(HiveScaleBoxClosedException value)? boxClosed,
    TResult Function(HiveScaleFailedToDeleteException value)? failedToDelete,
    TResult Function(HiveScaleFailedToWriteException value)? failedToWrite,
    TResult Function(HiveScaleFailedToUpdateException value)? failedToUpdate,
    TResult Function(HiveScaleFailedToReadException value)? failedToRead,
  }) {
    return boxClosed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HiveScaleBoxClosedException value)? boxClosed,
    TResult Function(HiveScaleFailedToDeleteException value)? failedToDelete,
    TResult Function(HiveScaleFailedToWriteException value)? failedToWrite,
    TResult Function(HiveScaleFailedToUpdateException value)? failedToUpdate,
    TResult Function(HiveScaleFailedToReadException value)? failedToRead,
    required TResult orElse(),
  }) {
    if (boxClosed != null) {
      return boxClosed(this);
    }
    return orElse();
  }
}

abstract class HiveScaleBoxClosedException
    implements HiveScaleException, Exception {
  const factory HiveScaleBoxClosedException([String? message]) =
      _$HiveScaleBoxClosedException;

  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  $HiveScaleBoxClosedExceptionCopyWith<HiveScaleBoxClosedException>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HiveScaleFailedToDeleteExceptionCopyWith<$Res>
    implements $HiveScaleExceptionCopyWith<$Res> {
  factory $HiveScaleFailedToDeleteExceptionCopyWith(
          HiveScaleFailedToDeleteException value,
          $Res Function(HiveScaleFailedToDeleteException) then) =
      _$HiveScaleFailedToDeleteExceptionCopyWithImpl<$Res>;
  @override
  $Res call({String? message});
}

/// @nodoc
class _$HiveScaleFailedToDeleteExceptionCopyWithImpl<$Res>
    extends _$HiveScaleExceptionCopyWithImpl<$Res>
    implements $HiveScaleFailedToDeleteExceptionCopyWith<$Res> {
  _$HiveScaleFailedToDeleteExceptionCopyWithImpl(
      HiveScaleFailedToDeleteException _value,
      $Res Function(HiveScaleFailedToDeleteException) _then)
      : super(_value, (v) => _then(v as HiveScaleFailedToDeleteException));

  @override
  HiveScaleFailedToDeleteException get _value =>
      super._value as HiveScaleFailedToDeleteException;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(HiveScaleFailedToDeleteException(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@Implements<Exception>()
class _$HiveScaleFailedToDeleteException
    implements HiveScaleFailedToDeleteException {
  const _$HiveScaleFailedToDeleteException([this.message]);

  @override
  final String? message;

  @override
  String toString() {
    return 'HiveScaleException.failedToDelete(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HiveScaleFailedToDeleteException &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  $HiveScaleFailedToDeleteExceptionCopyWith<HiveScaleFailedToDeleteException>
      get copyWith => _$HiveScaleFailedToDeleteExceptionCopyWithImpl<
          HiveScaleFailedToDeleteException>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) boxClosed,
    required TResult Function(String? message) failedToDelete,
    required TResult Function(String? message) failedToWrite,
    required TResult Function(String? message) failedToUpdate,
    required TResult Function(String? message) failedToRead,
  }) {
    return failedToDelete(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? message)? boxClosed,
    TResult Function(String? message)? failedToDelete,
    TResult Function(String? message)? failedToWrite,
    TResult Function(String? message)? failedToUpdate,
    TResult Function(String? message)? failedToRead,
  }) {
    return failedToDelete?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? boxClosed,
    TResult Function(String? message)? failedToDelete,
    TResult Function(String? message)? failedToWrite,
    TResult Function(String? message)? failedToUpdate,
    TResult Function(String? message)? failedToRead,
    required TResult orElse(),
  }) {
    if (failedToDelete != null) {
      return failedToDelete(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HiveScaleBoxClosedException value) boxClosed,
    required TResult Function(HiveScaleFailedToDeleteException value)
        failedToDelete,
    required TResult Function(HiveScaleFailedToWriteException value)
        failedToWrite,
    required TResult Function(HiveScaleFailedToUpdateException value)
        failedToUpdate,
    required TResult Function(HiveScaleFailedToReadException value)
        failedToRead,
  }) {
    return failedToDelete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(HiveScaleBoxClosedException value)? boxClosed,
    TResult Function(HiveScaleFailedToDeleteException value)? failedToDelete,
    TResult Function(HiveScaleFailedToWriteException value)? failedToWrite,
    TResult Function(HiveScaleFailedToUpdateException value)? failedToUpdate,
    TResult Function(HiveScaleFailedToReadException value)? failedToRead,
  }) {
    return failedToDelete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HiveScaleBoxClosedException value)? boxClosed,
    TResult Function(HiveScaleFailedToDeleteException value)? failedToDelete,
    TResult Function(HiveScaleFailedToWriteException value)? failedToWrite,
    TResult Function(HiveScaleFailedToUpdateException value)? failedToUpdate,
    TResult Function(HiveScaleFailedToReadException value)? failedToRead,
    required TResult orElse(),
  }) {
    if (failedToDelete != null) {
      return failedToDelete(this);
    }
    return orElse();
  }
}

abstract class HiveScaleFailedToDeleteException
    implements HiveScaleException, Exception {
  const factory HiveScaleFailedToDeleteException([String? message]) =
      _$HiveScaleFailedToDeleteException;

  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  $HiveScaleFailedToDeleteExceptionCopyWith<HiveScaleFailedToDeleteException>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HiveScaleFailedToWriteExceptionCopyWith<$Res>
    implements $HiveScaleExceptionCopyWith<$Res> {
  factory $HiveScaleFailedToWriteExceptionCopyWith(
          HiveScaleFailedToWriteException value,
          $Res Function(HiveScaleFailedToWriteException) then) =
      _$HiveScaleFailedToWriteExceptionCopyWithImpl<$Res>;
  @override
  $Res call({String? message});
}

/// @nodoc
class _$HiveScaleFailedToWriteExceptionCopyWithImpl<$Res>
    extends _$HiveScaleExceptionCopyWithImpl<$Res>
    implements $HiveScaleFailedToWriteExceptionCopyWith<$Res> {
  _$HiveScaleFailedToWriteExceptionCopyWithImpl(
      HiveScaleFailedToWriteException _value,
      $Res Function(HiveScaleFailedToWriteException) _then)
      : super(_value, (v) => _then(v as HiveScaleFailedToWriteException));

  @override
  HiveScaleFailedToWriteException get _value =>
      super._value as HiveScaleFailedToWriteException;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(HiveScaleFailedToWriteException(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@Implements<Exception>()
class _$HiveScaleFailedToWriteException
    implements HiveScaleFailedToWriteException {
  const _$HiveScaleFailedToWriteException([this.message]);

  @override
  final String? message;

  @override
  String toString() {
    return 'HiveScaleException.failedToWrite(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HiveScaleFailedToWriteException &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  $HiveScaleFailedToWriteExceptionCopyWith<HiveScaleFailedToWriteException>
      get copyWith => _$HiveScaleFailedToWriteExceptionCopyWithImpl<
          HiveScaleFailedToWriteException>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) boxClosed,
    required TResult Function(String? message) failedToDelete,
    required TResult Function(String? message) failedToWrite,
    required TResult Function(String? message) failedToUpdate,
    required TResult Function(String? message) failedToRead,
  }) {
    return failedToWrite(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? message)? boxClosed,
    TResult Function(String? message)? failedToDelete,
    TResult Function(String? message)? failedToWrite,
    TResult Function(String? message)? failedToUpdate,
    TResult Function(String? message)? failedToRead,
  }) {
    return failedToWrite?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? boxClosed,
    TResult Function(String? message)? failedToDelete,
    TResult Function(String? message)? failedToWrite,
    TResult Function(String? message)? failedToUpdate,
    TResult Function(String? message)? failedToRead,
    required TResult orElse(),
  }) {
    if (failedToWrite != null) {
      return failedToWrite(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HiveScaleBoxClosedException value) boxClosed,
    required TResult Function(HiveScaleFailedToDeleteException value)
        failedToDelete,
    required TResult Function(HiveScaleFailedToWriteException value)
        failedToWrite,
    required TResult Function(HiveScaleFailedToUpdateException value)
        failedToUpdate,
    required TResult Function(HiveScaleFailedToReadException value)
        failedToRead,
  }) {
    return failedToWrite(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(HiveScaleBoxClosedException value)? boxClosed,
    TResult Function(HiveScaleFailedToDeleteException value)? failedToDelete,
    TResult Function(HiveScaleFailedToWriteException value)? failedToWrite,
    TResult Function(HiveScaleFailedToUpdateException value)? failedToUpdate,
    TResult Function(HiveScaleFailedToReadException value)? failedToRead,
  }) {
    return failedToWrite?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HiveScaleBoxClosedException value)? boxClosed,
    TResult Function(HiveScaleFailedToDeleteException value)? failedToDelete,
    TResult Function(HiveScaleFailedToWriteException value)? failedToWrite,
    TResult Function(HiveScaleFailedToUpdateException value)? failedToUpdate,
    TResult Function(HiveScaleFailedToReadException value)? failedToRead,
    required TResult orElse(),
  }) {
    if (failedToWrite != null) {
      return failedToWrite(this);
    }
    return orElse();
  }
}

abstract class HiveScaleFailedToWriteException
    implements HiveScaleException, Exception {
  const factory HiveScaleFailedToWriteException([String? message]) =
      _$HiveScaleFailedToWriteException;

  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  $HiveScaleFailedToWriteExceptionCopyWith<HiveScaleFailedToWriteException>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HiveScaleFailedToUpdateExceptionCopyWith<$Res>
    implements $HiveScaleExceptionCopyWith<$Res> {
  factory $HiveScaleFailedToUpdateExceptionCopyWith(
          HiveScaleFailedToUpdateException value,
          $Res Function(HiveScaleFailedToUpdateException) then) =
      _$HiveScaleFailedToUpdateExceptionCopyWithImpl<$Res>;
  @override
  $Res call({String? message});
}

/// @nodoc
class _$HiveScaleFailedToUpdateExceptionCopyWithImpl<$Res>
    extends _$HiveScaleExceptionCopyWithImpl<$Res>
    implements $HiveScaleFailedToUpdateExceptionCopyWith<$Res> {
  _$HiveScaleFailedToUpdateExceptionCopyWithImpl(
      HiveScaleFailedToUpdateException _value,
      $Res Function(HiveScaleFailedToUpdateException) _then)
      : super(_value, (v) => _then(v as HiveScaleFailedToUpdateException));

  @override
  HiveScaleFailedToUpdateException get _value =>
      super._value as HiveScaleFailedToUpdateException;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(HiveScaleFailedToUpdateException(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@Implements<Exception>()
class _$HiveScaleFailedToUpdateException
    implements HiveScaleFailedToUpdateException {
  const _$HiveScaleFailedToUpdateException([this.message]);

  @override
  final String? message;

  @override
  String toString() {
    return 'HiveScaleException.failedToUpdate(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HiveScaleFailedToUpdateException &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  $HiveScaleFailedToUpdateExceptionCopyWith<HiveScaleFailedToUpdateException>
      get copyWith => _$HiveScaleFailedToUpdateExceptionCopyWithImpl<
          HiveScaleFailedToUpdateException>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) boxClosed,
    required TResult Function(String? message) failedToDelete,
    required TResult Function(String? message) failedToWrite,
    required TResult Function(String? message) failedToUpdate,
    required TResult Function(String? message) failedToRead,
  }) {
    return failedToUpdate(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? message)? boxClosed,
    TResult Function(String? message)? failedToDelete,
    TResult Function(String? message)? failedToWrite,
    TResult Function(String? message)? failedToUpdate,
    TResult Function(String? message)? failedToRead,
  }) {
    return failedToUpdate?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? boxClosed,
    TResult Function(String? message)? failedToDelete,
    TResult Function(String? message)? failedToWrite,
    TResult Function(String? message)? failedToUpdate,
    TResult Function(String? message)? failedToRead,
    required TResult orElse(),
  }) {
    if (failedToUpdate != null) {
      return failedToUpdate(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HiveScaleBoxClosedException value) boxClosed,
    required TResult Function(HiveScaleFailedToDeleteException value)
        failedToDelete,
    required TResult Function(HiveScaleFailedToWriteException value)
        failedToWrite,
    required TResult Function(HiveScaleFailedToUpdateException value)
        failedToUpdate,
    required TResult Function(HiveScaleFailedToReadException value)
        failedToRead,
  }) {
    return failedToUpdate(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(HiveScaleBoxClosedException value)? boxClosed,
    TResult Function(HiveScaleFailedToDeleteException value)? failedToDelete,
    TResult Function(HiveScaleFailedToWriteException value)? failedToWrite,
    TResult Function(HiveScaleFailedToUpdateException value)? failedToUpdate,
    TResult Function(HiveScaleFailedToReadException value)? failedToRead,
  }) {
    return failedToUpdate?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HiveScaleBoxClosedException value)? boxClosed,
    TResult Function(HiveScaleFailedToDeleteException value)? failedToDelete,
    TResult Function(HiveScaleFailedToWriteException value)? failedToWrite,
    TResult Function(HiveScaleFailedToUpdateException value)? failedToUpdate,
    TResult Function(HiveScaleFailedToReadException value)? failedToRead,
    required TResult orElse(),
  }) {
    if (failedToUpdate != null) {
      return failedToUpdate(this);
    }
    return orElse();
  }
}

abstract class HiveScaleFailedToUpdateException
    implements HiveScaleException, Exception {
  const factory HiveScaleFailedToUpdateException([String? message]) =
      _$HiveScaleFailedToUpdateException;

  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  $HiveScaleFailedToUpdateExceptionCopyWith<HiveScaleFailedToUpdateException>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HiveScaleFailedToReadExceptionCopyWith<$Res>
    implements $HiveScaleExceptionCopyWith<$Res> {
  factory $HiveScaleFailedToReadExceptionCopyWith(
          HiveScaleFailedToReadException value,
          $Res Function(HiveScaleFailedToReadException) then) =
      _$HiveScaleFailedToReadExceptionCopyWithImpl<$Res>;
  @override
  $Res call({String? message});
}

/// @nodoc
class _$HiveScaleFailedToReadExceptionCopyWithImpl<$Res>
    extends _$HiveScaleExceptionCopyWithImpl<$Res>
    implements $HiveScaleFailedToReadExceptionCopyWith<$Res> {
  _$HiveScaleFailedToReadExceptionCopyWithImpl(
      HiveScaleFailedToReadException _value,
      $Res Function(HiveScaleFailedToReadException) _then)
      : super(_value, (v) => _then(v as HiveScaleFailedToReadException));

  @override
  HiveScaleFailedToReadException get _value =>
      super._value as HiveScaleFailedToReadException;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(HiveScaleFailedToReadException(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@Implements<Exception>()
class _$HiveScaleFailedToReadException
    implements HiveScaleFailedToReadException {
  const _$HiveScaleFailedToReadException([this.message]);

  @override
  final String? message;

  @override
  String toString() {
    return 'HiveScaleException.failedToRead(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HiveScaleFailedToReadException &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  $HiveScaleFailedToReadExceptionCopyWith<HiveScaleFailedToReadException>
      get copyWith => _$HiveScaleFailedToReadExceptionCopyWithImpl<
          HiveScaleFailedToReadException>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) boxClosed,
    required TResult Function(String? message) failedToDelete,
    required TResult Function(String? message) failedToWrite,
    required TResult Function(String? message) failedToUpdate,
    required TResult Function(String? message) failedToRead,
  }) {
    return failedToRead(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? message)? boxClosed,
    TResult Function(String? message)? failedToDelete,
    TResult Function(String? message)? failedToWrite,
    TResult Function(String? message)? failedToUpdate,
    TResult Function(String? message)? failedToRead,
  }) {
    return failedToRead?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? boxClosed,
    TResult Function(String? message)? failedToDelete,
    TResult Function(String? message)? failedToWrite,
    TResult Function(String? message)? failedToUpdate,
    TResult Function(String? message)? failedToRead,
    required TResult orElse(),
  }) {
    if (failedToRead != null) {
      return failedToRead(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HiveScaleBoxClosedException value) boxClosed,
    required TResult Function(HiveScaleFailedToDeleteException value)
        failedToDelete,
    required TResult Function(HiveScaleFailedToWriteException value)
        failedToWrite,
    required TResult Function(HiveScaleFailedToUpdateException value)
        failedToUpdate,
    required TResult Function(HiveScaleFailedToReadException value)
        failedToRead,
  }) {
    return failedToRead(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(HiveScaleBoxClosedException value)? boxClosed,
    TResult Function(HiveScaleFailedToDeleteException value)? failedToDelete,
    TResult Function(HiveScaleFailedToWriteException value)? failedToWrite,
    TResult Function(HiveScaleFailedToUpdateException value)? failedToUpdate,
    TResult Function(HiveScaleFailedToReadException value)? failedToRead,
  }) {
    return failedToRead?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HiveScaleBoxClosedException value)? boxClosed,
    TResult Function(HiveScaleFailedToDeleteException value)? failedToDelete,
    TResult Function(HiveScaleFailedToWriteException value)? failedToWrite,
    TResult Function(HiveScaleFailedToUpdateException value)? failedToUpdate,
    TResult Function(HiveScaleFailedToReadException value)? failedToRead,
    required TResult orElse(),
  }) {
    if (failedToRead != null) {
      return failedToRead(this);
    }
    return orElse();
  }
}

abstract class HiveScaleFailedToReadException
    implements HiveScaleException, Exception {
  const factory HiveScaleFailedToReadException([String? message]) =
      _$HiveScaleFailedToReadException;

  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  $HiveScaleFailedToReadExceptionCopyWith<HiveScaleFailedToReadException>
      get copyWith => throw _privateConstructorUsedError;
}
