part of 'for_you_sub_categories_cubit.dart';

@freezed
class ForYouSubCategoriesState with _$ForYouSubCategoriesState {
    const factory ForYouSubCategoriesState.initial() = _Initial;
  const factory ForYouSubCategoriesState.loadInProgress() = _LoadInProgress;
  const factory ForYouSubCategoriesState.success(
      List<ForYouCategoryResponse> list) = _Success;
  const factory ForYouSubCategoriesState.failure() = _Failure;
}
