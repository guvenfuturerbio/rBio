// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'scale_doctor_loaded_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ScaleDoctorLoadedResult _$ScaleDoctorLoadedResultFromJson(
    Map<String, dynamic> json) {
  return _ScaleDoctorLoadedResult.fromJson(json);
}

/// @nodoc
class _$ScaleDoctorLoadedResultTearOff {
  const _$ScaleDoctorLoadedResultTearOff();

  _ScaleDoctorLoadedResult call(
      {bool isChartVisible = false,
      GraphTypes graphType = GraphTypes.weight,
      required List<PatientScaleMeasurement> patientScaleMeasurements}) {
    return _ScaleDoctorLoadedResult(
      isChartVisible: isChartVisible,
      graphType: graphType,
      patientScaleMeasurements: patientScaleMeasurements,
    );
  }

  ScaleDoctorLoadedResult fromJson(Map<String, Object?> json) {
    return ScaleDoctorLoadedResult.fromJson(json);
  }
}

/// @nodoc
const $ScaleDoctorLoadedResult = _$ScaleDoctorLoadedResultTearOff();

/// @nodoc
mixin _$ScaleDoctorLoadedResult {
  bool get isChartVisible => throw _privateConstructorUsedError;
  GraphTypes get graphType => throw _privateConstructorUsedError;
  List<PatientScaleMeasurement> get patientScaleMeasurements =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScaleDoctorLoadedResultCopyWith<ScaleDoctorLoadedResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScaleDoctorLoadedResultCopyWith<$Res> {
  factory $ScaleDoctorLoadedResultCopyWith(ScaleDoctorLoadedResult value,
          $Res Function(ScaleDoctorLoadedResult) then) =
      _$ScaleDoctorLoadedResultCopyWithImpl<$Res>;
  $Res call(
      {bool isChartVisible,
      GraphTypes graphType,
      List<PatientScaleMeasurement> patientScaleMeasurements});
}

/// @nodoc
class _$ScaleDoctorLoadedResultCopyWithImpl<$Res>
    implements $ScaleDoctorLoadedResultCopyWith<$Res> {
  _$ScaleDoctorLoadedResultCopyWithImpl(this._value, this._then);

  final ScaleDoctorLoadedResult _value;
  // ignore: unused_field
  final $Res Function(ScaleDoctorLoadedResult) _then;

  @override
  $Res call({
    Object? isChartVisible = freezed,
    Object? graphType = freezed,
    Object? patientScaleMeasurements = freezed,
  }) {
    return _then(_value.copyWith(
      isChartVisible: isChartVisible == freezed
          ? _value.isChartVisible
          : isChartVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      graphType: graphType == freezed
          ? _value.graphType
          : graphType // ignore: cast_nullable_to_non_nullable
              as GraphTypes,
      patientScaleMeasurements: patientScaleMeasurements == freezed
          ? _value.patientScaleMeasurements
          : patientScaleMeasurements // ignore: cast_nullable_to_non_nullable
              as List<PatientScaleMeasurement>,
    ));
  }
}

/// @nodoc
abstract class _$ScaleDoctorLoadedResultCopyWith<$Res>
    implements $ScaleDoctorLoadedResultCopyWith<$Res> {
  factory _$ScaleDoctorLoadedResultCopyWith(_ScaleDoctorLoadedResult value,
          $Res Function(_ScaleDoctorLoadedResult) then) =
      __$ScaleDoctorLoadedResultCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool isChartVisible,
      GraphTypes graphType,
      List<PatientScaleMeasurement> patientScaleMeasurements});
}

/// @nodoc
class __$ScaleDoctorLoadedResultCopyWithImpl<$Res>
    extends _$ScaleDoctorLoadedResultCopyWithImpl<$Res>
    implements _$ScaleDoctorLoadedResultCopyWith<$Res> {
  __$ScaleDoctorLoadedResultCopyWithImpl(_ScaleDoctorLoadedResult _value,
      $Res Function(_ScaleDoctorLoadedResult) _then)
      : super(_value, (v) => _then(v as _ScaleDoctorLoadedResult));

  @override
  _ScaleDoctorLoadedResult get _value =>
      super._value as _ScaleDoctorLoadedResult;

  @override
  $Res call({
    Object? isChartVisible = freezed,
    Object? graphType = freezed,
    Object? patientScaleMeasurements = freezed,
  }) {
    return _then(_ScaleDoctorLoadedResult(
      isChartVisible: isChartVisible == freezed
          ? _value.isChartVisible
          : isChartVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      graphType: graphType == freezed
          ? _value.graphType
          : graphType // ignore: cast_nullable_to_non_nullable
              as GraphTypes,
      patientScaleMeasurements: patientScaleMeasurements == freezed
          ? _value.patientScaleMeasurements
          : patientScaleMeasurements // ignore: cast_nullable_to_non_nullable
              as List<PatientScaleMeasurement>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ScaleDoctorLoadedResult implements _ScaleDoctorLoadedResult {
  const _$_ScaleDoctorLoadedResult(
      {this.isChartVisible = false,
      this.graphType = GraphTypes.weight,
      required this.patientScaleMeasurements});

  factory _$_ScaleDoctorLoadedResult.fromJson(Map<String, dynamic> json) =>
      _$$_ScaleDoctorLoadedResultFromJson(json);

  @JsonKey()
  @override
  final bool isChartVisible;
  @JsonKey()
  @override
  final GraphTypes graphType;
  @override
  final List<PatientScaleMeasurement> patientScaleMeasurements;

  @override
  String toString() {
    return 'ScaleDoctorLoadedResult(isChartVisible: $isChartVisible, graphType: $graphType, patientScaleMeasurements: $patientScaleMeasurements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ScaleDoctorLoadedResult &&
            const DeepCollectionEquality()
                .equals(other.isChartVisible, isChartVisible) &&
            const DeepCollectionEquality().equals(other.graphType, graphType) &&
            const DeepCollectionEquality().equals(
                other.patientScaleMeasurements, patientScaleMeasurements));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isChartVisible),
      const DeepCollectionEquality().hash(graphType),
      const DeepCollectionEquality().hash(patientScaleMeasurements));

  @JsonKey(ignore: true)
  @override
  _$ScaleDoctorLoadedResultCopyWith<_ScaleDoctorLoadedResult> get copyWith =>
      __$ScaleDoctorLoadedResultCopyWithImpl<_ScaleDoctorLoadedResult>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ScaleDoctorLoadedResultToJson(this);
  }
}

abstract class _ScaleDoctorLoadedResult implements ScaleDoctorLoadedResult {
  const factory _ScaleDoctorLoadedResult(
          {bool isChartVisible,
          GraphTypes graphType,
          required List<PatientScaleMeasurement> patientScaleMeasurements}) =
      _$_ScaleDoctorLoadedResult;

  factory _ScaleDoctorLoadedResult.fromJson(Map<String, dynamic> json) =
      _$_ScaleDoctorLoadedResult.fromJson;

  @override
  bool get isChartVisible;
  @override
  GraphTypes get graphType;
  @override
  List<PatientScaleMeasurement> get patientScaleMeasurements;
  @override
  @JsonKey(ignore: true)
  _$ScaleDoctorLoadedResultCopyWith<_ScaleDoctorLoadedResult> get copyWith =>
      throw _privateConstructorUsedError;
}
