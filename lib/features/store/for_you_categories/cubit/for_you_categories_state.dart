part of 'for_you_categories_cubit.dart';

@freezed
class ForYouCategoriesState with _$ForYouCategoriesState {
  const factory ForYouCategoriesState.initial() = _Initial;
  const factory ForYouCategoriesState.loadInProgress() = _LoadInProgress;
  const factory ForYouCategoriesState.success(
      List<ForYouCategoryResponse> list) = _Success;
  const factory ForYouCategoriesState.failure() = _Failure;
}


