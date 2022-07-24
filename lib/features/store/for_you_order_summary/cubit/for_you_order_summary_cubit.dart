import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../model/model.dart';

part 'for_you_order_summary_cubit.freezed.dart';
part 'for_you_order_summary_state.dart';

class ForYouOrderSummaryCubit extends Cubit<ForYouOrderSummaryState> {
  ForYouOrderSummaryCubit(this.repository)
      : super(const ForYouOrderSummaryState.initial());
  late final Repository repository;

  Future<void> fetchAll(String id) async {
    try {
      emit(const ForYouOrderSummaryState.loadInProgress());
      final subCategoryItems = await repository.getSubCategoryItems(id);
      emit(
        ForYouOrderSummaryState.success(
          ForYouOrderSummaryResult(
            subCategoryItems: subCategoryItems,
            selectedItem: subCategoryItems[0],
          ),
        ),
      );
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      emit(const ForYouOrderSummaryState.failure());
    }
  }

  void setSelectedIndex(int index) {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        emit(
          ForYouOrderSummaryState.success(
            result.copyWith(
              selectedIndex: index,
            ),
          ),
        );
      },
    );
  }

  void setSelectedItem(ForYouSubCategoryItemsResponse subCategoryItems) {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        emit(
          ForYouOrderSummaryState.success(
            result.copyWith(
              selectedItem: subCategoryItems,
            ),
          ),
        );
      },
    );
  }
}
