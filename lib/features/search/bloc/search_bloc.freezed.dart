// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'search_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SearchEventTearOff {
  const _$SearchEventTearOff();

  SearchFetched fetch() {
    return const SearchFetched();
  }

  SearchTextFiltered textFilter(String input) {
    return SearchTextFiltered(
      input,
    );
  }

  SearchPlatformFiltered platformFilter(SearchSocialType type) {
    return SearchPlatformFiltered(
      type,
    );
  }

  SearchFilterRetrieved filterRetrieved() {
    return const SearchFilterRetrieved();
  }
}

/// @nodoc
const $SearchEvent = _$SearchEventTearOff();

/// @nodoc
mixin _$SearchEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
    required TResult Function(String input) textFilter,
    required TResult Function(SearchSocialType type) platformFilter,
    required TResult Function() filterRetrieved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(String input)? textFilter,
    TResult Function(SearchSocialType type)? platformFilter,
    TResult Function()? filterRetrieved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(String input)? textFilter,
    TResult Function(SearchSocialType type)? platformFilter,
    TResult Function()? filterRetrieved,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchFetched value) fetch,
    required TResult Function(SearchTextFiltered value) textFilter,
    required TResult Function(SearchPlatformFiltered value) platformFilter,
    required TResult Function(SearchFilterRetrieved value) filterRetrieved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SearchFetched value)? fetch,
    TResult Function(SearchTextFiltered value)? textFilter,
    TResult Function(SearchPlatformFiltered value)? platformFilter,
    TResult Function(SearchFilterRetrieved value)? filterRetrieved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchFetched value)? fetch,
    TResult Function(SearchTextFiltered value)? textFilter,
    TResult Function(SearchPlatformFiltered value)? platformFilter,
    TResult Function(SearchFilterRetrieved value)? filterRetrieved,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchEventCopyWith<$Res> {
  factory $SearchEventCopyWith(
          SearchEvent value, $Res Function(SearchEvent) then) =
      _$SearchEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$SearchEventCopyWithImpl<$Res> implements $SearchEventCopyWith<$Res> {
  _$SearchEventCopyWithImpl(this._value, this._then);

  final SearchEvent _value;
  // ignore: unused_field
  final $Res Function(SearchEvent) _then;
}

/// @nodoc
abstract class $SearchFetchedCopyWith<$Res> {
  factory $SearchFetchedCopyWith(
          SearchFetched value, $Res Function(SearchFetched) then) =
      _$SearchFetchedCopyWithImpl<$Res>;
}

/// @nodoc
class _$SearchFetchedCopyWithImpl<$Res> extends _$SearchEventCopyWithImpl<$Res>
    implements $SearchFetchedCopyWith<$Res> {
  _$SearchFetchedCopyWithImpl(
      SearchFetched _value, $Res Function(SearchFetched) _then)
      : super(_value, (v) => _then(v as SearchFetched));

  @override
  SearchFetched get _value => super._value as SearchFetched;
}

/// @nodoc

class _$SearchFetched implements SearchFetched {
  const _$SearchFetched();

  @override
  String toString() {
    return 'SearchEvent.fetch()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SearchFetched);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
    required TResult Function(String input) textFilter,
    required TResult Function(SearchSocialType type) platformFilter,
    required TResult Function() filterRetrieved,
  }) {
    return fetch();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(String input)? textFilter,
    TResult Function(SearchSocialType type)? platformFilter,
    TResult Function()? filterRetrieved,
  }) {
    return fetch?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(String input)? textFilter,
    TResult Function(SearchSocialType type)? platformFilter,
    TResult Function()? filterRetrieved,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchFetched value) fetch,
    required TResult Function(SearchTextFiltered value) textFilter,
    required TResult Function(SearchPlatformFiltered value) platformFilter,
    required TResult Function(SearchFilterRetrieved value) filterRetrieved,
  }) {
    return fetch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SearchFetched value)? fetch,
    TResult Function(SearchTextFiltered value)? textFilter,
    TResult Function(SearchPlatformFiltered value)? platformFilter,
    TResult Function(SearchFilterRetrieved value)? filterRetrieved,
  }) {
    return fetch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchFetched value)? fetch,
    TResult Function(SearchTextFiltered value)? textFilter,
    TResult Function(SearchPlatformFiltered value)? platformFilter,
    TResult Function(SearchFilterRetrieved value)? filterRetrieved,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(this);
    }
    return orElse();
  }
}

