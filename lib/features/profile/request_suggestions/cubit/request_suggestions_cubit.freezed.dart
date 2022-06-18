// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'request_suggestions_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RequestSuggestionsState {
  RequestSuggestionsStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RequestSuggestionsStateCopyWith<RequestSuggestionsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestSuggestionsStateCopyWith<$Res> {
  factory $RequestSuggestionsStateCopyWith(RequestSuggestionsState value,
          $Res Function(RequestSuggestionsState) then) =
      _$RequestSuggestionsStateCopyWithImpl<$Res>;
  $Res call({RequestSuggestionsStatus status});
}

/// @nodoc
class _$RequestSuggestionsStateCopyWithImpl<$Res>
    implements $RequestSuggestionsStateCopyWith<$Res> {
  _$RequestSuggestionsStateCopyWithImpl(this._value, this._then);

  final RequestSuggestionsState _value;
  // ignore: unused_field
  final $Res Function(RequestSuggestionsState) _then;

  @override
  $Res call({
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RequestSuggestionsStatus,
    ));
  }
}

/// @nodoc
abstract class _$$_RequestSuggestionsStateCopyWith<$Res>
    implements $RequestSuggestionsStateCopyWith<$Res> {
  factory _$$_RequestSuggestionsStateCopyWith(_$_RequestSuggestionsState value,
          $Res Function(_$_RequestSuggestionsState) then) =
      __$$_RequestSuggestionsStateCopyWithImpl<$Res>;
  @override
  $Res call({RequestSuggestionsStatus status});
}

/// @nodoc
class __$$_RequestSuggestionsStateCopyWithImpl<$Res>
    extends _$RequestSuggestionsStateCopyWithImpl<$Res>
    implements _$$_RequestSuggestionsStateCopyWith<$Res> {
  __$$_RequestSuggestionsStateCopyWithImpl(_$_RequestSuggestionsState _value,
      $Res Function(_$_RequestSuggestionsState) _then)
      : super(_value, (v) => _then(v as _$_RequestSuggestionsState));

  @override
  _$_RequestSuggestionsState get _value =>
      super._value as _$_RequestSuggestionsState;

  @override
  $Res call({
    Object? status = freezed,
  }) {
    return _then(_$_RequestSuggestionsState(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RequestSuggestionsStatus,
    ));
  }
}

/// @nodoc

class _$_RequestSuggestionsState implements _RequestSuggestionsState {
  const _$_RequestSuggestionsState(
      {this.status = RequestSuggestionsStatus.initial});

  @override
  @JsonKey()
  final RequestSuggestionsStatus status;

  @override
  String toString() {
    return 'RequestSuggestionsState(status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RequestSuggestionsState &&
            const DeepCollectionEquality().equals(other.status, status));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(status));

  @JsonKey(ignore: true)
  @override
  _$$_RequestSuggestionsStateCopyWith<_$_RequestSuggestionsState>
      get copyWith =>
          __$$_RequestSuggestionsStateCopyWithImpl<_$_RequestSuggestionsState>(
              this, _$identity);
}

abstract class _RequestSuggestionsState implements RequestSuggestionsState {
  const factory _RequestSuggestionsState(
      {final RequestSuggestionsStatus status}) = _$_RequestSuggestionsState;

  @override
  RequestSuggestionsStatus get status => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_RequestSuggestionsStateCopyWith<_$_RequestSuggestionsState>
      get copyWith => throw _privateConstructorUsedError;
}
