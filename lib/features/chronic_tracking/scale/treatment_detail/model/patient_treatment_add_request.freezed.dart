// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'patient_treatment_add_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PatientTreatmentAddRequest _$PatientTreatmentAddRequestFromJson(
    Map<String, dynamic> json) {
  return _PatientTreatmentAddRequest.fromJson(json);
}

/// @nodoc
class _$PatientTreatmentAddRequestTearOff {
  const _$PatientTreatmentAddRequestTearOff();

  _PatientTreatmentAddRequest call(
      {@JsonKey(name: 'title') String? title,
      @JsonKey(name: 'text') String? text,
      @JsonKey(name: 'treatmentNoteTypeId') int? treatmentNoteTypeId}) {
    return _PatientTreatmentAddRequest(
      title: title,
      text: text,
      treatmentNoteTypeId: treatmentNoteTypeId,
    );
  }

  PatientTreatmentAddRequest fromJson(Map<String, Object?> json) {
    return PatientTreatmentAddRequest.fromJson(json);
  }
}

/// @nodoc
const $PatientTreatmentAddRequest = _$PatientTreatmentAddRequestTearOff();

/// @nodoc
mixin _$PatientTreatmentAddRequest {
  @JsonKey(name: 'title')
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'text')
  String? get text => throw _privateConstructorUsedError;
  @JsonKey(name: 'treatmentNoteTypeId')
  int? get treatmentNoteTypeId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PatientTreatmentAddRequestCopyWith<PatientTreatmentAddRequest>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatientTreatmentAddRequestCopyWith<$Res> {
  factory $PatientTreatmentAddRequestCopyWith(PatientTreatmentAddRequest value,
          $Res Function(PatientTreatmentAddRequest) then) =
      _$PatientTreatmentAddRequestCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'title') String? title,
      @JsonKey(name: 'text') String? text,
      @JsonKey(name: 'treatmentNoteTypeId') int? treatmentNoteTypeId});
}

/// @nodoc
class _$PatientTreatmentAddRequestCopyWithImpl<$Res>
    implements $PatientTreatmentAddRequestCopyWith<$Res> {
  _$PatientTreatmentAddRequestCopyWithImpl(this._value, this._then);

  final PatientTreatmentAddRequest _value;
  // ignore: unused_field
  final $Res Function(PatientTreatmentAddRequest) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? text = freezed,
    Object? treatmentNoteTypeId = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      treatmentNoteTypeId: treatmentNoteTypeId == freezed
          ? _value.treatmentNoteTypeId
          : treatmentNoteTypeId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$PatientTreatmentAddRequestCopyWith<$Res>
    implements $PatientTreatmentAddRequestCopyWith<$Res> {
  factory _$PatientTreatmentAddRequestCopyWith(
          _PatientTreatmentAddRequest value,
          $Res Function(_PatientTreatmentAddRequest) then) =
      __$PatientTreatmentAddRequestCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'title') String? title,
      @JsonKey(name: 'text') String? text,
      @JsonKey(name: 'treatmentNoteTypeId') int? treatmentNoteTypeId});
}

/// @nodoc
class __$PatientTreatmentAddRequestCopyWithImpl<$Res>
    extends _$PatientTreatmentAddRequestCopyWithImpl<$Res>
    implements _$PatientTreatmentAddRequestCopyWith<$Res> {
  __$PatientTreatmentAddRequestCopyWithImpl(_PatientTreatmentAddRequest _value,
      $Res Function(_PatientTreatmentAddRequest) _then)
      : super(_value, (v) => _then(v as _PatientTreatmentAddRequest));

  @override
  _PatientTreatmentAddRequest get _value =>
      super._value as _PatientTreatmentAddRequest;

  @override
  $Res call({
    Object? title = freezed,
    Object? text = freezed,
    Object? treatmentNoteTypeId = freezed,
  }) {
    return _then(_PatientTreatmentAddRequest(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      treatmentNoteTypeId: treatmentNoteTypeId == freezed
          ? _value.treatmentNoteTypeId
          : treatmentNoteTypeId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PatientTreatmentAddRequest extends _PatientTreatmentAddRequest {
  const _$_PatientTreatmentAddRequest(
      {@JsonKey(name: 'title') this.title,
      @JsonKey(name: 'text') this.text,
      @JsonKey(name: 'treatmentNoteTypeId') this.treatmentNoteTypeId})
      : super._();

  factory _$_PatientTreatmentAddRequest.fromJson(Map<String, dynamic> json) =>
      _$$_PatientTreatmentAddRequestFromJson(json);

  @override
  @JsonKey(name: 'title')
  final String? title;
  @override
  @JsonKey(name: 'text')
  final String? text;
  @override
  @JsonKey(name: 'treatmentNoteTypeId')
  final int? treatmentNoteTypeId;

  @override
  String toString() {
    return 'PatientTreatmentAddRequest(title: $title, text: $text, treatmentNoteTypeId: $treatmentNoteTypeId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PatientTreatmentAddRequest &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.text, text) &&
            const DeepCollectionEquality()
                .equals(other.treatmentNoteTypeId, treatmentNoteTypeId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(text),
      const DeepCollectionEquality().hash(treatmentNoteTypeId));

  @JsonKey(ignore: true)
  @override
  _$PatientTreatmentAddRequestCopyWith<_PatientTreatmentAddRequest>
      get copyWith => __$PatientTreatmentAddRequestCopyWithImpl<
          _PatientTreatmentAddRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PatientTreatmentAddRequestToJson(this);
  }
}

abstract class _PatientTreatmentAddRequest extends PatientTreatmentAddRequest {
  const factory _PatientTreatmentAddRequest(
          {@JsonKey(name: 'title') String? title,
          @JsonKey(name: 'text') String? text,
          @JsonKey(name: 'treatmentNoteTypeId') int? treatmentNoteTypeId}) =
      _$_PatientTreatmentAddRequest;
  const _PatientTreatmentAddRequest._() : super._();

  factory _PatientTreatmentAddRequest.fromJson(Map<String, dynamic> json) =
      _$_PatientTreatmentAddRequest.fromJson;

  @override
  @JsonKey(name: 'title')
  String? get title;
  @override
  @JsonKey(name: 'text')
  String? get text;
  @override
  @JsonKey(name: 'treatmentNoteTypeId')
  int? get treatmentNoteTypeId;
  @override
  @JsonKey(ignore: true)
  _$PatientTreatmentAddRequestCopyWith<_PatientTreatmentAddRequest>
      get copyWith => throw _privateConstructorUsedError;
}