abstract class SearchFetched implements SearchEvent {
  const factory SearchFetched() = _$SearchFetched;
}

/// @nodoc
abstract class $SearchTextFilteredCopyWith<$Res> {
  factory $SearchTextFilteredCopyWith(
          SearchTextFiltered value, $Res Function(SearchTextFiltered) then) =
      _$SearchTextFilteredCopyWithImpl<$Res>;
  $Res call({String input});
}

/// @nodoc
class _$SearchTextFilteredCopyWithImpl<$Res>
    extends _$SearchEventCopyWithImpl<$Res>
    implements $SearchTextFilteredCopyWith<$Res> {
  _$SearchTextFilteredCopyWithImpl(
      SearchTextFiltered _value, $Res Function(SearchTextFiltered) _then)
      : super(_value, (v) => _then(v as SearchTextFiltered));

  @override
  SearchTextFiltered get _value => super._value as SearchTextFiltered;

  @override
  $Res call({
    Object? input = freezed,
  }) {
    return _then(SearchTextFiltered(
      input == freezed
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SearchTextFiltered implements SearchTextFiltered {
  const _$SearchTextFiltered(this.input);

  @override
  final String input;

  @override
  String toString() {
    return 'SearchEvent.textFilter(input: $input)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SearchTextFiltered &&
            const DeepCollectionEquality().equals(other.input, input));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(input));

  @JsonKey(ignore: true)
  @override
  $SearchTextFilteredCopyWith<SearchTextFiltered> get copyWith =>
      _$SearchTextFilteredCopyWithImpl<SearchTextFiltered>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
    required TResult Function(String input) textFilter,
    required TResult Function(SearchSocialType type) platformFilter,
    required TResult Function() filterRetrieved,
  }) {
    return textFilter(input);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(String input)? textFilter,
    TResult Function(SearchSocialType type)? platformFilter,
    TResult Function()? filterRetrieved,
  }) {
    return textFilter?.call(input);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(String input)? textFilter,
    TResult Function(SearchSocialType type)? platformFilter,
    TResult Function()? filterRetrieved,
    required TResult orElse(),
  }) {
    if (textFilter != null) {
      return textFilter(input);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchFetched value) fetch,
    required TResult Function(SearchTextFiltered value) textFilter,
    required TResult Function(SearchPlatformFiltered value) platformFilter,
    required TResult Function(SearchFilterRetrieved value) filterRetrieved,
  }) {
    return textFilter(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SearchFetched value)? fetch,
    TResult Function(SearchTextFiltered value)? textFilter,
    TResult Function(SearchPlatformFiltered value)? platformFilter,
    TResult Function(SearchFilterRetrieved value)? filterRetrieved,
  }) {
    return textFilter?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchFetched value)? fetch,
    TResult Function(SearchTextFiltered value)? textFilter,
    TResult Function(SearchPlatformFiltered value)? platformFilter,
    TResult Function(SearchFilterRetrieved value)? filterRetrieved,
    required TResult orElse(),
  }) {
    if (textFilter != null) {
      return textFilter(this);
    }
    return orElse();
  }
}

abstract class SearchTextFiltered implements SearchEvent {
  const factory SearchTextFiltered(String input) = _$SearchTextFiltered;

  String get input;
  @JsonKey(ignore: true)
  $SearchTextFilteredCopyWith<SearchTextFiltered> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchPlatformFilteredCopyWith<$Res> {
  factory $SearchPlatformFilteredCopyWith(SearchPlatformFiltered value,
          $Res Function(SearchPlatformFiltered) then) =
      _$SearchPlatformFilteredCopyWithImpl<$Res>;
  $Res call({SearchSocialType type});
}

/// @nodoc
class _$SearchPlatformFilteredCopyWithImpl<$Res>
    extends _$SearchEventCopyWithImpl<$Res>
    implements $SearchPlatformFilteredCopyWith<$Res> {
  _$SearchPlatformFilteredCopyWithImpl(SearchPlatformFiltered _value,
      $Res Function(SearchPlatformFiltered) _then)
      : super(_value, (v) => _then(v as SearchPlatformFiltered));

  @override
  SearchPlatformFiltered get _value => super._value as SearchPlatformFiltered;

  @override
  $Res call({
    Object? type = freezed,
  }) {
    return _then(SearchPlatformFiltered(
      type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SearchSocialType,
    ));
  }
}

/// @nodoc

class _$SearchPlatformFiltered implements SearchPlatformFiltered {
  const _$SearchPlatformFiltered(this.type);

