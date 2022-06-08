// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'scale_treatment_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ScaleTreatmentResponse _$ScaleTreatmentResponseFromJson(
    Map<String, dynamic> json) {
  return _ScaleTreatmentResponse.fromJson(json);
}

/// @nodoc
mixin _$ScaleTreatmentResponse {
  @JsonKey(name: 'treatmentNoteList')
  List<ScaleTreatmentModel>? get treatmentNoteList =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'dietList')
  List<ScaleTreatmentDietModel>? get dietList =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'doctorNoteList')
  List<ScaleTreatmentDoctorNoteModel>? get doctorNoteList =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScaleTreatmentResponseCopyWith<ScaleTreatmentResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScaleTreatmentResponseCopyWith<$Res> {
  factory $ScaleTreatmentResponseCopyWith(ScaleTreatmentResponse value,
          $Res Function(ScaleTreatmentResponse) then) =
      _$ScaleTreatmentResponseCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'treatmentNoteList')
          List<ScaleTreatmentModel>? treatmentNoteList,
      @JsonKey(name: 'dietList')
          List<ScaleTreatmentDietModel>? dietList,
      @JsonKey(name: 'doctorNoteList')
          List<ScaleTreatmentDoctorNoteModel>? doctorNoteList});
}

/// @nodoc
class _$ScaleTreatmentResponseCopyWithImpl<$Res>
    implements $ScaleTreatmentResponseCopyWith<$Res> {
  _$ScaleTreatmentResponseCopyWithImpl(this._value, this._then);

  final ScaleTreatmentResponse _value;
  // ignore: unused_field
  final $Res Function(ScaleTreatmentResponse) _then;

  @override
  $Res call({
    Object? treatmentNoteList = freezed,
    Object? dietList = freezed,
    Object? doctorNoteList = freezed,
  }) {
    return _then(_value.copyWith(
      treatmentNoteList: treatmentNoteList == freezed
          ? _value.treatmentNoteList
          : treatmentNoteList // ignore: cast_nullable_to_non_nullable
              as List<ScaleTreatmentModel>?,
      dietList: dietList == freezed
          ? _value.dietList
          : dietList // ignore: cast_nullable_to_non_nullable
              as List<ScaleTreatmentDietModel>?,
      doctorNoteList: doctorNoteList == freezed
          ? _value.doctorNoteList
          : doctorNoteList // ignore: cast_nullable_to_non_nullable
              as List<ScaleTreatmentDoctorNoteModel>?,
    ));
  }
}

/// @nodoc
abstract class _$$_ScaleTreatmentResponseCopyWith<$Res>
    implements $ScaleTreatmentResponseCopyWith<$Res> {
  factory _$$_ScaleTreatmentResponseCopyWith(_$_ScaleTreatmentResponse value,
          $Res Function(_$_ScaleTreatmentResponse) then) =
      __$$_ScaleTreatmentResponseCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'treatmentNoteList')
          List<ScaleTreatmentModel>? treatmentNoteList,
      @JsonKey(name: 'dietList')
          List<ScaleTreatmentDietModel>? dietList,
      @JsonKey(name: 'doctorNoteList')
          List<ScaleTreatmentDoctorNoteModel>? doctorNoteList});
}

