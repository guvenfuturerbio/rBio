part of 'for_you_sub_category_detail_cubit.dart';

@freezed
class ForYouSubCategoryDetailState with _$ForYouSubCategoryDetailState {
    const factory ForYouSubCategoryDetailState.initial() = _Initial;
  const factory ForYouSubCategoryDetailState.loadInProgress() = _LoadInProgress;
  const factory ForYouSubCategoryDetailState.success(
      List<ForYouSubCategoryDetailResponse> list) = _Success;
  const factory ForYouSubCategoryDetailState.failure() = _Failure;
}