  @override
  final SearchSocialType type;

  @override
  String toString() {
    return 'SearchEvent.platformFilter(type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SearchPlatformFiltered &&
            const DeepCollectionEquality().equals(other.type, type));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(type));

  @JsonKey(ignore: true)
  @override
  $SearchPlatformFilteredCopyWith<SearchPlatformFiltered> get copyWith =>
      _$SearchPlatformFilteredCopyWithImpl<SearchPlatformFiltered>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
    required TResult Function(String input) textFilter,
    required TResult Function(SearchSocialType type) platformFilter,
    required TResult Function() filterRetrieved,
  }) {
    return platformFilter(type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(String input)? textFilter,
    TResult Function(SearchSocialType type)? platformFilter,
    TResult Function()? filterRetrieved,
  }) {
    return platformFilter?.call(type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(String input)? textFilter,
    TResult Function(SearchSocialType type)? platformFilter,
    TResult Function()? filterRetrieved,
    required TResult orElse(),
  }) {
    if (platformFilter != null) {
      return platformFilter(type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchFetched value) fetch,
    required TResult Function(SearchTextFiltered value) textFilter,
    required TResult Function(SearchPlatformFiltered value) platformFilter,
    required TResult Function(SearchFilterRetrieved value) filterRetrieved,
  }) {
    return platformFilter(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SearchFetched value)? fetch,
    TResult Function(SearchTextFiltered value)? textFilter,
    TResult Function(SearchPlatformFiltered value)? platformFilter,
    TResult Function(SearchFilterRetrieved value)? filterRetrieved,
  }) {
    return platformFilter?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchFetched value)? fetch,
    TResult Function(SearchTextFiltered value)? textFilter,
    TResult Function(SearchPlatformFiltered value)? platformFilter,
    TResult Function(SearchFilterRetrieved value)? filterRetrieved,
    required TResult orElse(),
  }) {
    if (platformFilter != null) {
      return platformFilter(this);
    }
    return orElse();
  }
}

abstract class SearchPlatformFiltered implements SearchEvent {
  const factory SearchPlatformFiltered(SearchSocialType type) =
      _$SearchPlatformFiltered;

  SearchSocialType get type;
  @JsonKey(ignore: true)
  $SearchPlatformFilteredCopyWith<SearchPlatformFiltered> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchFilterRetrievedCopyWith<$Res> {
  factory $SearchFilterRetrievedCopyWith(SearchFilterRetrieved value,
          $Res Function(SearchFilterRetrieved) then) =
      _$SearchFilterRetrievedCopyWithImpl<$Res>;
}

/// @nodoc
class _$SearchFilterRetrievedCopyWithImpl<$Res>
    extends _$SearchEventCopyWithImpl<$Res>
    implements $SearchFilterRetrievedCopyWith<$Res> {
  _$SearchFilterRetrievedCopyWithImpl(
      SearchFilterRetrieved _value, $Res Function(SearchFilterRetrieved) _then)
      : super(_value, (v) => _then(v as SearchFilterRetrieved));

  @override
  SearchFilterRetrieved get _value => super._value as SearchFilterRetrieved;
}

/// @nodoc

class _$SearchFilterRetrieved implements SearchFilterRetrieved {
  const _$SearchFilterRetrieved();

  @override
  String toString() {
    return 'SearchEvent.filterRetrieved()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SearchFilterRetrieved);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
    required TResult Function(String input) textFilter,
    required TResult Function(SearchSocialType type) platformFilter,
    required TResult Function() filterRetrieved,
  }) {
    return filterRetrieved();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(String input)? textFilter,
    TResult Function(SearchSocialType type)? platformFilter,
    TResult Function()? filterRetrieved,
  }) {
    return filterRetrieved?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(String input)? textFilter,
    TResult Function(SearchSocialType type)? platformFilter,
    TResult Function()? filterRetrieved,
    required TResult orElse(),
  }) {
    if (filterRetrieved != null) {
      return filterRetrieved();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchFetched value) fetch,
    required TResult Function(SearchTextFiltered value) textFilter,
    required TResult Function(SearchPlatformFiltered value) platformFilter,
    required TResult Function(SearchFilterRetrieved value) filterRetrieved,
  }) {
    return filterRetrieved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SearchFetched value)? fetch,
    TResult Function(SearchTextFiltered value)? textFilter,
    TResult Function(SearchPlatformFiltered value)? platformFilter,
    TResult Function(SearchFilterRetrieved value)? filterRetrieved,
  }) {
    return filterRetrieved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchFetched value)? fetch,
    TResult Function(SearchTextFiltered value)? textFilter,
    TResult Function(SearchPlatformFiltered value)? platformFilter,
    TResult Function(SearchFilterRetrieved value)? filterRetrieved,
    required TResult orElse(),
  }) {
    if (filterRetrieved != null) {
      return filterRetrieved(this);
    }
    return orElse();
  }
}