/// @nodoc
class __$$_ScaleTreatmentResponseCopyWithImpl<$Res>
    extends _$ScaleTreatmentResponseCopyWithImpl<$Res>
    implements _$$_ScaleTreatmentResponseCopyWith<$Res> {
  __$$_ScaleTreatmentResponseCopyWithImpl(_$_ScaleTreatmentResponse _value,
      $Res Function(_$_ScaleTreatmentResponse) _then)
      : super(_value, (v) => _then(v as _$_ScaleTreatmentResponse));

  @override
  _$_ScaleTreatmentResponse get _value =>
      super._value as _$_ScaleTreatmentResponse;

  @override
  $Res call({
    Object? treatmentNoteList = freezed,
    Object? dietList = freezed,
    Object? doctorNoteList = freezed,
  }) {
    return _then(_$_ScaleTreatmentResponse(
      treatmentNoteList: treatmentNoteList == freezed
          ? _value._treatmentNoteList
          : treatmentNoteList // ignore: cast_nullable_to_non_nullable
              as List<ScaleTreatmentModel>?,
      dietList: dietList == freezed
          ? _value._dietList
          : dietList // ignore: cast_nullable_to_non_nullable
              as List<ScaleTreatmentDietModel>?,
      doctorNoteList: doctorNoteList == freezed
          ? _value._doctorNoteList
          : doctorNoteList // ignore: cast_nullable_to_non_nullable
              as List<ScaleTreatmentDoctorNoteModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ScaleTreatmentResponse extends _ScaleTreatmentResponse {
  const _$_ScaleTreatmentResponse(
      {@JsonKey(name: 'treatmentNoteList')
          final List<ScaleTreatmentModel>? treatmentNoteList,
      @JsonKey(name: 'dietList')
          final List<ScaleTreatmentDietModel>? dietList,
      @JsonKey(name: 'doctorNoteList')
          final List<ScaleTreatmentDoctorNoteModel>? doctorNoteList})
      : _treatmentNoteList = treatmentNoteList,
        _dietList = dietList,
        _doctorNoteList = doctorNoteList,
        super._();

  factory _$_ScaleTreatmentResponse.fromJson(Map<String, dynamic> json) =>
      _$$_ScaleTreatmentResponseFromJson(json);

  final List<ScaleTreatmentModel>? _treatmentNoteList;
  @override
  @JsonKey(name: 'treatmentNoteList')
  List<ScaleTreatmentModel>? get treatmentNoteList {
    final value = _treatmentNoteList;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ScaleTreatmentDietModel>? _dietList;
  @override
  @JsonKey(name: 'dietList')
  List<ScaleTreatmentDietModel>? get dietList {
    final value = _dietList;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ScaleTreatmentDoctorNoteModel>? _doctorNoteList;
  @override
  @JsonKey(name: 'doctorNoteList')
  List<ScaleTreatmentDoctorNoteModel>? get doctorNoteList {
    final value = _doctorNoteList;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ScaleTreatmentResponse(treatmentNoteList: $treatmentNoteList, dietList: $dietList, doctorNoteList: $doctorNoteList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ScaleTreatmentResponse &&
            const DeepCollectionEquality()
                .equals(other._treatmentNoteList, _treatmentNoteList) &&
            const DeepCollectionEquality().equals(other._dietList, _dietList) &&
            const DeepCollectionEquality()
                .equals(other._doctorNoteList, _doctorNoteList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_treatmentNoteList),
      const DeepCollectionEquality().hash(_dietList),
      const DeepCollectionEquality().hash(_doctorNoteList));

  @JsonKey(ignore: true)
  @override
  _$$_ScaleTreatmentResponseCopyWith<_$_ScaleTreatmentResponse> get copyWith =>
      __$$_ScaleTreatmentResponseCopyWithImpl<_$_ScaleTreatmentResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ScaleTreatmentResponseToJson(this);
  }
}

abstract class _ScaleTreatmentResponse extends ScaleTreatmentResponse {
  const factory _ScaleTreatmentResponse(
          {@JsonKey(name: 'treatmentNoteList')
              final List<ScaleTreatmentModel>? treatmentNoteList,
          @JsonKey(name: 'dietList')
              final List<ScaleTreatmentDietModel>? dietList,
          @JsonKey(name: 'doctorNoteList')
              final List<ScaleTreatmentDoctorNoteModel>? doctorNoteList}) =
      _$_ScaleTreatmentResponse;
  const _ScaleTreatmentResponse._() : super._();

  factory _ScaleTreatmentResponse.fromJson(Map<String, dynamic> json) =
      _$_ScaleTreatmentResponse.fromJson;

  @override
  @JsonKey(name: 'treatmentNoteList')
  List<ScaleTreatmentModel>? get treatmentNoteList =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'dietList')
  List<ScaleTreatmentDietModel>? get dietList =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'doctorNoteList')
  List<ScaleTreatmentDoctorNoteModel>? get doctorNoteList =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ScaleTreatmentResponseCopyWith<_$_ScaleTreatmentResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

ScaleTreatmentModel _$ScaleTreatmentModelFromJson(Map<String, dynamic> json) {
  return _ScaleTreatmentModel.fromJson(json);
}

/// @nodoc
mixin _$ScaleTreatmentModel {
  @JsonKey(name: 'treatmentNoteTitle')
  String? get treatmentNoteTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'treatmentNoteCreateDate')
  DateTime? get treatmentNoteCreateDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdByName')
  String? get createdByName => throw _privateConstructorUsedError;
  @JsonKey(name: 'id')
  int? get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScaleTreatmentModelCopyWith<ScaleTreatmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScaleTreatmentModelCopyWith<$Res> {
  factory $ScaleTreatmentModelCopyWith(
          ScaleTreatmentModel value, $Res Function(ScaleTreatmentModel) then) =
      _$ScaleTreatmentModelCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'treatmentNoteTitle')
          String? treatmentNoteTitle,
      @JsonKey(name: 'treatmentNoteCreateDate')
          DateTime? treatmentNoteCreateDate,
      @JsonKey(name: 'createdByName')
          String? createdByName,
      @JsonKey(name: 'id')
          int? id});
}

/// @nodoc
class _$ScaleTreatmentModelCopyWithImpl<$Res>
    implements $ScaleTreatmentModelCopyWith<$Res> {
  _$ScaleTreatmentModelCopyWithImpl(this._value, this._then);

  final ScaleTreatmentModel _value;
  // ignore: unused_field
  final $Res Function(ScaleTreatmentModel) _then;

  @override
  $Res call({
    Object? treatmentNoteTitle = freezed,
    Object? treatmentNoteCreateDate = freezed,
    Object? createdByName = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      treatmentNoteTitle: treatmentNoteTitle == freezed
          ? _value.treatmentNoteTitle
          : treatmentNoteTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      treatmentNoteCreateDate: treatmentNoteCreateDate == freezed
          ? _value.treatmentNoteCreateDate
          : treatmentNoteCreateDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdByName: createdByName == freezed
          ? _value.createdByName
          : createdByName // ignore: cast_nullable_to_non_nullable
              as String?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$$_ScaleTreatmentModelCopyWith<$Res>
    implements $ScaleTreatmentModelCopyWith<$Res> {
  factory _$$_ScaleTreatmentModelCopyWith(_$_ScaleTreatmentModel value,
          $Res Function(_$_ScaleTreatmentModel) then) =
      __$$_ScaleTreatmentModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'treatmentNoteTitle')
          String? treatmentNoteTitle,
      @JsonKey(name: 'treatmentNoteCreateDate')
          DateTime? treatmentNoteCreateDate,
      @JsonKey(name: 'createdByName')
          String? createdByName,
      @JsonKey(name: 'id')
          int? id});
}

/// @nodoc
class __$$_ScaleTreatmentModelCopyWithImpl<$Res>
    extends _$ScaleTreatmentModelCopyWithImpl<$Res>
    implements _$$_ScaleTreatmentModelCopyWith<$Res> {
  __$$_ScaleTreatmentModelCopyWithImpl(_$_ScaleTreatmentModel _value,
      $Res Function(_$_ScaleTreatmentModel) _then)
      : super(_value, (v) => _then(v as _$_ScaleTreatmentModel));

  @override
  _$_ScaleTreatmentModel get _value => super._value as _$_ScaleTreatmentModel;

  @override
  $Res call({
    Object? treatmentNoteTitle = freezed,
    Object? treatmentNoteCreateDate = freezed,
    Object? createdByName = freezed,
    Object? id = freezed,
  }) {
    return _then(_$_ScaleTreatmentModel(
      treatmentNoteTitle: treatmentNoteTitle == freezed
          ? _value.treatmentNoteTitle
          : treatmentNoteTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      treatmentNoteCreateDate: treatmentNoteCreateDate == freezed
          ? _value.treatmentNoteCreateDate
          : treatmentNoteCreateDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdByName: createdByName == freezed
          ? _value.createdByName
          : createdByName // ignore: cast_nullable_to_non_nullable
              as String?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ScaleTreatmentModel extends _ScaleTreatmentModel {
  const _$_ScaleTreatmentModel(
      {@JsonKey(name: 'treatmentNoteTitle') this.treatmentNoteTitle,
      @JsonKey(name: 'treatmentNoteCreateDate') this.treatmentNoteCreateDate,
      @JsonKey(name: 'createdByName') this.createdByName,
      @JsonKey(name: 'id') this.id})
      : super._();

  factory _$_ScaleTreatmentModel.fromJson(Map<String, dynamic> json) =>
      _$$_ScaleTreatmentModelFromJson(json);

  @override
  @JsonKey(name: 'treatmentNoteTitle')
  final String? treatmentNoteTitle;
  @override
  @JsonKey(name: 'treatmentNoteCreateDate')
  final DateTime? treatmentNoteCreateDate;
  @override
  @JsonKey(name: 'createdByName')
  final String? createdByName;
  @override
  @JsonKey(name: 'id')
  final int? id;

  @override
  String toString() {
    return 'ScaleTreatmentModel(treatmentNoteTitle: $treatmentNoteTitle, treatmentNoteCreateDate: $treatmentNoteCreateDate, createdByName: $createdByName, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ScaleTreatmentModel &&
            const DeepCollectionEquality()
                .equals(other.treatmentNoteTitle, treatmentNoteTitle) &&
            const DeepCollectionEquality().equals(
                other.treatmentNoteCreateDate, treatmentNoteCreateDate) &&
            const DeepCollectionEquality()
                .equals(other.createdByName, createdByName) &&
            const DeepCollectionEquality().equals(other.id, id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(treatmentNoteTitle),
      const DeepCollectionEquality().hash(treatmentNoteCreateDate),
      const DeepCollectionEquality().hash(createdByName),
      const DeepCollectionEquality().hash(id));

  @JsonKey(ignore: true)
  @override
  _$$_ScaleTreatmentModelCopyWith<_$_ScaleTreatmentModel> get copyWith =>
      __$$_ScaleTreatmentModelCopyWithImpl<_$_ScaleTreatmentModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ScaleTreatmentModelToJson(this);
  }
}

abstract class _ScaleTreatmentModel extends ScaleTreatmentModel {
  const factory _ScaleTreatmentModel(
      {@JsonKey(name: 'treatmentNoteTitle')
          final String? treatmentNoteTitle,
      @JsonKey(name: 'treatmentNoteCreateDate')
          final DateTime? treatmentNoteCreateDate,
      @JsonKey(name: 'createdByName')
          final String? createdByName,
      @JsonKey(name: 'id')
          final int? id}) = _$_ScaleTreatmentModel;
  const _ScaleTreatmentModel._() : super._();

  factory _ScaleTreatmentModel.fromJson(Map<String, dynamic> json) =
      _$_ScaleTreatmentModel.fromJson;

  @override
  @JsonKey(name: 'treatmentNoteTitle')
  String? get treatmentNoteTitle => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'treatmentNoteCreateDate')
  DateTime? get treatmentNoteCreateDate => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'createdByName')
  String? get createdByName => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'id')
  int? get id => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ScaleTreatmentModelCopyWith<_$_ScaleTreatmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

ScaleTreatmentDoctorNoteModel _$ScaleTreatmentDoctorNoteModelFromJson(
    Map<String, dynamic> json) {
  return _ScaleTreatmentDoctorNoteModel.fromJson(json);
}

/// @nodoc
mixin _$ScaleTreatmentDoctorNoteModel {
  @JsonKey(name: 'treatmentNoteTitle')
  String? get treatmentNoteTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'treatmentNoteCreateDate')
  DateTime? get treatmentNoteCreateDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdByName')
  String? get createdByName => throw _privateConstructorUsedError;
  @JsonKey(name: 'id')
  int? get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScaleTreatmentDoctorNoteModelCopyWith<ScaleTreatmentDoctorNoteModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScaleTreatmentDoctorNoteModelCopyWith<$Res> {
  factory $ScaleTreatmentDoctorNoteModelCopyWith(
          ScaleTreatmentDoctorNoteModel value,
          $Res Function(ScaleTreatmentDoctorNoteModel) then) =
      _$ScaleTreatmentDoctorNoteModelCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'treatmentNoteTitle')
          String? treatmentNoteTitle,
      @JsonKey(name: 'treatmentNoteCreateDate')
          DateTime? treatmentNoteCreateDate,
      @JsonKey(name: 'createdByName')
          String? createdByName,
      @JsonKey(name: 'id')
          int? id});
}

/// @nodoc
class _$ScaleTreatmentDoctorNoteModelCopyWithImpl<$Res>
    implements $ScaleTreatmentDoctorNoteModelCopyWith<$Res> {
  _$ScaleTreatmentDoctorNoteModelCopyWithImpl(this._value, this._then);

  final ScaleTreatmentDoctorNoteModel _value;
  // ignore: unused_field
  final $Res Function(ScaleTreatmentDoctorNoteModel) _then;

  @override
  $Res call({
    Object? treatmentNoteTitle = freezed,
    Object? treatmentNoteCreateDate = freezed,
    Object? createdByName = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      treatmentNoteTitle: treatmentNoteTitle == freezed
          ? _value.treatmentNoteTitle
          : treatmentNoteTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      treatmentNoteCreateDate: treatmentNoteCreateDate == freezed
          ? _value.treatmentNoteCreateDate
          : treatmentNoteCreateDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdByName: createdByName == freezed
          ? _value.createdByName
          : createdByName // ignore: cast_nullable_to_non_nullable
              as String?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$$_ScaleTreatmentDoctorNoteModelCopyWith<$Res>
    implements $ScaleTreatmentDoctorNoteModelCopyWith<$Res> {
  factory _$$_ScaleTreatmentDoctorNoteModelCopyWith(
          _$_ScaleTreatmentDoctorNoteModel value,
          $Res Function(_$_ScaleTreatmentDoctorNoteModel) then) =
      __$$_ScaleTreatmentDoctorNoteModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'treatmentNoteTitle')
          String? treatmentNoteTitle,
      @JsonKey(name: 'treatmentNoteCreateDate')
          DateTime? treatmentNoteCreateDate,
      @JsonKey(name: 'createdByName')
          String? createdByName,
      @JsonKey(name: 'id')
          int? id});
}

/// @nodoc
class __$$_ScaleTreatmentDoctorNoteModelCopyWithImpl<$Res>
    extends _$ScaleTreatmentDoctorNoteModelCopyWithImpl<$Res>
    implements _$$_ScaleTreatmentDoctorNoteModelCopyWith<$Res> {
  __$$_ScaleTreatmentDoctorNoteModelCopyWithImpl(
      _$_ScaleTreatmentDoctorNoteModel _value,
      $Res Function(_$_ScaleTreatmentDoctorNoteModel) _then)
      : super(_value, (v) => _then(v as _$_ScaleTreatmentDoctorNoteModel));

  @override
  _$_ScaleTreatmentDoctorNoteModel get _value =>
      super._value as _$_ScaleTreatmentDoctorNoteModel;

  @override
  $Res call({
    Object? treatmentNoteTitle = freezed,
    Object? treatmentNoteCreateDate = freezed,
    Object? createdByName = freezed,
    Object? id = freezed,
  }) {
    return _then(_$_ScaleTreatmentDoctorNoteModel(
      treatmentNoteTitle: treatmentNoteTitle == freezed
          ? _value.treatmentNoteTitle
          : treatmentNoteTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      treatmentNoteCreateDate: treatmentNoteCreateDate == freezed
          ? _value.treatmentNoteCreateDate
          : treatmentNoteCreateDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdByName: createdByName == freezed
          ? _value.createdByName
          : createdByName // ignore: cast_nullable_to_non_nullable
              as String?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ScaleTreatmentDoctorNoteModel extends _ScaleTreatmentDoctorNoteModel {
  const _$_ScaleTreatmentDoctorNoteModel(
      {@JsonKey(name: 'treatmentNoteTitle') this.treatmentNoteTitle,
      @JsonKey(name: 'treatmentNoteCreateDate') this.treatmentNoteCreateDate,
      @JsonKey(name: 'createdByName') this.createdByName,
      @JsonKey(name: 'id') this.id})
      : super._();

  factory _$_ScaleTreatmentDoctorNoteModel.fromJson(
          Map<String, dynamic> json) =>
      _$$_ScaleTreatmentDoctorNoteModelFromJson(json);

  @override
  @JsonKey(name: 'treatmentNoteTitle')
  final String? treatmentNoteTitle;
  @override
  @JsonKey(name: 'treatmentNoteCreateDate')
  final DateTime? treatmentNoteCreateDate;
  @override
  @JsonKey(name: 'createdByName')
  final String? createdByName;
  @override
  @JsonKey(name: 'id')
  final int? id;

  @override
  String toString() {
    return 'ScaleTreatmentDoctorNoteModel(treatmentNoteTitle: $treatmentNoteTitle, treatmentNoteCreateDate: $treatmentNoteCreateDate, createdByName: $createdByName, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ScaleTreatmentDoctorNoteModel &&
            const DeepCollectionEquality()
                .equals(other.treatmentNoteTitle, treatmentNoteTitle) &&
            const DeepCollectionEquality().equals(
                other.treatmentNoteCreateDate, treatmentNoteCreateDate) &&
            const DeepCollectionEquality()
                .equals(other.createdByName, createdByName) &&
            const DeepCollectionEquality().equals(other.id, id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(treatmentNoteTitle),
      const DeepCollectionEquality().hash(treatmentNoteCreateDate),
      const DeepCollectionEquality().hash(createdByName),
      const DeepCollectionEquality().hash(id));

  @JsonKey(ignore: true)
  @override
  _$$_ScaleTreatmentDoctorNoteModelCopyWith<_$_ScaleTreatmentDoctorNoteModel>
      get copyWith => __$$_ScaleTreatmentDoctorNoteModelCopyWithImpl<
          _$_ScaleTreatmentDoctorNoteModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ScaleTreatmentDoctorNoteModelToJson(this);
  }
}

abstract class _ScaleTreatmentDoctorNoteModel
    extends ScaleTreatmentDoctorNoteModel {
  const factory _ScaleTreatmentDoctorNoteModel(
      {@JsonKey(name: 'treatmentNoteTitle')
          final String? treatmentNoteTitle,
      @JsonKey(name: 'treatmentNoteCreateDate')
          final DateTime? treatmentNoteCreateDate,
      @JsonKey(name: 'createdByName')
          final String? createdByName,
      @JsonKey(name: 'id')
          final int? id}) = _$_ScaleTreatmentDoctorNoteModel;
  const _ScaleTreatmentDoctorNoteModel._() : super._();

  factory _ScaleTreatmentDoctorNoteModel.fromJson(Map<String, dynamic> json) =
      _$_ScaleTreatmentDoctorNoteModel.fromJson;

  @override
  @JsonKey(name: 'treatmentNoteTitle')
  String? get treatmentNoteTitle => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'treatmentNoteCreateDate')
  DateTime? get treatmentNoteCreateDate => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'createdByName')
  String? get createdByName => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'id')
  int? get id => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ScaleTreatmentDoctorNoteModelCopyWith<_$_ScaleTreatmentDoctorNoteModel>
      get copyWith => throw _privateConstructorUsedError;
}

ScaleTreatmentDietModel _$ScaleTreatmentDietModelFromJson(
    Map<String, dynamic> json) {
  return _ScaleTreatmentDietModel.fromJson(json);
}

/// @nodoc
mixin _$ScaleTreatmentDietModel {
  @JsonKey(name: 'dietTitle')
  String? get dietTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'dietCreateDate', nullable: true)
  DateTime? get dietCreateDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdByName')
  String? get createdByName => throw _privateConstructorUsedError;
  @JsonKey(name: 'id')
  int? get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScaleTreatmentDietModelCopyWith<ScaleTreatmentDietModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScaleTreatmentDietModelCopyWith<$Res> {
  factory $ScaleTreatmentDietModelCopyWith(ScaleTreatmentDietModel value,
          $Res Function(ScaleTreatmentDietModel) then) =
      _$ScaleTreatmentDietModelCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'dietTitle') String? dietTitle,
      @JsonKey(name: 'dietCreateDate', nullable: true) DateTime? dietCreateDate,
      @JsonKey(name: 'createdByName') String? createdByName,
      @JsonKey(name: 'id') int? id});
}

