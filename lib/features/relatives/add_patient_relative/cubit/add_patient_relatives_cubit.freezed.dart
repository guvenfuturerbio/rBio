// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'add_patient_relatives_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AddPatientRelativesState {
  UserRelativePatientModel get model => throw _privateConstructorUsedError;
  AddPatientRelativesStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddPatientRelativesStateCopyWith<AddPatientRelativesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddPatientRelativesStateCopyWith<$Res> {
  factory $AddPatientRelativesStateCopyWith(AddPatientRelativesState value,
          $Res Function(AddPatientRelativesState) then) =
      _$AddPatientRelativesStateCopyWithImpl<$Res>;
  $Res call({UserRelativePatientModel model, AddPatientRelativesStatus status});
}

/// @nodoc
class _$AddPatientRelativesStateCopyWithImpl<$Res>
    implements $AddPatientRelativesStateCopyWith<$Res> {
  _$AddPatientRelativesStateCopyWithImpl(this._value, this._then);

  final AddPatientRelativesState _value;
  // ignore: unused_field
  final $Res Function(AddPatientRelativesState) _then;

  @override
  $Res call({
    Object? model = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      model: model == freezed
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as UserRelativePatientModel,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AddPatientRelativesStatus,
    ));
  }
}

/// @nodoc
abstract class _$$_AddPatientRelativesStateCopyWith<$Res>
    implements $AddPatientRelativesStateCopyWith<$Res> {
  factory _$$_AddPatientRelativesStateCopyWith(
          _$_AddPatientRelativesState value,
          $Res Function(_$_AddPatientRelativesState) then) =
      __$$_AddPatientRelativesStateCopyWithImpl<$Res>;
  @override
  $Res call({UserRelativePatientModel model, AddPatientRelativesStatus status});
}

/// @nodoc
class __$$_AddPatientRelativesStateCopyWithImpl<$Res>
    extends _$AddPatientRelativesStateCopyWithImpl<$Res>
    implements _$$_AddPatientRelativesStateCopyWith<$Res> {
  __$$_AddPatientRelativesStateCopyWithImpl(_$_AddPatientRelativesState _value,
      $Res Function(_$_AddPatientRelativesState) _then)
      : super(_value, (v) => _then(v as _$_AddPatientRelativesState));

  @override
  _$_AddPatientRelativesState get _value =>
      super._value as _$_AddPatientRelativesState;

  @override
  $Res call({
    Object? model = freezed,
    Object? status = freezed,
  }) {
    return _then(_$_AddPatientRelativesState(
      model: model == freezed
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as UserRelativePatientModel,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AddPatientRelativesStatus,
    ));
  }
}

/// @nodoc

class _$_AddPatientRelativesState extends _AddPatientRelativesState {
  const _$_AddPatientRelativesState(
      {required this.model, this.status = AddPatientRelativesStatus.initial})
      : super._();

  @override
  final UserRelativePatientModel model;
  @override
  @JsonKey()
  final AddPatientRelativesStatus status;

  @override
  String toString() {
    return 'AddPatientRelativesState(model: $model, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddPatientRelativesState &&
            const DeepCollectionEquality().equals(other.model, model) &&
            const DeepCollectionEquality().equals(other.status, status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(model),
      const DeepCollectionEquality().hash(status));

  @JsonKey(ignore: true)
  @override
  _$$_AddPatientRelativesStateCopyWith<_$_AddPatientRelativesState>
      get copyWith => __$$_AddPatientRelativesStateCopyWithImpl<
          _$_AddPatientRelativesState>(this, _$identity);
}

abstract class _AddPatientRelativesState extends AddPatientRelativesState {
  const factory _AddPatientRelativesState(
      {required final UserRelativePatientModel model,
      final AddPatientRelativesStatus status}) = _$_AddPatientRelativesState;
  const _AddPatientRelativesState._() : super._();

  @override
  UserRelativePatientModel get model => throw _privateConstructorUsedError;
  @override
  AddPatientRelativesStatus get status => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_AddPatientRelativesStateCopyWith<_$_AddPatientRelativesState>
      get copyWith => throw _privateConstructorUsedError;
}