abstract class SearchFilterRetrieved implements SearchEvent {
  const factory SearchFilterRetrieved() = _$SearchFilterRetrieved;
}

/// @nodoc
class _$SearchStateTearOff {
  const _$SearchStateTearOff();

  SearchInitial initial() {
    return const SearchInitial();
  }

  SearchLoadInProgress loadInProgress(List<SearchSocialType>? socialTypes) {
    return SearchLoadInProgress(
      socialTypes,
    );
  }

  SearchSuccess success(
      List<SearchModel> list, List<SearchSocialType> socialTypes) {
    return SearchSuccess(
      list,
      socialTypes,
    );
  }

  SearchFailure failure() {
    return const SearchFailure();
  }
}

/// @nodoc
const $SearchState = _$SearchStateTearOff();

/// @nodoc
mixin _$SearchState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<SearchSocialType>? socialTypes)
        loadInProgress,
    required TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)
        success,
    required TResult Function() failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SearchSocialType>? socialTypes)? loadInProgress,
    TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)?
        success,
    TResult Function()? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SearchSocialType>? socialTypes)? loadInProgress,
    TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)?
        success,
    TResult Function()? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchInitial value) initial,
    required TResult Function(SearchLoadInProgress value) loadInProgress,
    required TResult Function(SearchSuccess value) success,
    required TResult Function(SearchFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SearchInitial value)? initial,
    TResult Function(SearchLoadInProgress value)? loadInProgress,
    TResult Function(SearchSuccess value)? success,
    TResult Function(SearchFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchInitial value)? initial,
    TResult Function(SearchLoadInProgress value)? loadInProgress,
    TResult Function(SearchSuccess value)? success,
    TResult Function(SearchFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchStateCopyWith<$Res> {
  factory $SearchStateCopyWith(
          SearchState value, $Res Function(SearchState) then) =
      _$SearchStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$SearchStateCopyWithImpl<$Res> implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._value, this._then);

  final SearchState _value;
  // ignore: unused_field
  final $Res Function(SearchState) _then;
}

/// @nodoc
abstract class $SearchInitialCopyWith<$Res> {
  factory $SearchInitialCopyWith(
          SearchInitial value, $Res Function(SearchInitial) then) =
      _$SearchInitialCopyWithImpl<$Res>;
}

/// @nodoc
class _$SearchInitialCopyWithImpl<$Res> extends _$SearchStateCopyWithImpl<$Res>
    implements $SearchInitialCopyWith<$Res> {
  _$SearchInitialCopyWithImpl(
      SearchInitial _value, $Res Function(SearchInitial) _then)
      : super(_value, (v) => _then(v as SearchInitial));

  @override
  SearchInitial get _value => super._value as SearchInitial;
}

/// @nodoc

class _$SearchInitial implements SearchInitial {
  const _$SearchInitial();