/// @nodoc
class _$ScaleTreatmentDietModelCopyWithImpl<$Res>
    implements $ScaleTreatmentDietModelCopyWith<$Res> {
  _$ScaleTreatmentDietModelCopyWithImpl(this._value, this._then);

  final ScaleTreatmentDietModel _value;
  // ignore: unused_field
  final $Res Function(ScaleTreatmentDietModel) _then;

  @override
  $Res call({
    Object? dietTitle = freezed,
    Object? dietCreateDate = freezed,
    Object? createdByName = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      dietTitle: dietTitle == freezed
          ? _value.dietTitle
          : dietTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      dietCreateDate: dietCreateDate == freezed
          ? _value.dietCreateDate
          : dietCreateDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdByName: createdByName == freezed
          ? _value.createdByName
          : createdByName // ignore: cast_nullable_to_non_nullable
              as String?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$$_ScaleTreatmentDietModelCopyWith<$Res>
    implements $ScaleTreatmentDietModelCopyWith<$Res> {
  factory _$$_ScaleTreatmentDietModelCopyWith(_$_ScaleTreatmentDietModel value,
          $Res Function(_$_ScaleTreatmentDietModel) then) =
      __$$_ScaleTreatmentDietModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'dietTitle') String? dietTitle,
      @JsonKey(name: 'dietCreateDate', nullable: true) DateTime? dietCreateDate,
      @JsonKey(name: 'createdByName') String? createdByName,
      @JsonKey(name: 'id') int? id});
}

