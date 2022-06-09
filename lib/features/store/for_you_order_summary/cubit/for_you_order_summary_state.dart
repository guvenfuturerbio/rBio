// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'for_you_order_summary_cubit.dart';

@freezed
class ForYouOrderSummaryState with _$ForYouOrderSummaryState {
  const factory ForYouOrderSummaryState.initial() = _Initial;
  const factory ForYouOrderSummaryState.loadInProgress() = _LoadInProgress;
  const factory ForYouOrderSummaryState.success(
      ForYouOrderSummaryResult result) = _Success;
  const factory ForYouOrderSummaryState.failure() = _Failure;
}

class ForYouOrderSummaryResult {
  final int? selectedIndex;
  final List<ForYouSubCategoryItemsResponse>? subCategoryItems;
  final ForYouSubCategoryItemsResponse? selectedItem;
  ForYouOrderSummaryResult({
    this.selectedIndex,
    this.subCategoryItems,
    this.selectedItem,
  });

  ForYouOrderSummaryResult copyWith({
    int? selectedIndex,
    List<ForYouSubCategoryItemsResponse>? subCategoryItems,
    ForYouSubCategoryItemsResponse? selectedItem,
  }) {
    return ForYouOrderSummaryResult(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      subCategoryItems: subCategoryItems ?? this.subCategoryItems,
      selectedItem: selectedItem ?? this.selectedItem,
    );
  }
}