  @override
  String toString() {
    return 'SearchState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SearchInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<SearchSocialType>? socialTypes)
        loadInProgress,
    required TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)
        success,
    required TResult Function() failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SearchSocialType>? socialTypes)? loadInProgress,
    TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)?
        success,
    TResult Function()? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SearchSocialType>? socialTypes)? loadInProgress,
    TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)?
        success,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchInitial value) initial,
    required TResult Function(SearchLoadInProgress value) loadInProgress,
    required TResult Function(SearchSuccess value) success,
    required TResult Function(SearchFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SearchInitial value)? initial,
    TResult Function(SearchLoadInProgress value)? loadInProgress,
    TResult Function(SearchSuccess value)? success,
    TResult Function(SearchFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchInitial value)? initial,
    TResult Function(SearchLoadInProgress value)? loadInProgress,
    TResult Function(SearchSuccess value)? success,
    TResult Function(SearchFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class SearchInitial implements SearchState {
  const factory SearchInitial() = _$SearchInitial;
}

/// @nodoc
abstract class $SearchLoadInProgressCopyWith<$Res> {
  factory $SearchLoadInProgressCopyWith(SearchLoadInProgress value,
          $Res Function(SearchLoadInProgress) then) =
      _$SearchLoadInProgressCopyWithImpl<$Res>;
  $Res call({List<SearchSocialType>? socialTypes});
}

/// @nodoc
class _$SearchLoadInProgressCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res>
    implements $SearchLoadInProgressCopyWith<$Res> {
  _$SearchLoadInProgressCopyWithImpl(
      SearchLoadInProgress _value, $Res Function(SearchLoadInProgress) _then)
      : super(_value, (v) => _then(v as SearchLoadInProgress));

  @override
  SearchLoadInProgress get _value => super._value as SearchLoadInProgress;

  @override
  $Res call({
    Object? socialTypes = freezed,
  }) {
    return _then(SearchLoadInProgress(
      socialTypes == freezed
          ? _value.socialTypes
          : socialTypes // ignore: cast_nullable_to_non_nullable
              as List<SearchSocialType>?,
    ));
  }
}

/// @nodoc

class _$SearchLoadInProgress implements SearchLoadInProgress {
  const _$SearchLoadInProgress(this.socialTypes);

  @override
  final List<SearchSocialType>? socialTypes;

  @override
  String toString() {
    return 'SearchState.loadInProgress(socialTypes: $socialTypes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SearchLoadInProgress &&
            const DeepCollectionEquality()
                .equals(other.socialTypes, socialTypes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(socialTypes));

  @JsonKey(ignore: true)
  @override
  $SearchLoadInProgressCopyWith<SearchLoadInProgress> get copyWith =>
      _$SearchLoadInProgressCopyWithImpl<SearchLoadInProgress>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<SearchSocialType>? socialTypes)
        loadInProgress,
    required TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)
        success,
    required TResult Function() failure,
  }) {
    return loadInProgress(socialTypes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SearchSocialType>? socialTypes)? loadInProgress,
    TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)?
        success,
    TResult Function()? failure,
  }) {
    return loadInProgress?.call(socialTypes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SearchSocialType>? socialTypes)? loadInProgress,
    TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)?
        success,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (loadInProgress != null) {
      return loadInProgress(socialTypes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchInitial value) initial,
    required TResult Function(SearchLoadInProgress value) loadInProgress,
    required TResult Function(SearchSuccess value) success,
    required TResult Function(SearchFailure value) failure,
  }) {
    return loadInProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SearchInitial value)? initial,
    TResult Function(SearchLoadInProgress value)? loadInProgress,
    TResult Function(SearchSuccess value)? success,
    TResult Function(SearchFailure value)? failure,
  }) {
    return loadInProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchInitial value)? initial,
    TResult Function(SearchLoadInProgress value)? loadInProgress,
    TResult Function(SearchSuccess value)? success,
    TResult Function(SearchFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loadInProgress != null) {
      return loadInProgress(this);
    }
    return orElse();
  }
}

abstract class SearchLoadInProgress implements SearchState {
  const factory SearchLoadInProgress(List<SearchSocialType>? socialTypes) =
      _$SearchLoadInProgress;

  List<SearchSocialType>? get socialTypes;
  @JsonKey(ignore: true)
  $SearchLoadInProgressCopyWith<SearchLoadInProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchSuccessCopyWith<$Res> {
  factory $SearchSuccessCopyWith(
          SearchSuccess value, $Res Function(SearchSuccess) then) =
      _$SearchSuccessCopyWithImpl<$Res>;
  $Res call({List<SearchModel> list, List<SearchSocialType> socialTypes});
}

/// @nodoc
class _$SearchSuccessCopyWithImpl<$Res> extends _$SearchStateCopyWithImpl<$Res>
    implements $SearchSuccessCopyWith<$Res> {
  _$SearchSuccessCopyWithImpl(
      SearchSuccess _value, $Res Function(SearchSuccess) _then)
      : super(_value, (v) => _then(v as SearchSuccess));

  @override
  SearchSuccess get _value => super._value as SearchSuccess;

  @override
  $Res call({
    Object? list = freezed,
    Object? socialTypes = freezed,
  }) {
    return _then(SearchSuccess(
      list == freezed
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<SearchModel>,
      socialTypes == freezed
          ? _value.socialTypes
          : socialTypes // ignore: cast_nullable_to_non_nullable
              as List<SearchSocialType>,
    ));
  }
}

/// @nodoc

class _$SearchSuccess implements SearchSuccess {
  const _$SearchSuccess(this.list, this.socialTypes);