/// @nodoc
class __$$_ScaleTreatmentDietModelCopyWithImpl<$Res>
    extends _$ScaleTreatmentDietModelCopyWithImpl<$Res>
    implements _$$_ScaleTreatmentDietModelCopyWith<$Res> {
  __$$_ScaleTreatmentDietModelCopyWithImpl(_$_ScaleTreatmentDietModel _value,
      $Res Function(_$_ScaleTreatmentDietModel) _then)
      : super(_value, (v) => _then(v as _$_ScaleTreatmentDietModel));

  @override
  _$_ScaleTreatmentDietModel get _value =>
      super._value as _$_ScaleTreatmentDietModel;

  @override
  $Res call({
    Object? dietTitle = freezed,
    Object? dietCreateDate = freezed,
    Object? createdByName = freezed,
    Object? id = freezed,
  }) {
    return _then(_$_ScaleTreatmentDietModel(
      dietTitle: dietTitle == freezed
          ? _value.dietTitle
          : dietTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      dietCreateDate: dietCreateDate == freezed
          ? _value.dietCreateDate
          : dietCreateDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdByName: createdByName == freezed
          ? _value.createdByName
          : createdByName // ignore: cast_nullable_to_non_nullable
              as String?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ScaleTreatmentDietModel extends _ScaleTreatmentDietModel {
  const _$_ScaleTreatmentDietModel(
      {@JsonKey(name: 'dietTitle') this.dietTitle,
      @JsonKey(name: 'dietCreateDate', nullable: true) this.dietCreateDate,
      @JsonKey(name: 'createdByName') this.createdByName,
      @JsonKey(name: 'id') this.id})
      : super._();

  factory _$_ScaleTreatmentDietModel.fromJson(Map<String, dynamic> json) =>
      _$$_ScaleTreatmentDietModelFromJson(json);

  @override
  @JsonKey(name: 'dietTitle')
  final String? dietTitle;
  @override
  @JsonKey(name: 'dietCreateDate', nullable: true)
  final DateTime? dietCreateDate;
  @override
  @JsonKey(name: 'createdByName')
  final String? createdByName;
  @override
  @JsonKey(name: 'id')
  final int? id;

  @override
  String toString() {
    return 'ScaleTreatmentDietModel(dietTitle: $dietTitle, dietCreateDate: $dietCreateDate, createdByName: $createdByName, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ScaleTreatmentDietModel &&
            const DeepCollectionEquality().equals(other.dietTitle, dietTitle) &&
            const DeepCollectionEquality()
                .equals(other.dietCreateDate, dietCreateDate) &&
            const DeepCollectionEquality()
                .equals(other.createdByName, createdByName) &&
            const DeepCollectionEquality().equals(other.id, id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(dietTitle),
      const DeepCollectionEquality().hash(dietCreateDate),
      const DeepCollectionEquality().hash(createdByName),
      const DeepCollectionEquality().hash(id));

  @JsonKey(ignore: true)
  @override
  _$$_ScaleTreatmentDietModelCopyWith<_$_ScaleTreatmentDietModel>
      get copyWith =>
          __$$_ScaleTreatmentDietModelCopyWithImpl<_$_ScaleTreatmentDietModel>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ScaleTreatmentDietModelToJson(this);
  }
}

abstract class _ScaleTreatmentDietModel extends ScaleTreatmentDietModel {
  const factory _ScaleTreatmentDietModel(
      {@JsonKey(name: 'dietTitle')
          final String? dietTitle,
      @JsonKey(name: 'dietCreateDate', nullable: true)
          final DateTime? dietCreateDate,
      @JsonKey(name: 'createdByName')
          final String? createdByName,
      @JsonKey(name: 'id')
          final int? id}) = _$_ScaleTreatmentDietModel;
  const _ScaleTreatmentDietModel._() : super._();

  factory _ScaleTreatmentDietModel.fromJson(Map<String, dynamic> json) =
      _$_ScaleTreatmentDietModel.fromJson;

  @override
  @JsonKey(name: 'dietTitle')
  String? get dietTitle => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'dietCreateDate', nullable: true)
  DateTime? get dietCreateDate => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'createdByName')
  String? get createdByName => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'id')
  int? get id => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ScaleTreatmentDietModelCopyWith<_$_ScaleTreatmentDietModel>
      get copyWith => throw _privateConstructorUsedError;
}