  @override
  final List<SearchModel> list;
  @override
  final List<SearchSocialType> socialTypes;

  @override
  String toString() {
    return 'SearchState.success(list: $list, socialTypes: $socialTypes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SearchSuccess &&
            const DeepCollectionEquality().equals(other.list, list) &&
            const DeepCollectionEquality()
                .equals(other.socialTypes, socialTypes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(list),
      const DeepCollectionEquality().hash(socialTypes));

  @JsonKey(ignore: true)
  @override
  $SearchSuccessCopyWith<SearchSuccess> get copyWith =>
      _$SearchSuccessCopyWithImpl<SearchSuccess>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<SearchSocialType>? socialTypes)
        loadInProgress,
    required TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)
        success,
    required TResult Function() failure,
  }) {
    return success(list, socialTypes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SearchSocialType>? socialTypes)? loadInProgress,
    TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)?
        success,
    TResult Function()? failure,
  }) {
    return success?.call(list, socialTypes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SearchSocialType>? socialTypes)? loadInProgress,
    TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)?
        success,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(list, socialTypes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchInitial value) initial,
    required TResult Function(SearchLoadInProgress value) loadInProgress,
    required TResult Function(SearchSuccess value) success,
    required TResult Function(SearchFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SearchInitial value)? initial,
    TResult Function(SearchLoadInProgress value)? loadInProgress,
    TResult Function(SearchSuccess value)? success,
    TResult Function(SearchFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchInitial value)? initial,
    TResult Function(SearchLoadInProgress value)? loadInProgress,
    TResult Function(SearchSuccess value)? success,
    TResult Function(SearchFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class SearchSuccess implements SearchState {
  const factory SearchSuccess(
          List<SearchModel> list, List<SearchSocialType> socialTypes) =
      _$SearchSuccess;

  List<SearchModel> get list;
  List<SearchSocialType> get socialTypes;
  @JsonKey(ignore: true)
  $SearchSuccessCopyWith<SearchSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchFailureCopyWith<$Res> {
  factory $SearchFailureCopyWith(
          SearchFailure value, $Res Function(SearchFailure) then) =
      _$SearchFailureCopyWithImpl<$Res>;
}

/// @nodoc
class _$SearchFailureCopyWithImpl<$Res> extends _$SearchStateCopyWithImpl<$Res>
    implements $SearchFailureCopyWith<$Res> {
  _$SearchFailureCopyWithImpl(
      SearchFailure _value, $Res Function(SearchFailure) _then)
      : super(_value, (v) => _then(v as SearchFailure));

  @override
  SearchFailure get _value => super._value as SearchFailure;
}

/// @nodoc

class _$SearchFailure implements SearchFailure {
  const _$SearchFailure();

  @override
  String toString() {
    return 'SearchState.failure()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SearchFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<SearchSocialType>? socialTypes)
        loadInProgress,
    required TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)
        success,
    required TResult Function() failure,
  }) {
    return failure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SearchSocialType>? socialTypes)? loadInProgress,
    TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)?
        success,
    TResult Function()? failure,
  }) {
    return failure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SearchSocialType>? socialTypes)? loadInProgress,
    TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)?
        success,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchInitial value) initial,
    required TResult Function(SearchLoadInProgress value) loadInProgress,
    required TResult Function(SearchSuccess value) success,
    required TResult Function(SearchFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SearchInitial value)? initial,
    TResult Function(SearchLoadInProgress value)? loadInProgress,
    TResult Function(SearchSuccess value)? success,
    TResult Function(SearchFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchInitial value)? initial,
    TResult Function(SearchLoadInProgress value)? loadInProgress,
    TResult Function(SearchSuccess value)? success,
    TResult Function(SearchFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class SearchFailure implements SearchState {
  const factory SearchFailure() = _$SearchFailure;
}
